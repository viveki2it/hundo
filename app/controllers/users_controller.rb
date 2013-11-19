class UsersController < ApplicationController

  def create
    @user = User.new(params[:user])
    product = Product.find(params[:product_id])
    @user.product_id = product.id
    begin
      if @user.save
        redirect_to confirmation_user_path(@user.id)
      else
        render 'products/show'
      end
    rescue
      render 'products/show'
    end
  end

  def confirmation
    @user = User.find(params[:id])
    @recommenders = ProductsRecommender.where("recommender_id = #{@user.product_id}")
  end

  def user_details
   sql_query = "SELECT * from users where users.product_id IN (SELECT products.id from products where products.client_id = #{current_client.id})"
    @users = User.find_by_sql(sql_query)
    respond_to do |format|
      format.js
    end
  end

end
