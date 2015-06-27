class CreateCmnSentences < ActiveRecord::Migration
  def change
    create_table :cmn_sentences do |t|
      t.belongs_to :lexicon, index: true, foreign_key: true
      t.string :simplified
      t.string :traditional
      t.string :pinyin
      t.string :translation

      t.timestamps null: false
    end
  end
end
