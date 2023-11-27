class PagesController < ApplicationController
  # index is a public page
  def index
  end

  # anya is a private page, only anya can enter
  def anya
    if current_user != 'anya'
      render plain: '401 Unauthorized', status: :unauthorized
    end
  end
end