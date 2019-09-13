class AddStatusToAds < ActiveRecord::Migration[5.2]
  def change
    add_column :ads, :status, :integer
  end
end
