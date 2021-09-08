
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
  error_server_name_array << a_server_serveillance_data[:server_name]
end

error_server_name_unique_array = error_server_name_array.uniq

error_analysis_details = []
error_day_time_foranalysis = []
error_cost_time_foranalysis = []

error_server_name_unique_array.each do |error_server_name|
  error_analysis_data = []
  error_analysis_data_day_time = []
  error_analysis_data_cost_time = []
    server_serveillance_array.each do |array|
      if array[:server_name] == error_server_name
        error_analysis_data << array[:cost_time]
        error_analysis_data_day_time << array[:day_time]
        error_analysis_data_cost_time << array[:cost_time]
      end
    end
  error_analysis_details << error_analysis_data
  error_day_time_foranalysis << error_analysis_data_day_time
  error_cost_time_foranalysis << error_analysis_data_cost_time
end

m = gets.to_i
t = gets.to_i


error_cost_time_foranalysis.each_with_index do |cost_time_data, b|
  count = cost_time_data.count - 1
  puts "#{error_server_name_unique_array[b]}のサーバーでは、"
  m_true = m - 1
  m_array = []
  count.times do |i|
    m_array_tentative = []
    m_array_tentative << i
    m_true.times do
      i += 1
      m_array_tentative << i
    end
    m_array << m_array_tentative
  end
  m_array.each do |a|
    cost_time_data_details_array = []
    a.each do |m_array_true|
      cost_time_data_details_array << cost_time_data[m_array_true].to_i
    end
    if cost_time_data_details_array.include?(0)
    else
      cost_time_sum = cost_time_data_details_array.sum
      cost_time_ave = cost_time_sum / m
      if cost_time_ave > t
        puts "#{error_day_time_foranalysis[b][a[0]]}〜#{error_day_time_foranalysis[b][a.last]}で、サーバーが過負荷状態になっています。"
      end
    end
  end
end