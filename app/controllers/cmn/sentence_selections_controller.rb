class Cmn::SentenceSelectionsController < ApplicationController
  before_action :set_selection
  before_action :set_sentences, only: [:add, :remove]

  def add
    added = @selection.add! @sentences

    flash[:success] = "Added #{added.count} sentences to selection."
    redirect_to request.referer
  end

  def remove
    removed = @selection.remove! @sentences

    flash[:success] = "Removed #{removed.count} sentences from selection."
    redirect_to request.referer
  end

  def clear
    @selection.destroy

    flash[:success] = "Selection cleared."
    redirect_to request.referer
  end

  def cancel_action
    @selection.action = nil
    @selection.save

    flash[:success] = "Selection action cancelled."
    redirect_to request.referer
  end


  private


    def set_selection
      @lexicon = Lexicon.find(params[:lexicon_id])
      @selection = current_user.sentence_selections.find_or_initialize_by(lexicon: @lexicon)
    end

    def set_sentences
      @sentences = @lexicon.sentences.where(id: (params[:sentence_ids] || []))
    end

end
