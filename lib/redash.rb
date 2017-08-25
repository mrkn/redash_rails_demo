require 'json'

module Redash
  module_function

  def add_result_column(result, column_name, friendly_name, column_type)
    result[:columns] ||= []
    result[:columns] << { name: column_name, friendly_name: friendly_name, type: column_type }
  end

  def add_result_row(result, values)
    result[:rows] ||= []
    result[:rows] << values
  end

  def commit_to_redash(result)
    $stdout.puts JSON.dump(result)
  end
end
