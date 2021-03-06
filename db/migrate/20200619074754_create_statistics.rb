class CreateStatistics < ActiveRecord::Migration[6.0]
  def change
    create_table :statistics do |t|
      t.belongs_to :user, null: false, foreign_key: true, index: true
      t.belongs_to :test, null: false, foreign_key: true, index: true
      t.belongs_to :question, foreign_key: true
      t.integer :correct_answers, default: 0

      t.timestamps
    end
  end
end
