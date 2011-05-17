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
hornetq =  DeviceType.create(:name => 'HornetQ Server')
DeviceType.create(:name => 'MySQL Server')
DeviceType.create(:name => 'SQL Server')
pgserver = DeviceType.create(:name => 'PostgreSQL Server')

Pollgroup.delete_all
Pollgroup.create(:name => 'ActiveMQ JMX Metrics')
Pollgroup.create(:name => 'HornetQ JMX Metrics')
Pollgroup.create(:name => 'MySQL Show Status Metrics')
pgdb =    Pollgroup.create(:name => 'PostgreSQL Database Statistics')
pgtable = Pollgroup.create(:name => 'PostgreSQL Table Statistics')
pgindex = Pollgroup.create(:name => 'PostgreSQL Index Statistics')

Profile.create(:device_type => pgserver, :pollgroup => pgdb)
Profile.create(:device_type => pgserver, :pollgroup => pgtable)
Profile.create(:device_type => pgserver, :pollgroup => pgindex)

DataType.delete_all
DataType.create([{:name => 'Counter'}, {:name => 'Gauge'}, {:name => 'Timeticks'}, {:name => 'Text'}])

Device.delete_all
Device.create(:name => 'Reflectr DB', :ip => '127.0.0.1', 
              :url => 'jdbc:postgresql://127.0.0.1/reflectr?user=testuser&password=testme', 
              :device_type => pgserver)
Device.create(:name => 'Reflectr JMX', :ip => '127.0.0.1',
              :url => 'org.hornetq:module=Core,type=Server',
              :device_type => hornetq)
              

              


