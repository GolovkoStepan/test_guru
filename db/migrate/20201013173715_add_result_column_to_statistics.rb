class AddResultColumnToStatistics < ActiveRecord::Migration[6.0]
  def change
    add_column :statistics, :result_rate, :integer
  end
end
