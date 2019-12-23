# frozen_string_literal: true

# sessions controller class
class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_mail(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id), notice: t('.success')
    else
      redirect_to login_path, alert: t('.error')
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: t('.logout')
  end
end
