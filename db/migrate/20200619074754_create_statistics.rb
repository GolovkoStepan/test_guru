class CreateStatistics < ActiveRecord::Migration[6.0]
  def change
    create_table :statistics do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :test, null: false, foreign_key: true
      t.belongs_to :question, null: false, foreign_key: true
      t.integer :correct_answers, default: 0
      t.boolean :complete, default: false

      t.timestamps
    end
  end
end
