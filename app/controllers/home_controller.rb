class HomeController < ApplicationController

  def index
    @users = User.where(:product_id => Product.where(:client_id => current_client.id))
  end

end
