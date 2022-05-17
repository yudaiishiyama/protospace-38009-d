class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :prototype, dependent: :destroy

  validates :comment, presence: true
end
