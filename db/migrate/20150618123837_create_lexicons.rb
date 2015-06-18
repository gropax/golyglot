class CreateLexicons < ActiveRecord::Migration
  def change
    create_table :lexicons do |t|
      t.string :name
      t.belongs_to :lexical_resource, index: true, foreign_key: true
      t.string :type

      t.timestamps null: false
    end
  end
end
