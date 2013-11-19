class ProductsRecommender < ActiveRecord::Base
   attr_accessible :client_id, :product_id, :recommender_id
   belongs_to :client
   belongs_to :product
end
