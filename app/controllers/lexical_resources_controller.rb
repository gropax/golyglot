class LexicalResourcesController < ApplicationController
  before_action :set_lexical_resource, except: [:index, :new, :create]
  before_action :set_user

  def index
    @lexical_resources = @user.lexical_resources
    nav :lexical_resources
    render layout: 'user_resources'
  end

  def show
    redirect_to lexical_resource_lexicons_path(@lexical_resource)
  end

  def new
    @lexical_resource = LexicalResource.new(user: @user)
  end

  def create
    @lexical_resource = LexicalResource.new(lexical_resource_params)
    if @lexical_resource.save
      flash[:success] = "Lexical Resource \"#{@lexical_resource.name}\" successfuly created."
      redirect_to user_lexical_resources_path(@user)
    else
      flash.now[:error] = "Cannot create Lexical Resource."
      render "new"
    end
  end

  private

    def set_lexical_resource
      @lexical_resource = LexicalResource.find(params[:id])
    end

    def set_user
      @user = @lexical_resource ? @lexical_resource.user : User.find(params[:user_id])
    end

    def lexical_resource_params
      params.require(:lexical_resource).permit(:name)
        .merge(user: @user)
    end
end
