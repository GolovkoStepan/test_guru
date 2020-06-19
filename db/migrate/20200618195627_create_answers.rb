class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.string :body
      t.belongs_to :question, null: false, foreign_key: true
      t.boolean :correct

      t.timestamps
    end
  end
end
