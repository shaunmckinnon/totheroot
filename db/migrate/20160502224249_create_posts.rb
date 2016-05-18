class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :category, index: true, foreign_key: true
      t.string :name
      t.string :synopsis
      t.text :content
      t.string :description

      t.timestamps null: false
    end
  end
end
