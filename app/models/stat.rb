class Stat < ActiveRecord::Base
  belongs_to :device
  belongs_to :metric
  
  def Stat.process(stuff)
    begin
      current = CurrentStat.find(:all, :conditions => {:device => stuff[:device], :metric => stuff[:metric]}).first
      # rearrange stuff for strings
      datatype = stuff[:metric].datatype.name
      if datatype == 'Text'
        stuff[:string_value] = stuff[:value].to_s
        stuff[:value] = nil
      end
      # If no current stat, then update current and return . . . no need to waste cycles
      if current.nil?
        CurrentStat.new(stuff)  
        return repository(:default).adapter.execute(sql)
      end

      case stuff[:metric].datatype.name
        when 'Text'
          # Only create row if string has changed :)
          if (stuff[:string_value] != current.string_value)
            Stat.new(stuff).save
            current.string_value = stuff[:value].to_s
            current.save
          end
        when 'Gauge'
           # No reason to add row if data is unchanged
           if (stuff[:value] != current.value.to_i)
              Stat.new(stuff).save
              current.value = stuff[:value].to_i
              current.save
           end
        when 'Timeticks'
           # store as int, would check for dups but would likely just waste cpu cycles
           stuff[:value] = stuff[:value].to_milliseconds
           Stat.new(stuff).save
           current.value = stuff[:value].to_i
           current.save
        when 'Counter'
          # here's the slightly more complex bit
          # if new value is larger than "current"
          if (stuff[:value].to_i > current.value.to_i)
            # do counter math
            delta = stuff[:value].to_i - current.value.to_i
            # store new value in currentstat
            current.value = stuff[:value].to_i
            current.save
            # replace new value with delta before storing stat
            stuff[:value] = delta
            Stat.new(stuff).save
          elsif (stuff[:value].to_i < current.value.to_i)
            current.value = stuff[:value].to_i
          end
        end
     rescue Exception => e
        # Todo, figure out DM logging and use it here  
        puts e.message  
        puts e.backtrace.join("\n")
     end
  end
end
