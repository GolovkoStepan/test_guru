class CreateGists < ActiveRecord::Migration[6.0]
  def change
    create_table :gists do |t|
      t.belongs_to :user, null: false, foreign_key: true, index: true
      t.belongs_to :question, null: false, foreign_key: true, index: true
      t.string :url, null: false
      t.string :gist_id, null: false

      t.timestamps
    end
  end
end
