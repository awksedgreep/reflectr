require 'test_helper'

class MetricTypeTest < ActiveSupport::TestCase
  fixtures :all
  
  test "matric_type -> metric relationship" do
    assert jmx = MetricType.where(:name => 'JMX').first
    assert_kind_of MetricType, jmx
    assert_not_nil jmx
    assert jmx_metrics = jmx.metrics
    assert_kind_of Array, jmx_metrics
    assert_not_nil jmx_metrics
    assert_kind_of Metric, jmx_metrics.first
    assert_not_nil jmx_metrics.first
    assert jmx_metrics.first.name == 'Messages Added'
  end
  
  test "metric_type crud" do
    assert boogie = MetricType.create(:name => 'Boogie')
    assert_kind_of MetricType, boogie
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
    assert find_woogie = MetricType.where(:name => 'Woogie')
    assert_kind_of ActiveRecord::Relation, find_woogie
    assert_not_nil find_woogie.first
    assert_kind_of MetricType, find_woogie.first
    assert woogie = find_woogie.first
    assert boogie_id = woogie.id
    assert woogie.destroy
    assert find_woogie = MetricType.where(:name => 'Woogie')
    assert_kind_of ActiveRecord::Relation, find_woogie
    assert_not_nil find_woogie
    assert_nil find_woogie.first
  end
end
