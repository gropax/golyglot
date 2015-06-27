class Cmn::LexiconsController < ApplicationController
  include LexicalEntriesHelper

  before_action :set_lexicon, except: [:index, :new, :create]
  before_action :set_lexical_resource_and_user

  def show
    redirect_to lexical_entries_path(@lexicon)
  end

  private

    def set_lexicon
      @lexicon = Cmn::Lexicon.find(params[:id])
    end

    def set_lexical_resource_and_user
      @lexical_resource = @lexicon ? @lexicon.lexical_resource : LexicalResource.find(params[:lexical_resource_id])
      @user = @lexical_resource.user
    end
end
