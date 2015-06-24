class Cmn::LexicalEntriesController < ApplicationController
  include LexiconsHelper, LexicalEntriesHelper

  layout :compute_layout

  before_action :set_lexical_entry, only: [:show, :edit, :update, :destroy]
  before_action :set_parents
  before_action :set_lexical_entries, only: [:edit_multiple, :update_multiple, :destroy_multiple, :select_multiple, :deselect_multiple]

  before_action :set_representation, only: [:quick_create, :quick_new]

  before_action :set_selection, only: [:index, :quick_new, :selection, :select_multiple, :deselect_multiple, :clear_selection]

  before_action :remember_lexical_entry_collection_path, only: [:index, :quick_new, :selection]


  def index
    @query = params[:q]
    if @query.blank?
      # Show recently added entries
      @lexical_entries = @lexicon.lexical_entries.recent.page(params[:page]).per(5)
    else
      # Search entries
      @lexical_entries = Cmn::LexicalEntry.search {
        fulltext params[:q]
        with :lexicon_id, params[:lexicon_id]
        paginate :page => params[:page], :per_page => 5
      }.results
    end
  end

  def show
  end

  def new
    @lexical_entry = Cmn::LexicalEntry.new(lexicon: @lexicon)
  end

  def edit_multiple
  end

  def edit
  end

  def create
    @lexical_entry = Cmn::LexicalEntry.new(lexical_entry_params)
    if @lexical_entry.save
      flash[:success] = "Lexical entry successfuly created."
    else
      flash.now[:error] = "Unable to create lexical_entry."
    end
    redirect_to lexical_entry_path @lexical_entry
  end

  def update_multiple
    @lexical_entries.each do |lexical_entry|
      lexical_entry.update_attributes!(lexical_entry_params.reject { |k,v| v.blank? })
    end

    flash[:success] = "Updated #{@lexical_entries.count} lexical entries!"
    redirect_to previous_lexical_entry_collection_path
  end

  def update
    @lexical_entry.update(lexical_entry_params)
    if @lexical_entry.save
      flash[:success] = "Lexical Entry successfuly updated."
      redirect_to lexical_entry_path(@lexical_entry)
    else
      flash.now[:error] = "Unable to update lexical entry."
      render :edit
    end
  end

  def destroy_multiple
    count = @lexical_entries.count
    @lexical_entries.destroy_all

    flash[:success] = "Successfuly deleted #{count} sentences."
    redirect_to request.referer
  end

  def destroy
    @lexical_entry.destroy
    flash[:success] = "Lexical entry successfuly deleted."

    if path = previous_lexical_entry_collection_path
      # Redirect to last visited lexical entry collection page
      redirect_to path
    else
      redirect_to lexicon_lexical_entries_path(@lexicon)
    end
  end

  def quick_new
    @lexical_entries = @lexicon.lexical_entries.recent.page(params[:page]).per(5)
  end

  def quick_create
    @lexical_entry = Cmn::LexicalEntry.new(quick_lexical_entry_params)
    if @lexical_entry.save
      flash[:success] = "Sentence successfuly created."
    else
      flash.now[:error] = "Unable to create lexical_entry."
    end
    redirect_to request.referer
  end

  def selection
    respond_to do |format|
      format.html {
        @lexical_entries = @selection.lexical_entries.page(params[:page]).per(5)
      }
      format.csv { send_data @selection.to_csv }
    end
  end

  def select_multiple
    added = @selection.add! @lexical_entries

    flash[:success] = "Added #{added.count} lexical entries to selection."
    redirect_to request.referer
  end

  def deselect_multiple
    removed = @selection.remove! @lexical_entries

    flash[:success] = "Removed #{removed.count} lexical entries from selection."
    redirect_to request.referer
  end

  def clear_selection
    @selection.destroy

    flash[:success] = "Selection cleared."
    redirect_to request.referer
  end


  private

    def set_lexical_entry
      @lexical_entry = Cmn::LexicalEntry.find(params[:id])
    end

    def set_lexical_entries
      @lexical_entries = @lexicon.lexical_entries.where(id: (params[:lexical_entry_ids] || []))
    end

    def set_parents
      @lexicon = @lexical_entry ? @lexical_entry.lexicon : Cmn::Lexicon.find(params[:lexicon_id])
      @lexical_resource = @lexicon.lexical_resource
      @user = @lexical_resource.user
    end

    def set_selection
      @selection = current_user.lexical_entry_selections.find_or_initialize_by(lexicon: @lexicon)
    end

    def lexical_entry_params
      params.require(:lexical_entry).permit(:lexical_entry_type, :part_of_speech, :simplified, :traditional, :pinyin)
        .merge(lexicon: @lexicon)
    end

    REPRESENTATIONS = ['simplified', 'traditional', 'pinyin']

    def set_representation
      repr = params[:repr]
      if repr && REPRESENTATIONS.include?(repr)
        @representation = repr.to_sym
      elsif repr.blank?
        @representation = :simplified
      else
        raise RepresentationError, "Invalid Representation name: #{params[:repr]}"
      end
    end

    def quick_lexical_entry_params
      {@representation => params[:written_form], :lexicon => @lexicon}
    end


    def remember_lexical_entry_collection_path
      session[:lexical_entry_collection_path] = request.env['REQUEST_URI']
    end

    def previous_lexical_entry_collection_path
      session[:lexical_entry_collection_path]
    end
    helper_method :previous_lexical_entry_collection_path

    def compute_layout
      if ["show", "new", "edit", "edit_multiple"].include? action_name
        'lexicon'
      else
        'lexicon_lexical_entries'
      end
    end
end
