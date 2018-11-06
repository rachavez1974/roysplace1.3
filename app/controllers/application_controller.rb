class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def kuca
    render html: "Zdravo svet!"
  end
end
