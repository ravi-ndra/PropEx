class AddBuyerIdToProperties < ActiveRecord::Migration[7.0]
  def change
    add_column :properties, :buyer_id, :integer
  end
end
