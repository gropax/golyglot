class Cmn::SentenceSelectionsController < Cmn::ResourceSelectionsController
  def resource_plural_name
    :sentences
  end

  private

    def previous_resource_selection_path
      session[:sentence_selection_path]
    end
end
