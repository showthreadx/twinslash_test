class CreateAds < ActiveRecord::Migration[5.2]
  def change
    create_table :ads do |t|
      t.string :title
      t.text :description
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
