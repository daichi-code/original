class CreateKokos < ActiveRecord::Migration[6.0]
  def change
    create_table :kokos do |t|

      t.string :introduce
      t.text :url
      t.integer :age_id
      t.integer :sex_id
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
