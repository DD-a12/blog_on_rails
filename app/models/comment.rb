class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :post
    validates :body, presence: true
    validates :body, length: {minimum: 10}
end