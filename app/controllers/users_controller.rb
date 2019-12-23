# frozen_string_literal: true

# controller for user management
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :current_user, only: :current
  before_action :authenticate, only: [:edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @events = @user.events.last(10)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    # @user.avatar.attach(io: File.open('./app/assets/images/logo2.png'), filename: 'logo2.png') unless @user.avatar.attached?
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: t('.success') }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: t('.success') }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    id = @user.id
    @user.destroy
    respond_to do |format|
      if id != @current_user.id
        format.html { redirect_to users_url, notice: t('.success') }
        format.json { head :no_content }
      else
        format.html { redirect_to logout_url, notice: t('.success') }
        format.json { session[:user_id] = nil; head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :surname, :mail, :password, :password_confirmation, :avatar)
    end
end
