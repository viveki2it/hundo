class CreateProductsRecommenders < ActiveRecord::Migration
  def change
    create_table :products_recommenders do |t|
      t.integer :client_id
      t.integer :product_id
      t.integer :recommender_id
      t.timestamps
    end
  end
end
