class AddSuccessCompleteFieldToStatistics < ActiveRecord::Migration[6.0]
  def change
    add_column :statistics, :success_complete, :boolean, default: false
  end
end
