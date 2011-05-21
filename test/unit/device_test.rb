require 'test_helper'

class DeviceTest < ActiveSupport::TestCase
  fixtures :all
  
  test "device -> device_type relationship" do
    assert hornetq = Device.where(:name => 'Reflectr HornetQ Server').first
    assert_kind_of Device, hornetq
    assert_not_nil hornetq
    assert hornetq_dt = hornetq.device_type
    assert_kind_of DeviceType, hornetq_dt
    assert_not_nil hornetq_dt
  end
  
  test "device crud" do
    assert dt = DeviceType.where(:name => 'HornetQ Server').first
    assert boogie = Device.create(:name => 'Boogie', :device_type => dt)
    assert_kind_of Device, boogie
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
    assert find_woogie = Device.where(:name => 'Woogie')
    assert_kind_of ActiveRecord::Relation, find_woogie
    assert_not_nil find_woogie.first
    assert_kind_of Device, find_woogie.first
    assert woogie = find_woogie.first
    assert boogie_id = woogie.id
    assert woogie.destroy
    assert find_woogie = Device.where(:name => 'Woogie')
    assert_kind_of ActiveRecord::Relation, find_woogie
    assert_not_nil find_woogie
    assert_nil find_woogie.first
  end
end
