# frozen_string_literal: true

# general application class
class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :full_name
  helper_method :initials
  before_action :set_locale
  protect_from_forgery with: :exception

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def full_name(user)
    user.name + ' ' + user.surname
  end

  def initials(user)
    user.name.slice(0, 1) + user.surname.slice(0, 1)
  end

  def authenticate
    unless current_user
      puts 'unauthorized!'
      redirect_to login_path, notice: t('require_login')
    end
  end
end
