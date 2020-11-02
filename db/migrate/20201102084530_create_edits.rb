class CreateEdits < ActiveRecord::Migration[6.0]
  def change
    create_table :edits do |t|

      t.timestamps
    end
  end
end
