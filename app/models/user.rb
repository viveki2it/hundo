class User < ActiveRecord::Base

  attr_accessible :credit_card_name, :credit_card_number, :credit_card_cvv, :credit_card_expiration, :stripe_credit_card_token,
    :shipping_name, :shipping_address, :shipping_country, :shipping_zip,
    :is_billing_info,:billing_name, :billing_address, :billing_country, :billing_zip

  attr_accessor :stripe_credit_card

 
  validates :credit_card_name, :credit_card_number, :credit_card_cvv, :credit_card_expiration, :stripe_credit_card_token,
    :shipping_name, :shipping_address, :shipping_country, :shipping_zip, :presence => true

  validates :billing_name, :billing_address, :billing_country, :billing_zip, :presence => true, :if => :is_billing_info
  
  belongs_to :product

  
   


  after_create {|user|
    begin
      Stripe::Charge.create(
        :amount => (1 * 100).to_i,
        :currency => "usd",
        :card => user.stripe_credit_card_token,
        :description => "WaxVac payment"
      )
    rescue Exception => e
      self.clear_stripe_info
      user.errors[:stripe_credit_card] << "Invalid credit card."
      raise
    end

  }


  def clear_stripe_info
    self.stripe_credit_card = nil
    self.stripe_credit_card_token = nil
  end

  def stripe_credit_card
    return @stripe_credit_card if @stripe_credit_card
    @stripe_credit_card = Stripe::Token.retrieve(stripe_credit_card_token).card unless stripe_credit_card_token.blank?
  end

  def self.total_grouped_by_day(start)
    users = where(created_at: start.beginning_of_day..Time.zone.now)
    users = users.group("date(created_at)")
    users = users.count
  end

end
