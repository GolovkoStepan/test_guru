class CreateStatistics < ActiveRecord::Migration[6.0]
  def change
    create_table :statistics do |t|
      t.boolean :passed, default: false
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :test, null: false, foreign_key: true

      t.timestamps
    end
  end
end
