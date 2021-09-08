
require 'time'
server_serveillance_array = []
File.foreach("server_sevillance_datas_for_test.txt"){|line|
  server_serveillance_data_array = line.split(",")
  server_serveillance_data = {}
  server_serveillance_data[:day_time] = server_serveillance_data_array[0]
  server_serveillance_data[:server_name] = server_serveillance_data_array[1]
  server_serveillance_data[:cost_time] = server_serveillance_data_array[2].chomp
  server_serveillance_array << server_serveillance_data
}

error_server_name_array = []

server_serveillance_array.each do |a_server_serveillance_data|
  if a_server_serveillance_data[:cost_time] == "-"
    error_server_name_array << a_server_serveillance_data[:server_name]
  end
end

error_server_name_unique_array = error_server_name_array.uniq

error_analysis_details = []
error_day_time_foranalysis = []

error_server_name_unique_array.each do |error_server_name|
  error_analysis_data = []
  error_analysis_data_day_time = []
    server_serveillance_array.each do |array|
      if array[:server_name] == error_server_name
        error_analysis_data << array[:cost_time]
        error_analysis_data_day_time << array[:day_time]
      end
    end
  error_analysis_details << error_analysis_data
  error_day_time_foranalysis << error_analysis_data_day_time
end

error_array_number = []

error_analysis_details.each do |analysis_data|
  array_number = []
  analysis_data.each_with_index do |cost_time_data, i|
    if cost_time_data == "-"
      array_number << i
    end
  end
  error_array_number << array_number
end

error_array_number_neo = []

error_array_number.each do |number_array|
  error_array_number_neo << number_array.chunk_while {|i, j| i+1 == j }.to_a
end

count = error_array_number_neo.count


error_array_number_neo.each_with_index do |error_server_name, i|
  puts "故障状態のサーバーアドレスは、#{error_server_name_unique_array[i]}です。"
  error_server_name.each do |error_timing|
    if error_timing.count == 1
      error_timing_neo = error_timing[0]
      error_next_timing = error_timing[0] + 1
      if error_day_time_foranalysis[i][error_next_timing] == nil
        puts "#{error_day_time_foranalysis[i][error_timing_neo]}に故障し、まだ復旧していません"
      elsif
        puts "故障期間は、#{error_day_time_foranalysis[i][error_timing_neo]}です。"
      end      

    elsif error_timing.count > 1
      error_timing_neo = error_timing[0]
      error_next_timing = error_timing.last
      if error_day_time_foranalysis[i][error_next_timing] == nil
        puts "#{error_day_time_foranalysis[i][error_timing_neo]}に故障し、まだ復旧していません"
      elsif
        puts  "故障期間は、#{error_day_time_foranalysis[i][error_timing_neo]}〜#{error_day_time_foranalysis[i][error_next_timing]}です。"
      end      
    end
  end
end
