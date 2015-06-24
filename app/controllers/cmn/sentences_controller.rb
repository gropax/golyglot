class Cmn::SentencesController < Cmn::LexiconResourcesController
  alias_method :previous_sentence_collection_path, :previous_resource_collection_path
  helper_method :previous_sentence_collection_path


  private

    def model
      Cmn::Sentence
    end

    def resource_params
      params.require(:sentence).permit(:simplified, :traditional, :pinyin)
        .merge(lexicon: @lexicon)
    end

end
