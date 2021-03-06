class Product < ActiveRecord::Base

  default_scope { order(:title) }

  has_many :line_items
  before_destroy :ensure_not_reference

  validates :title, :description, :image_url, :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :title, :uniqueness => true

  private
    def ensure_not_reference
      if line_items.empty?
        return true
      else
        error.add(:base, "Line Items present")
        return false
      end
    end

end
