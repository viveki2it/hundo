class Image < ActiveRecord::Base
  attr_accessible :image, :product_id
  has_attached_file :image, :styles => {:medium => "300x300>", :thumb => "100x100>", :large => "500x500>"}
  validates_attachment_content_type :image, :content_type => [ 'image/jpeg','image/jpg', 'image/png', 'image/gif','image/bmp', 'image/x-png', 'image/pjpeg' ]
end
