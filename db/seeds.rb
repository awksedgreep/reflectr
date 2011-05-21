# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first}
MetricType.delete_all
metric_jmx =   MetricType.create(:name => 'JMX')
metric_snmp =  MetricType.create(:name => 'SNMP')
metric_show =  MetricType.create(:name => 'MySQL Show Status')
metric_query = MetricType.create(:name => 'Query')

DeviceType.delete_all
DeviceType.create(:name => 'ActiveMQ Server')
dt_hornetq =  DeviceType.create(:name => 'HornetQ Server')
DeviceType.create(:name => 'MySQL Server')
DeviceType.create(:name => 'SQL Server')
pgserver =    DeviceType.create(:name => 'PostgreSQL Server')

Pollgroup.delete_all
activemq =  Pollgroup.create(:name => 'ActiveMQ JMX Metrics')
hornetq =   Pollgroup.create(:name => 'HornetQ JMX Metrics')
mysqlshow = Pollgroup.create(:name => 'MySQL Show Status Metrics')
pgdb =      Pollgroup.create(:name => 'PostgreSQL Database Statistics')
pgtable =   Pollgroup.create(:name => 'PostgreSQL Table Statistics')
pgindex =   Pollgroup.create(:name => 'PostgreSQL Index Statistics')

Profile.delete_all
profile_hornetq = Profile.create(:device_type => dt_hornetq, :pollgroup => hornetq)
profile_pgdb =    Profile.create(:device_type => pgserver, :pollgroup => pgdb)
profile_pgtable = Profile.create(:device_type => pgserver, :pollgroup => pgtable)
profile_pgindex = Profile.create(:device_type => pgserver, :pollgroup => pgindex)

DataType.delete_all
counter =   DataType.create(:name => 'Counter')
gauge =     DataType.create(:name => 'Gauge')
timeticks = DataType.create(:name => 'Timeticks')
text =      DataType.create(:name => 'Text')

Device.delete_all
reflectr_db = Device.create(:name => 'Reflectr DB', :ip => '127.0.0.1', 
              :url => 'jdbc:postgresql://127.0.0.1/reflectr?user=reflectr&password=r3fl3ctr', 
              :device_type => pgserver)
reflectr_queues = Device.create(:name => 'Reflectr HornetQ Server', :ip => '127.0.0.1',
              :url => 'org.hornetq:module=Core,type=Queue,name=*,address=*',
              :device_type => dt_hornetq)
              
Metric.delete_all
Metric.create(:name => 'Messages Added', :port => 1090, :pollgroup => hornetq, :metric_type => metric_jmx, :data_type => counter, :property => 'MessagesAdded')
Metric.create(:name => 'Message Count', :port => 1090, :pollgroup => hornetq, :metric_type => metric_jmx, :data_type => gauge, :property => 'MessageCount')



