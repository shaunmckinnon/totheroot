class CreateEtsyDeets < ActiveRecord::Migration
  def change
    create_table :etsy_deets do |t|
      t.string :access_token
      t.string :access_secret

      t.timestamps null: false
    end
  end
end
