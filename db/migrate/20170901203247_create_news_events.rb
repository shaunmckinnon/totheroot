class CreateNewsEvents < ActiveRecord::Migration
  def change
    create_table :news_events do |t|
      t.string :heading
      t.string :synopsis
      t.text :article
      t.json :tags
      t.date :publish_date

      t.timestamps null: false
    end
  end
end
