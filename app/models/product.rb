class Product < ActiveRecord::Base

  attr_accessible :product_internal_name,:one_eight_hundred_number, :product_external_name, :product_description, :sku, :unit_price, :in_stock, :allow_express_shopping, :express_shipping_price, :voice_generated_message, :sms, :forward_call_number, :images_attributes,:parent_id,:area_code, :one_to_eight, :matching, :products_recommenders_attributes,:shipping_and_handling,:product_cost
  attr_accessor :area_code, :one_to_eight, :matching
  validates :product_internal_name, :presence => true
  validates :express_shipping_price,:shipping_and_handling,:product_cost,:unit_price,:area_code, :numericality => { :only_integer => true, :allow_blank => true }
  belongs_to :client
  has_many :images, :dependent => :destroy
  has_many :users, :dependent => :destroy
  has_many :products_recommenders, :dependent => :destroy
  accepts_nested_attributes_for  :images, :reject_if => lambda { |a| a[:image].blank? },  :allow_destroy  => true
  accepts_nested_attributes_for  :products_recommenders, :reject_if => lambda { |a| a[:image].blank? },  :allow_destroy  => true

  before_create :send_sms_and_voice_call

  def send_sms_and_voice_call
    #    puts "before create"
    @client = Twilio::REST::Client.new(TWILIO_SID, TWILIO_TOKEN)
    @numbers = []
    if self.one_to_eight == "1"
      @numbers = @client.account.available_phone_numbers.get('US').toll_free.list()
    else
      if (self.area_code.present? or self.matching.present?)
        if self.area_code.present?
          @numbers = @client.account.available_phone_numbers.get('US').toll_free.list(:area_code => "#{self.area_code}")
        elsif self.matching.present?
          @numbers = @client.account.available_phone_numbers.get('US').toll_free.list(:contains => "#{self.matching}")
        end
      elsif (self.area_code.present? and self.matching.present?)
        @numbers = @client.account.available_phone_numbers.get('US').toll_free.list(:area_code => "#{self.area_code}", :contains => "#{self.matching}")
      end
    end
    unless @numbers.length == 0
      @number = @numbers[0].phone_number
    end
    unless @number.nil? 
      @pur_number = @client.account.incoming_phone_numbers.create(:phone_number => @number, :voice_url => "#{BASE_URL}/product/1800response/#{@number}.xml")
    end
    self.one_eight_hundred_number = @pur_number.phone_number if @pur_number
  end
  
end

