class AddPaymentDetailsToProperties < ActiveRecord::Migration[7.0]
  def change
    add_column :properties, :is_paid , :boolean, :default => false
  end
end
