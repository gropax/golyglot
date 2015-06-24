class CreateCmnExamples < ActiveRecord::Migration
  def change
    create_table :cmn_examples do |t|
      t.belongs_to :sense, index: true, foreign_key: true
      t.belongs_to :sentence, index: true, foreign_key: true
    end
  end
end
