class AddCategoryToAds < ActiveRecord::Migration[5.2]
  def change
    add_column :ads, :category, :string
  end
end
