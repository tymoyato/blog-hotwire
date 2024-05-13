class Post < ApplicationRecord
  belongs_to :user
  has_many :taggeds
  has_many :tags, through: :taggeds

  validates :title, :body, presence: true
end
