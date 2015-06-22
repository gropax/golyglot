class CreateLexicalEntrySelections < ActiveRecord::Migration
  def change
    create_table :lexical_entry_selections do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :lexicon, index: true, foreign_key: true
      t.text :lexical_entry_ids

      t.timestamps null: false
    end
  end
end
