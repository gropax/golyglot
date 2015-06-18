class UsersController < ApplicationController
  def index
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "You successfuly signed up."
      redirect_to root_url
    else
      flash.now[:error] = "Unable to sign up."
      render "new"
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
