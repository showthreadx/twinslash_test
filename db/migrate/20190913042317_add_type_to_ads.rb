class AddTypeToAds < ActiveRecord::Migration[5.2]
  def change
    add_column :ads, :type, :string
  end
end
