class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :allow_without_password, only: [:update]
  before_action :authorize_admin

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    # TODO: don't send email notifications from admin interface

    respond_to do |format|
      if @user.save        
        flash[:notice] = "User was successfully created."
        format.html { redirect_to admin_user_url(@user) }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    # TODO: don't send email notifications from admin interface
    
    respond_to do |format|
      if @user.update(user_params)
        flash[:notice] = "User was successfully updated."
        format.html { redirect_to admin_user_url(@user) }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      flash[:alert] = "User was successfully destroyed."
      format.html { redirect_to admin_users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    # remove the need for providing a password when an admin is updating a user
    def allow_without_password
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
          params[:user].delete(:password)
          params[:user].delete(:password_confirmation)
      end
    end

    def authorize_admin
      return unless current_user.roles.find_by(name: "admin").nil?
      flash[:alert] = 'Only admins are authorized to access that page.'
      redirect_to "/"  # set to root path in the future
    end
end
