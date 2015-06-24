class Cmn::ResourceSelectionsController < ApplicationController
  before_action :set_selection
  before_action :set_resources, only: [:add, :remove]

  def add
    added = @selection.add! @resources

    flash[:success] = "Added #{added.count} sentences to selection."
    redirect_to request.referer
  end

  def remove
    removed = @selection.remove! @resources

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
      @selection = current_user.selections(resource_plural_name).find_or_initialize_by(lexicon: @lexicon)
    end

    def set_resources
      ids = params[:resource_ids] || params[:lexical_entry_ids] || params[:sentence_ids] || []
      @resources = @lexicon.send(resource_plural_name).where(id: ids)
    end

    def resource_plural_name
      raise NotImplementedError
    end

end
