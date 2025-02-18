class Product < ApplicationRecord
  has_many :reviews, -> { order("updated_at DESC") }, dependent: :destroy
  belongs_to :user

  has_many :favourites, dependent: :destroy
  has_many :favourite_users, through: :favourites, source: :user

    validates(:title,
            presence: { message: "Title must be provided" },
            :uniqueness => { :case_sensitive => false })
    validates :price, numericality: { greater_than: 0 }
    validates :description, presence: { message: "Description must be provided" }, length: { minimum: 10 }
    before_validation :set_default_price, :capitalize_title
    DEFAULT_PRICE = 1


    private

  def capitalize_title
    self.title.capitalize!
  end

  def set_default_price
      self.price ||= DEFAULT_PRICE
  end
end
