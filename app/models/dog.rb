class Dog < ApplicationRecord
  has_many_attached :images
  belongs_to :user, required: false
end
