class Cmn::SensesController < ApplicationController
  include LexicalEntriesHelper, SentencesHelper, SensesHelper

  before_action :set_sense, except: :create
  before_action :set_parents
  before_action :set_sentence_selection, only: [:edit_examples, :examples]

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

  def edit_examples
    # Populate selection with sense's current sentences
    @selection.set @sense.sentences
    # Create a new action with url and message
    @selection.action.url = sense_examples_path(@sense)
    @selection.action.message = "examples for: #{@lexical_entry.simplified} #{@sense.description}"

    @selection.save
    redirect_to sentence_selection_path @lexicon
  end

  def examples
    sentences = Cmn::Sentence.find(params[:sentence_ids] || [])
    @sense.sentences = sentences
    if @sense.save
      @selection.action = nil
      @selection.save

      flash[:success] = "Examples successfuly updated."
    else
      flash.now[:error] = "Unable to update examples."
    end
    redirect_to sense_path @sense
  end

  private

    def set_sense
      @sense = Cmn::Sense.find(params[:id] || params[:sense_id])
    end

    def set_parents
      @lexical_entry = @sense ? @sense.lexical_entry : Cmn::LexicalEntry.find(params[:lexical_entry_id])
      @lexicon = @lexical_entry.lexicon
      @lexical_resource = @lexicon.lexical_resource
      @user = @lexical_resource.user
    end

    def set_sentence_selection
      @selection = current_user.sentence_selections.find_or_initialize_by(lexicon: @lexicon)
    end

    def sense_params
      params.require(:sense).permit(:description)
        .merge(lexical_entry: @lexical_entry)
    end
end
