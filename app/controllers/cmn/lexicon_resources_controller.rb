class Cmn::LexiconResourcesController < ApplicationController
  include LexiconsHelper, LexiconResourcesHelper

  layout :compute_layout

  before_action :set_resource, only: [:show, :edit, :update, :destroy]
  before_action :set_parents
  before_action :set_resources, only: [:edit_multiple, :update_multiple, :destroy_multiple, :select_multiple, :deselect_multiple]

  before_action :set_representation, only: [:quick_create, :quick_new]

  before_action :set_selection, only: [:index, :quick_new, :selection, :select_multiple, :deselect_multiple, :clear_selection]

  before_action :remember_resource_collection_path, only: [:index, :quick_new, :selection]


  def index
    @query = params[:q]
    if @query.blank?
      # Show recently added entries
      self.resources = @lexicon.send(resource_plural_name)
        .recent.page(params[:page]).per(5)
    else
      # Search entries
      self.resources = model.search {
        fulltext params[:q]
        with :lexicon_id, params[:lexicon_id]
        paginate :page => params[:page], :per_page => 5
      }.results
    end
    render layout: 'lexicon_resources/search'
  end

  def show
  end

  def new
    self.resource = model.new(lexicon: @lexicon)
  end

  def edit_multiple
  end

  def edit
  end

  def create
    self.resource = model.new(resource_params)
    if @resource.save
      flash[:success] = "Lexical entry successfuly created."
    else
      flash.now[:error] = "Unable to create lexical_entry."
    end
    redirect_to resource_path(@resource, resource_singular_name)
  end

  def update_multiple
    @resources.each do |resource|
      resource.update_attributes!(resource_params.reject { |k,v| v.blank? })
    end

    flash[:success] = "Updated #{@resources.count} lexical entries!"
    redirect_to previous_resource_collection_path
  end

  def update
    @resource.update(resource_params)
    if @resource.save
      flash[:success] = "Lexical Entry successfuly updated."
      redirect_to resource_path(@resource, resource_singular_name)
    else
      flash.now[:error] = "Unable to update lexical entry."
      render :edit
    end
  end

  def destroy_multiple
    count = @resources.count
    @resources.destroy_all

    flash[:success] = "Successfuly deleted #{count} sentences."
    redirect_to request.referer
  end

  def destroy
    @resource.destroy
    flash[:success] = "Lexical entry successfuly deleted."

    if path = previous_resource_collection_path
      # Redirect to last visited lexical entry collection page
      redirect_to path
    else
      redirect_to resources_path(@lexicon, resource_plural_name)
    end
  end

  def quick_new
    self.resources = @lexicon.send(resource_plural_name)
      .recent.page(params[:page]).per(5)

    render layout: 'lexicon_resources/quick_new'
  end

  def quick_create
    self.resource = model.new(quick_resource_params)
    if @resource.save
      flash[:success] = "Sentence successfuly created."
    else
      flash.now[:error] = "Unable to create lexical entry."
    end
    redirect_to request.referer
  end

  def selection
    respond_to do |format|
      format.html {
        self.resources = @selection.send(resource_plural_name)
          .page(params[:page]).per(5)

        render layout: 'lexicon_resources/selection'
      }
      format.csv { send_data @selection.to_csv }
    end
  end

  def select_multiple
    added = @selection.add! @resources

    flash[:success] = "Added #{added.count} lexical entries to selection."
    redirect_to request.referer
  end

  def deselect_multiple
    removed = @selection.remove! @resources

    flash[:success] = "Removed #{removed.count} lexical entries from selection."
    redirect_to request.referer
  end

  def clear_selection
    @selection.destroy

    flash[:success] = "Selection cleared."
    redirect_to request.referer
  end


  private

    def set_resource
      self.resource = model.find(params[:id])
    end

    def set_resources
      ids = params[:resource_ids] || params[:lexical_entry_ids] || params[:sentence_ids] || []
      self.resources = @lexicon.send(resource_plural_name).where(id: ids)
    end

    def set_parents
      @lexicon = @resource ? @resource.lexicon : Lexicon.find(params[:lexicon_id])
      @lexical_resource = @lexicon.lexical_resource
      @user = @lexical_resource.user
    end

    def set_selection
      @selection = current_user.selections(resource_plural_name)
        .find_or_initialize_by(lexicon: @lexicon)
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

    def quick_resource_params
      {@representation => params[:written_form], :lexicon => @lexicon}
    end


    def remember_resource_collection_path
      session[:resource_collection_path] = request.env['REQUEST_URI']
    end

    def previous_resource_collection_path
      session[:resource_collection_path]
    end
    helper_method :previous_resource_collection_path


    def compute_layout
      if ["show", "new", "edit", "edit_multiple"].include? action_name
        'lexicon'
      else
        'lexicon_' + resource_plural_name
      end
    end


    def model
      raise NotImplementedError
    end

    def resource_params
      raise NotImplementedError
    end

    def resource=(res)
      @lexical_entry = @sentence = @resource = res
    end

    def resources=(res)
      @lexical_entries = @sentences = @resources = res
    end

    def resource_plural_name
      controller_name
    end

    def resource_singular_name
      resource_plural_name.singularize
    end

    def resource_type
      resource_plural_name.to_sym
    end
    helper_method :resource_type

end
