class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.string :credit_card_name
      t.string :credit_card_number
      t.string :credit_card_cvv
      t.string :credit_card_expiration
      t.string :stripe_credit_card_token

      t.string :shipping_name
      t.string :shipping_address
      t.string :shipping_country
      t.string :shipping_zip

      t.boolean :is_billing_info
      t.string :billing_name
      t.string :billing_address
      t.string :billing_country
      t.string :billing_zip

      t.timestamps
    end
  end
end
