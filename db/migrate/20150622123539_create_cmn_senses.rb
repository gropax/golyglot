class CreateCmnSenses < ActiveRecord::Migration
  def change
    create_table :cmn_senses do |t|

      t.timestamps null: false
    end
  end
end
