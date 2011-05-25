
class JdbcQuery
  attr_accessor :url, :query, :result, :connection, :meta, :column_count
  
  def run(query = nil, url = nil)
    query = @query if query == nil
    url = @url if url == nil
    @connection = java.sql.DriverManager.getConnection(url)
    @result = @connection.createStatement.executeQuery query
    @meta = @result.getMetaData
    @column_count = @meta.getColumnCount
    return @result
  end
  
  def next_row
    row = []
    if @result.next
      1.upto(@column_count) do |column_id|
        column = {}
        column[:type] = @meta.getColumnType(column_id)
        column[:name] = @meta.getColumnLabel(column_id)
        column[:value] = @result.getObject(column_id)
        row << column
      end
    else
      return false
    end
    return row
  end
  
  def close
    @result.close
    @connection.close
  end
end
