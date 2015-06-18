class CreateLexicalResources < ActiveRecord::Migration
  def change
    create_table :lexical_resources do |t|
      t.string :name
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
