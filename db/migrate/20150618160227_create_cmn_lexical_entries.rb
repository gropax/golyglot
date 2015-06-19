class CreateCmnLexicalEntries < ActiveRecord::Migration
  def change
    create_table :cmn_lexical_entries do |t|
      t.belongs_to :lexicon, index: true, foreign_key: true
      t.integer :lexical_entry_type
      t.integer :part_of_speech
      t.string :simplified
      t.string :traditional
      t.string :pinyin

      t.timestamps null: false
    end
  end
end
