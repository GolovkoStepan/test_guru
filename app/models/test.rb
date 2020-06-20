class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  has_many :questions, dependent: :destroy
  has_many :statistics, dependent: :destroy
  has_many :users, through: :statistics

  def self.titles_by_category(title:)
    joins('JOIN categories ON tests.category_id = categories.id')
      .where(categories: { title: title })
      .order('tests.title DESC')
      .pluck(:title)
  end
end
