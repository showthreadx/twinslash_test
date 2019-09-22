class CreateAds < ActiveRecord::Migration[5.2]
  def change
    create_table :ads do |t|
      t.string :title
      t.text :description
      t.belongs_to :user, foreign_key: true
      t.belongs_to :ad_type
      t.timestamps
    end
  end
end
