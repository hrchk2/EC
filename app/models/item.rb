class Item < ApplicationRecord
  belongs_to :genre
  
  has_one_attached :image
  
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  
  def get_image
    (image.attached?) ? image : 'star-on.png'
  end
  
  def price_add_tax
     (self.price * 1.10).round
  end
end
