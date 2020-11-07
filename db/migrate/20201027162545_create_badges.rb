class CreateBadges < ActiveRecord::Migration[6.0]
  def change
    create_table :badges do |t|
      t.string :name, null: false
      t.string :rule, null: false
      t.string :rule_value
      t.string :image

      t.timestamps
    end
  end
end
