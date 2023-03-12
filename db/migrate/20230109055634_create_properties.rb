class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.string :name
      t.string :description
      t.string :address
      t.string :city
      t.integer :price

      t.timestamps
    end
  end
end
