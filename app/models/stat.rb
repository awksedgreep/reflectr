class Stat < ActiveRecord::Base
  belongs_to :device
  belongs_to :metric
  
  def Stat.process(stuff)
    begin
      current = CurrentStat.where(:device_id => stuff[:device], :metric_id => stuff[:metric]).first
      # rearrange stuff for strings
      data_type = stuff[:metric].data_type.name
      if data_type == 'Text'
        stuff[:string_value] = stuff[:value].to_s
        stuff[:value] = nil
      end
      # If no current stat, then update current and return . . . no need to waste cycles
      if current.nil?
        CurrentStat.create(stuff)
        Stat.create(stuff) if (data_type == 'Text' or data_type == 'Gauge')  # go ahead an add an entry, but only if its text or gauge  
        return true
      end

      case data_type
        when 'Text'
          # Only create row if string has changed :)
          if (stuff[:string_value] != current.string_value)
            Stat.create(stuff)
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
           Stat.create(stuff)
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
            Stat.create(stuff)
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
  
  def Stat.create_or_update_stat(stuff)
    statement = %{
      INSERT INTO stats(metric_id, device_id, string_value, value, created_at, updated_at)
      VALUES (#{connection.quote(name)}, utc_timestamp, utc_timestamp, 1)
      ON DUPLICATE KEY UPDATE
        updated_at = utc_timestamp,
        post_tags_count = post_tags_count + 1,
        id=LAST_INSERT_ID(id)
    }.squish!
    
    connection.insert_sql(statement)
  end
end
