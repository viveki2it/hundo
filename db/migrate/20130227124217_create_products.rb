class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.text :product_internal_name
      t.text :product_external_name
      t.text :product_description
      t.string :sku
      t.integer :unit_price
      t.boolean :in_stock
      t.boolean :allow_express_shopping
      t.integer :express_shipping_price
      t.string :one_eight_hundred_number
      t.text :voice_generated_message
      t.text :sms
      t.string :forward_call_number
      t.integer :client_id
      t.integer :user_id
      t.timestamps
    end
  end
end
