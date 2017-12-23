class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :customer_name
      t.integer :type_id
      t.decimal :quantity, precision: 4, scale: 2
      t.string :address

      t.timestamps
    end
  end
end
