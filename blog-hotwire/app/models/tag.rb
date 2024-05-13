class Tag < ApplicationRecord
  has_many :taggeds
  has_many :posts, through: :taggeds
end
