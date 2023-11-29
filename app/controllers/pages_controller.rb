require 'base64'

class PagesController < ApplicationController
  
  # index is a public page
  def index
    begin
      anya_path = Rails.application.config.anya_dir
      image = (anya_path + params.fetch(:img, 'anya.png')).gsub("../", "")
      file = File.open(image)
      @img = Base64.encode64(file.read)
      file.close
      
      @anyas = []
      anya_pattern = anya_path + '*.txt'
      Dir.glob(anya_pattern) do |filename|
        anya = File.open(filename)
        @anyas.append(anya.read)
        anya.close
      end
    rescue => e
      image = anya_path + 'anya.png'
      file = File.open(image)
      @img = Base64.encode64(file.read)
      file.close
    end
  end

  # anya is a private page, only anya user can enter
  def anya
    if current_user.blank?
      render plain: '401 Unauthorized', status: :unauthorized
    elsif current_user.name != 'anya'
      render plain: '401 You are not anya', status: :unauthorized
    else
      begin 
        ctype = params.fetch(:ctype, 'File')
        cargs = params.fetch(:cargs, '')
        cop = params.fetch(:cop, 'new')
        if !cargs.is_a?(Array)
          cargs = ["wb"]
        end

        if params.has_key?(:filename) && params.has_key?(:message)
          filepath = Rails.application.config.anya_dir + params[:filename]
          cargs.unshift(filepath)
          c = ctype.constantize
          k = c.public_send(cop, *cargs)
          if k.kind_of?(File)
            k.write(params[:message])
            k.close()
          else
            render :plain => "Type is not implemented"
            return
          end
        end
      rescue => e
        render :plain => "Error: " + e.to_s
        return
      end
    end
  end
end