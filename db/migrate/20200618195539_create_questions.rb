class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :body, null: false
      t.belongs_to :test, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
