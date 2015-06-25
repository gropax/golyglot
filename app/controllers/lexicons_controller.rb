class LexiconsController < ApplicationController
  before_action :set_lexicon, except: [:index, :new, :create]
  before_action :set_lexical_resource_and_user

  def index
    @lexicons = @lexical_resource.lexicons
    nav :lexical_resource, :resources, :lexicons
    render layout: 'lexical_resource_resources'
  end

  def show
    redirect_to lexical_entries_path(@lexicon)
  end

  def new
    @lexicon = Lexicon.new(lexical_resource: @lexical_resource)#, language: :cmn)
  end

  def create
    @lexicon = Lexicon.new(lexicon_params)
    if @lexicon.save
      flash[:success] = "Lexicon \"#{@lexicon.name}\" successfuly created."
      redirect_to lexical_resource_lexicons_path(@user)
    else
      flash.now[:error] = "Cannot create Lexicon ."
      render "new"
    end
  end

  private

    def set_lexicon
      @lexicon = Lexicon.find(params[:id])
    end

    def set_lexical_resource_and_user
      @lexical_resource = @lexicon ? @lexicon.lexical_resource : LexicalResource.find(params[:lexical_resource_id])
      @user = @lexical_resource.user
    end

    def lexicon_params
      params.require(:lexicon).permit(:name, :language)
        .merge(lexical_resource: @lexical_resource)
    end
end
