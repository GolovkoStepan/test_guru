class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  has_many :questions, dependent: :destroy
  has_many :statistics, dependent: :destroy
  has_many :users, through: :statistics

  scope :easy, -> { where(level: 0..1) }
  scope :medium, -> { where(level: 2..4) }
  scope :hard, -> { where(level: 5..) }

  scope :by_category_title, lambda { |category_title|
    joins(:category).where(categories: { title: category_title })
  }

  scope :by_level, lambda { |level|
    where(level: level)
  }

  def self.titles_by_category(title:)
    by_category_title(title)
      .order('tests.title DESC')
      .pluck(:title)
  end
end
