class Cmn::LexicalEntriesController < Cmn::LexiconResourcesController
  alias_method :previous_lexical_entry_collection_path, :previous_resource_collection_path
  helper_method :previous_lexical_entry_collection_path


  private

    def model
      Cmn::LexicalEntry
    end

    def resource_params
      params.require(:lexical_entry).permit(:lexical_entry_type, :part_of_speech, :simplified, :traditional, :pinyin)
        .merge(lexicon: @lexicon)
    end

end
