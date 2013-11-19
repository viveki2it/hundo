class AddShippindAddHandlingAddProductCostToProducts < ActiveRecord::Migration
  def change
    add_column :products, :shipping_and_handling, :integer
    add_column :products, :product_cost, :integer
  end
end
