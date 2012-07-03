class AddPeriodsToConfiguration < ActiveRecord::Migration
  def self.up
    add_column :configurations, :begin_period, :date
    add_column :configurations, :end_periods, :date
  end

  def self.down
    remove_column :configurations, :end_periods
    remove_column :configurations, :begin_period
  end
end
