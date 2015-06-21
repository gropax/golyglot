class Cmn::LexicalEntriesController < ApplicationController
  include LexiconsHelper, LexicalEntriesHelper

  before_action :set_lexical_entry, only: [:show, :edit, :update, :destroy]
  before_action :set_lexicon
  before_action :set_lexical_resource_and_user
  before_action :set_representation, only: [:quick_create, :quick_new]

 def index
    remember_lexical_entry_collection_path!

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

    nav :lexicon, :resources, :lexical_entries
    render layout: 'lexicon_resources'
  end

  def show
    nav :lexicon, :resources
    render layout: 'lexicon'
  end

  def new
    @lexical_entry = Cmn::LexicalEntry.new(lexicon: @lexicon)

    nav :lexicon, :resources
    render layout: 'lexicon'
  end

  def create
    @lexical_entry = Cmn::LexicalEntry.new(lexical_entry_params)
    if @lexical_entry.save
      flash[:success] = "Sentence successfuly created."
    else
      flash.now[:error] = "Unable to create lexical_entry."
    end
    redirect_to lexical_entry_path @lexical_entry
  end

  def quick_new
    remember_lexical_entry_collection_path!

    @lexical_entries = @lexicon.lexical_entries.recent.page(params[:page]).per(5)

    nav :lexicon, :resources, :lexical_entries
    render layout: 'lexicon_resources'
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

  def edit_multiple
    @lexical_entries = @lexicon.lexical_entries.find(params[:lexical_entry_ids])
    nav :lexicon, :resources
    render layout: 'lexicon'
  end

  def edit
    nav :lexicon, :resources
    render layout: 'lexicon'
  end

  def update_multiple
    @lexical_entries = @lexicon.lexical_entries.find(params[:lexical_entry_ids])
    @lexical_entries.each do |lexical_entry|
      lexical_entry.update_attributes!(lexical_entry_params.reject { |k,v| v.blank? })
    end

    flash[:success] = "Updated #{@lexical_entries.count} lexical entries!"
    redirect_to quick_new_lexicon_lexical_entries_path(@lexicon)
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
    @lexical_entries = @lexicon.lexical_entries.where({id: params[:lexical_entry_ids]})
    nb = @lexical_entries.count
    @lexical_entries.destroy_all

    flash[:success] = "Successfuly deleted #{nb} sentences."
    redirect_to request.referer
  end

  def destroy
    @lexical_entry.destroy
    flash[:success] = "Sentence successfuly deleted."

    if session[:lexical_entries_page]
      # Redirect to last visited lexical entry collection page
      redirect_to session[:lexical_entries_page]
    else
      redirect_to lexicon_lexical_entries_path(@lexicon)
    end
  end


  private

    def set_lexical_entry
      @lexical_entry = Cmn::LexicalEntry.find(params[:id])
    end

    def set_lexicon
      @lexicon = @lexical_entry ? @lexical_entry.lexicon : Cmn::Lexicon.find(params[:lexicon_id])
    end

    def set_lexical_resource_and_user
      @lexical_resource = @lexicon ? @lexicon.lexical_resource : LexicalResource.find(params[:lexical_resource_id])
      @user = @lexical_resource.user
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

    def remember_lexical_entry_collection_path!
      session[:lexical_entry_collection_path] = request.env['REQUEST_URI']
    end

    helper_method :previous_lexical_entry_collection_path

    def previous_lexical_entry_collection_path
      session[:lexical_entry_collection_path]
    end
end
