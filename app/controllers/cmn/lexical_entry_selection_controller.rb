class Cmn::LexicalEntrySelectionController < ApplicationController
  before_action :set_selection
  before_action :set_lexical_entries, only: [:add, :remove]

  def add
    added = @selection.add! @lexical_entries

    flash[:success] = "Added #{added.count} lexical entries to selection."
    redirect_to request.referer
  end

  def remove
    removed = @selection.remove! @lexical_entries

    flash[:success] = "Removed #{removed.count} lexical entries from selection."
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
      @selection = current_user.lexical_entry_selections.find_or_initialize_by(lexicon: @lexicon)
    end

    def set_lexical_entries
      @lexical_entries = @lexicon.lexical_entries.where(id: (params[:lexical_entry_ids] || []))
    end

end
