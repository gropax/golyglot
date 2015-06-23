class Cmn::SentencesController < ApplicationController
  include LexiconsHelper, SentencesHelper

  before_action :set_sentence, only: [:show, :edit, :update, :destroy]
  before_action :set_lexicon
  before_action :set_lexical_resource_and_user
  before_action :set_selection, only: [:index, :quick_new, :selection, :select_multiple, :deselect_multiple, :clear_selection]
  before_action :set_representation, only: [:quick_create, :quick_new]

 def index
    remember_sentence_collection_path!

    @query = params[:q]
    if @query.blank?
      # Show recently added entries
      @sentences = @lexicon.sentences.recent.page(params[:page]).per(5)
    else
      # Search entries
      @sentences = Cmn::Sentence.search {
        fulltext params[:q]
        with :lexicon_id, params[:lexicon_id]
        paginate :page => params[:page], :per_page => 5
      }.results
    end

    nav :lexicon, :sentences, :search
    render layout: 'lexicon_sentences'
  end

  def show
    nav :lexicon, :sentences
    render layout: 'lexicon'
  end

  def new
    @sentence = Cmn::Sentence.new(lexicon: @lexicon)

    nav :lexicon, :sentences
    render layout: 'lexicon'
  end

  def create
    @sentence = Cmn::Sentence.new(sentence_params)
    if @sentence.save
      flash[:success] = "Sentence successfuly created."
    else
      flash.now[:error] = "Unable to create sentence."
    end
    redirect_to sentence_path @sentence
  end

  def quick_new
    remember_sentence_collection_path!

    @sentences = @lexicon.sentences.recent.page(params[:page]).per(5)

    nav :lexicon, :sentences, :create
    render layout: 'lexicon_sentences'
  end

  def quick_create
    @sentence = Cmn::Sentence.new(quick_sentence_params)
    if @sentence.save
      flash[:success] = "Sentence successfuly created."
    else
      flash.now[:error] = "Unable to create sentence."
    end
    redirect_to request.referer
  end

  def edit_multiple
    @sentences = @lexicon.sentences.find(params[:sentence_ids])
    nav :lexicon, :sentences
    render layout: 'lexicon'
  end

  def edit
    nav :lexicon, :sentences
    render layout: 'lexicon'
  end

  def update_multiple
    @sentences = @lexicon.sentences.find(params[:sentence_ids])
    @sentences.each do |sentence|
      sentence.update_attributes!(sentence_params.reject { |k,v| v.blank? })
    end

    flash[:success] = "Updated #{@sentences.count} sentences!"
    redirect_to previous_sentence_collection_path
  end

  def update
    @sentence.update(sentence_params)
    if @sentence.save
      flash[:success] = "Sentence successfuly updated."
      redirect_to sentence_path(@sentence)
    else
      flash.now[:error] = "Unable to update sentence."
      render :edit
    end
  end

  def destroy_multiple
    @sentences = @lexicon.sentences.where({id: params[:sentence_ids]})
    nb = @sentences.count
    @sentences.destroy_all

    flash[:success] = "Successfuly deleted #{nb} sentences."
    redirect_to request.referer
  end

  def destroy
    @sentence.destroy
    flash[:success] = "Sentence successfuly deleted."

    if path = previous_sentence_collection_path
      # Redirect to last visited sentence collection page
      redirect_to path
    else
      redirect_to lexicon_sentences_path(@lexicon)
    end
  end

  def selection
    respond_to do |format|
      format.html do
        remember_sentence_collection_path!
        @sentences = @selection.sentences.page(params[:page]).per(5)

        nav :lexicon, :sentences, :selection
        render layout: 'lexicon_sentences'
      end

      format.csv { send_data @selection.to_csv }
    end
  end

  def select_multiple
    @sentences = @lexicon.sentences.find(params[:sentence_ids])
    added = @selection.add! @sentences

    flash[:success] = "Added #{added.count} sentences to selection."
    redirect_to request.referer
  end

  def deselect_multiple
    @sentences = @lexicon.sentences.find(params[:sentence_ids])
    removed = @selection.remove! @sentences

    flash[:success] = "Removed #{removed.count} sentences from selection."
    redirect_to request.referer
  end

  def clear_selection
    @selection.destroy

    flash[:success] = "Selection cleared."
    redirect_to request.referer
  end


  private

    def set_sentence
      @sentence = Cmn::Sentence.find(params[:id])
    end

    def set_lexicon
      @lexicon = @sentence ? @sentence.lexicon : Cmn::Lexicon.find(params[:lexicon_id])
    end

    def set_lexical_resource_and_user
      @lexical_resource = @lexicon ? @lexicon.lexical_resource : LexicalResource.find(params[:lexical_resource_id])
      @user = @lexical_resource.user
    end

    def set_selection
      @selection = current_user.sentence_selections.find_or_initialize_by(lexicon: @lexicon)
    end

    def sentence_params
      params.require(:sentence).permit(:simplified, :traditional, :pinyin)
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

    def quick_sentence_params
      {@representation => params[:written_form], :lexicon => @lexicon}
    end

    def remember_sentence_collection_path!
      session[:sentence_collection_path] = request.env['REQUEST_URI']
    end

    helper_method :previous_sentence_collection_path

    def previous_sentence_collection_path
      session[:sentence_collection_path]
    end
end
