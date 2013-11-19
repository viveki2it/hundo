require 'twilio-ruby' 
class ProductsController < ApplicationController

  def new
    @product = Product.new
    5.times { @product.images.build }
    respond_to do |format|
      format.js 
    end
  end

  def create
    @product = Product.new(params[:product])
    @product.client_id = current_client.id
    if @product.save
      if !params[:product][:products_recommenders_attributes].nil?
        params[:product][:products_recommenders_attributes].each do |recom|
          ProductsRecommender.create(:product_id =>recom[1].first[1],:client_id =>@product.client_id, :recommender_id => @product.id)
        end
      end
      @status = true
      flash[:notice] = "Product was successfully created."
      redirect_to products_path
    else
      @status = false
      if @product.images.blank?
        5.times { @product.images.build }
      end
      respond_to do |format|
        format.js
      end
    end
  end

  def edit
    @product = Product.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      @status = true
    else
      @status = false
      respond_to do |format|
        format.js
      end
    end
  end
  
  def index
    @products = current_client.products
    if request.xhr?
      respond_to do |format|
        format.js
      end
    end
  end

  def product_details
    @product = Product.find(params[:id])
  end

  def get_xml_product_details
    @product = Product.find_by_one_eight_hundred_number(params[:one_eight_hundred_number])
    @client = Twilio::REST::Client.new(TWILIO_SID, TWILIO_TOKEN)
    if params[:Caller].present?
      @client.account.sms.messages.create(:body => "#{@product.sms.to_s} #{BASE_URL}products/#{@product.id.to_s}##{params[:Caller]} Reply STOP to stop.",
        :to =>  params[:Caller],
        :from =>  "+19726462066")
    end
    render 'get_xml_product_details.xml.erb', :content_type => 'text/xml'
  end

  def show
    @product = Product.find(params[:id])
  end
end
