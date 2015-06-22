class CreateSenses < ActiveRecord::Migration
  def change
    create_table :senses do |t|
      t.belongs_to :lexical_entry, index: true, foreign_key: true
      t.string :description

      t.timestamps null: false
    end
  end
end
