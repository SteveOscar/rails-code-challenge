class AddAttributesToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :expedited, :boolean, default: false
    add_column :orders, :returnable, :boolean, default: false
    add_column :orders, :warehoused, :boolean, default: false
  end
end
