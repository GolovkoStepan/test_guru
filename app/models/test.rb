class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  has_many :questions, dependent: :destroy
  has_many :statistics, dependent: :destroy
  has_many :users, through: :statistics

  scope :titles_by_category, lambda { |title|
    Category.find_by(title: title)
            .tests
            .order('title DESC')
            .pluck(:title)
  }
end
