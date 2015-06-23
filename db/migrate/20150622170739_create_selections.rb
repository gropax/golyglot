class CreateSelections < ActiveRecord::Migration
  def change
    create_table :selections do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :lexicon, index: true, foreign_key: true
      t.text :resource_ids
      t.string :type
    end
  end
end
