class AllBook < ApplicationRecord
  belongs_to :user
  validates :image, presence: true, uniqueness: true
end
