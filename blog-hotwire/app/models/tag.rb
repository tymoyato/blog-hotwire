# frozen_string_literal: true

# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tag < ApplicationRecord
  has_many :taggeds, dependent: :destroy
  has_many :posts, through: :taggeds

  validates :name, uniqueness: true, presence: true, length: { maximum: 50 }
end
