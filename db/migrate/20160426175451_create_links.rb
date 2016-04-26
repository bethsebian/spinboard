class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url
      t.string :title
      t.boolean :read_status
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
