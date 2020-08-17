class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.string :body, null: false
      t.belongs_to :question, null: false, foreign_key: true, index: true
      t.boolean :correct, default: false

      t.timestamps
    end
  end
end
