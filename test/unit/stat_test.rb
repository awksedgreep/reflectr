require 'test_helper'
require 'SNMP4JR'

class StatTest < ActiveSupport::TestCase
  fixtures :all
    
  # Replace this with your real tests.
  test "process string" do
    assert device = Device.find(:last)
    assert_not_nil device
    assert_kind_of Device, device
    assert pollgroup = Pollgroup.where(:name => 'HornetQ JMX Metrics').first
    assert_not_nil pollgroup
    assert_kind_of Pollgroup, pollgroup
    assert datatype = DataType.where(:name => 'Text').first
    assert_not_nil datatype
    assert_kind_of DataType, datatype
    assert metric = Metric.create(:pollgroup => pollgroup, :data_type => datatype, :port => 1090, :property => 'TestText', :name => 'Test Text')
    assert_not_nil metric
    assert_kind_of Metric, metric
    assert all_stats = Stat.where(:device_id => device.id, :metric_id => metric.id)
    assert_kind_of ActiveRecord::Relation, all_stats
    assert_nil all_stats.first
    assert stat = Stat.process(:metric => metric, :device => device, :value => 'Boogie')
    assert all_stats = Stat.where(:device_id => device.id, :metric_id => metric.id)
    assert_kind_of ActiveRecord::Relation, all_stats
    assert_not_nil all_stats.first
    assert_nil stat = Stat.process(:metric => metric, :device => device, :value => 'Boogie')
    assert all_stats = Stat.where(:device_id => device.id, :metric_id => metric.id)
    assert_kind_of ActiveRecord::Relation, all_stats
    assert_kind_of Stat, all_stats.first
    assert all_stats.first.string_value == 'Boogie'
    assert current_stat = CurrentStat.where(:device_id => device.id, :metric_id => metric.id)
    assert_kind_of ActiveRecord::Relation, current_stat
    assert_kind_of CurrentStat, current_stat.first
    assert current_stat.first.string_value == 'Boogie'
  end
  
  test "process gauge" do
    assert device = Device.find(:last)
    assert_not_nil device
    assert_kind_of Device, device
    assert pollgroup = Pollgroup.where(:name => 'HornetQ JMX Metrics').first
    assert_not_nil pollgroup
    assert_kind_of Pollgroup, pollgroup
    assert datatype = DataType.where(:name => 'Gauge').first
    assert_not_nil datatype
    assert_kind_of DataType, datatype
    assert metric = Metric.create(:pollgroup => pollgroup, :data_type => datatype, :port => 1090, :property => 'TestGauge', :name => 'Test Gauge')
    assert_not_nil metric
    assert_kind_of Metric, metric
    assert all_stats = Stat.where(:device_id => device.id, :metric_id => metric.id)
    assert_kind_of ActiveRecord::Relation, all_stats
    assert_nil all_stats.first
    assert stat = Stat.process(:metric => metric, :device => device, :value => 10)
    assert all_stats = Stat.where(:device_id => device.id, :metric_id => metric.id)
    assert_kind_of ActiveRecord::Relation, all_stats
    assert_not_nil all_stats.first
    assert stat = Stat.process(:metric => metric, :device => device, :value => 8)
    assert all_stats = Stat.where(:device_id => device.id, :metric_id => metric.id)
    assert_kind_of ActiveRecord::Relation, all_stats
    assert_kind_of Stat, all_stats.first
    assert all_stats.first.value == 10
    assert all_stats.last.value == 8
    assert current_stat = CurrentStat.where(:device_id => device.id, :metric_id => metric.id)
    assert_kind_of ActiveRecord::Relation, current_stat
    assert_kind_of CurrentStat, current_stat.first
    assert current_stat.first.value == 8
  end
  
  test "process counter" do
    assert device = Device.find(:last)
    assert_not_nil device
    assert_kind_of Device, device
    assert pollgroup = Pollgroup.where(:name => 'HornetQ JMX Metrics').first
    assert_not_nil pollgroup
    assert_kind_of Pollgroup, pollgroup
    assert datatype = DataType.where(:name => 'Counter').first
    assert_not_nil datatype
    assert_kind_of DataType, datatype
    assert metric = Metric.create(:pollgroup => pollgroup, :data_type => datatype, :port => 1090, :property => 'TestCounter', :name => 'Test Counter')
    assert_not_nil metric
    assert_kind_of Metric, metric
    assert all_stats = Stat.where(:device_id => device.id, :metric_id => metric.id)
    assert_kind_of ActiveRecord::Relation, all_stats
    assert_nil all_stats.first
    assert stat = Stat.process(:metric => metric, :device => device, :value => 10)
    assert all_stats = Stat.where(:device_id => device.id, :metric_id => metric.id)
    assert_kind_of ActiveRecord::Relation, all_stats
    assert_nil all_stats.first
    assert current_stat = CurrentStat.where(:device_id => device.id, :metric_id => metric.id)
    assert_kind_of ActiveRecord::Relation, current_stat
    assert_kind_of CurrentStat, current_stat.first
    assert current_stat.first.value == 10
    # now decrement the counter indicating a wrap after initial creation, current should be updated and no value added for stat
    assert stat = Stat.process(:metric => metric, :device => device, :value => 8)
    assert all_stats = Stat.where(:device_id => device.id, :metric_id => metric.id)
    assert_kind_of ActiveRecord::Relation, all_stats
    assert_nil all_stats.first
    assert current_stat = CurrentStat.where(:device_id => device.id, :metric_id => metric.id)
    assert_kind_of ActiveRecord::Relation, current_stat
    assert_kind_of CurrentStat, current_stat.first
    assert current_stat.first.value == 8
    # now increment back up and test the counter logic
    assert stat = Stat.process(:metric => metric, :device => device, :value => 10)
    assert all_stats = Stat.where(:device_id => device.id, :metric_id => metric.id)
    assert_kind_of ActiveRecord::Relation, all_stats
    assert_not_nil all_stats.first
    assert all_stats.first.value == 2
    assert current_stat = CurrentStat.where(:device_id => device.id, :metric_id => metric.id)
    assert_kind_of ActiveRecord::Relation, current_stat
    assert_kind_of CurrentStat, current_stat.first
    assert current_stat.first.value == 10
    # do one more for good measure
    assert stat = Stat.process(:metric => metric, :device => device, :value => 18)
    assert all_stats = Stat.where(:device_id => device.id, :metric_id => metric.id)
    assert_kind_of ActiveRecord::Relation, all_stats
    assert_not_nil all_stats.last
    assert all_stats.last.value == 8
    assert current_stat = CurrentStat.where(:device_id => device.id, :metric_id => metric.id)
    assert_kind_of ActiveRecord::Relation, current_stat
    assert_kind_of CurrentStat, current_stat.first
    assert current_stat.first.value == 18
  end
  
  test "process timeticks" do
    assert device = Device.find(:last)
    assert_not_nil device
    assert_kind_of Device, device
    assert pollgroup = Pollgroup.where(:name => 'HornetQ JMX Metrics').first
    assert_not_nil pollgroup
    assert_kind_of Pollgroup, pollgroup
    assert datatype = DataType.where(:name => 'Timeticks').first
    assert_not_nil datatype
    assert_kind_of DataType, datatype
    assert metric = Metric.create(:pollgroup => pollgroup, :data_type => datatype, :port => 1090, :property => 'TestTimeticks', :name => 'Test Timeticks')
    assert_not_nil metric
    assert_kind_of Metric, metric
    assert all_stats = Stat.where(:device_id => device.id, :metric_id => metric.id)
    assert_kind_of ActiveRecord::Relation, all_stats
    assert_nil all_stats.first
    assert current_timeticks = SNMP4JR::SMI::TimeTicks.new(Time.now.to_i)
    assert stat = Stat.process(:metric => metric, :device => device, :value => current_timeticks)
    assert all_stats = Stat.where(:device_id => device.id, :metric_id => metric.id)
    assert_kind_of ActiveRecord::Relation, all_stats
    assert_not_nil all_stats.first
    assert sleep 1 # make sure seconds increments
    assert current_timeticks_2 = SNMP4JR::SMI::TimeTicks.new(Time.now.to_i)
    assert stat = Stat.process(:metric => metric, :device => device, :value => current_timeticks_2)
    assert all_stats = Stat.where(:device_id => device.id, :metric_id => metric.id)
    assert_kind_of ActiveRecord::Relation, all_stats
    assert_kind_of Stat, all_stats.first
    assert all_stats.first.value == current_timeticks.to_milliseconds
    assert current_stat = CurrentStat.where(:device_id => device.id, :metric_id => metric.id)
    assert_kind_of ActiveRecord::Relation, current_stat
    assert_kind_of CurrentStat, current_stat.first
    assert current_stat.first.value == current_timeticks_2.to_milliseconds
  end
end
