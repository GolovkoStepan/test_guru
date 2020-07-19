class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :body, null: false # TODO: change to text
      # TODO: add image field
      t.belongs_to :test, null: false, foreign_key: true

      t.timestamps
    end
  end
end
