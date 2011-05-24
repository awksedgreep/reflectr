require 'test_helper'

class MetricTest < ActiveSupport::TestCase
  fixtures :all
  
  test "metric -> metric_type relationship" do
    assert messages_added = Metric.where(:name => 'Messages Added').first
    assert_kind_of Metric, messages_added
    assert_not_nil messages_added
    assert jmx_metric_type = messages_added.metric_type
    assert_kind_of MetricType, jmx_metric_type
    assert_not_nil jmx_metric_type
    assert jmx_metric_type.name == 'JMX'
  end
  
  test "metric crud" do
    assert counter = DataType.where(:name => 'Counter').first
    assert jmx_mt = MetricType.where(:name => 'JMX').first
    assert jmx_pg = Pollgroup.where(:name => 'HornetQ JMX Metrics').first
    assert boogie = Metric.create(:data_type => counter, :metric_type => jmx_mt, :pollgroup => jmx_pg,
                                  :name => 'Boogie', :port => 1090, :property => 'Boogie')
    assert_kind_of Metric, boogie
    assert_not_nil boogie
    assert_not_nil boogie.id
    assert_kind_of ActiveSupport::TimeWithZone, boogie.created_at
    assert_not_nil boogie.created_at
    assert_kind_of ActiveSupport::TimeWithZone, boogie.updated_at
    assert_not_nil boogie.updated_at
    assert_kind_of Integer, boogie.id
    assert_not_nil boogie.id
    assert boogie_id = boogie.id # for later
    assert boogie.name = 'Woogie'
    assert boogie.save
    assert find_woogie = Metric.where(:name => 'Woogie')
    assert_kind_of ActiveRecord::Relation, find_woogie
    assert_not_nil find_woogie.first
    assert_kind_of Metric, find_woogie.first
    assert woogie = find_woogie.first
    assert boogie_id = woogie.id
    assert woogie.destroy
    assert find_woogie = Metric.where(:name => 'Woogie')
    assert_kind_of ActiveRecord::Relation, find_woogie
    assert_not_nil find_woogie
    assert_nil find_woogie.first
  end
end
