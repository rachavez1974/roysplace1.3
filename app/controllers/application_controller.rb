class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def kuca
    render html: "Zdravo svet!"
  end
end