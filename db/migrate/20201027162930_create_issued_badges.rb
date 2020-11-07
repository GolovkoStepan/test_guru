class CreateIssuedBadges < ActiveRecord::Migration[6.0]
  def change
    create_table :issued_badges do |t|
      t.belongs_to :badge, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :statistic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
