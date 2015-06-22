class Cmn::SensesController < ApplicationController
  include LexicalEntriesHelper, SensesHelper

  before_action :set_sense, only: [:show, :edit, :update, :destroy]
  before_action :set_parents

  def show
    nav :lexicon, :lexical_entries
    render layout: 'lexicon'
  end

  def create
    @sense = Cmn::Sense.new(sense_params)
    if @sense.save
      flash[:success] = "Sense successfuly created."
    else
      flash.now[:error] = "Unable to create sense."
    end
    redirect_to lexical_entry_path @lexical_entry
  end

  private

    def set_sense
      @sense = Cmn::Sense.find(params[:id])
    end

    def set_parents
      @lexical_entry = @sense ? @sense.lexical_entry : Cmn::LexicalEntry.find(params[:lexical_entry_id])
      @lexicon = @lexical_entry.lexicon
      @lexical_resource = @lexicon.lexical_resource
      @user = @lexical_resource.user
    end

    def sense_params
      params.require(:sense).permit(:description)
        .merge(lexical_entry: @lexical_entry)
    end
end
