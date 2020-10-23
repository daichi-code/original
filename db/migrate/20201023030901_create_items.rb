class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|

      t.string :title
      t.text :text
      t.integer :season_id
      t.integer :category_id
      t.integer :prefecture_id
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
