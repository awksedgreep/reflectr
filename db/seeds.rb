# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first}
MetricType.delete_all
MetricType.create(:name => 'JMX')
MetricType.create(:name => 'SNMP')
MetricType.create(:name => 'MySQL Show Status')
MetricType.create(:name => 'Query')

DeviceType.delete_all
DeviceType.create(:name => 'ActiveMQ Server')
DeviceType.create(:name => 'MySQL Server')
DeviceType.create(:name => 'PostgreSQL Server')
DeviceType.create(:name => 'SQL Server')

DataType.delete_all
DataType.create([{:name => 'Counter'}, {:name => 'Gauge'}, {:name => 'Timeticks'}, {:name => 'Text'}])

Device.delete_all
Device.create(:name => 'Reflectr DB', :ip => '127.0.0.1', :url => 'jdbc:postgresql://127.0.0.1/reflectr', :device_type => (DeviceType.find :all, :conditions => {:name => 'PostgreSQL Server'}).first)

