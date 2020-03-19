class Post < ApplicationRecord
    belongs_to :user
    validates :title, presence: true
    validates :title, uniqueness: true
    validates :body, presence: true
    validates :body, length: {minimum: 50}
    has_many :comments, dependent: :destroy
end
