class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_name(params[:name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "You successfuly logged in as #{user.name}."
      redirect_to root_url
    else
      flash.now[:error] = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You successfuly logged out."
    redirect_to root_url
  end

  private

    def user_params
      params.require(:user).permit(:email, :password)
    end
end
