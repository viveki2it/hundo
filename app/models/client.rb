class Client < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable#, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :avatar, :description, :product_id
  # attr_accessible :title, :body
  validates :name, :presence => true
  has_attached_file :avatar, :styles => {:medium => "300x300>", :thumb => "100x100>"}
  validates_attachment_content_type :avatar, :content_type => [ 'image/jpeg','image/jpg', 'image/png', 'image/gif','image/bmp', 'image/x-png', 'image/pjpeg' ]
  has_many :products, :dependent => :destroy
  has_many :products_recommenders, :dependent => :destroy
end
