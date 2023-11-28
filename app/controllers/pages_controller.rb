require 'base64'

class PagesController < ApplicationController
  # index is a public page
  def index
    image = params.fetch(:img, 'anya.png')
    file = File.open(image)
    @img = Base64.encode64(file.read)
    file.close
  end

  # anya is a private page, only anya user can enter
  def anya
    if current_user.blank?
      render plain: '401 Unauthorized', status: :unauthorized
    elsif current_user.name != 'anya'
      render plain: '401 You are not anya', status: :unauthorized
    end
  end
end