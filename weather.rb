require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(open("http://weather.gc.ca/"))

# scrape two column table for cities and one call for weather
city_left = page.css('td.width-25 a')
city_right = page.css('td.table-border-left.width-20 a')
weather_all = page.css('td.align-right')

# push cities into left and right arrays
city_left_array = []

  city_left.each do |city|
    city_left_array << city.text
  end

city_right_array = []

  city_right.each do |city|
    city_right_array << city.text
  end

# combine left and right city arrays into single city array
city_all = city_left_array.concat(city_right_array)


weather_all_array = []

  weather_all.each do |weather|
    weather_all_array << weather.text
  end


# create a city / weather hash with city as key and weather as hash
weather_hash = {}

  city_all.each_with_index do |city, index|
    weather_hash[city]=weather_all[index]
  end


File.open('weather.html', 'w') do |f|
  f.puts("<html>")
  f.puts("<head>")
  f.puts("<title>Weather in Alberta</title>")
  f.puts("<meta charset='UTF-8'>" )
  f.puts("</head>")
  f.puts("<body>")
  f.puts("<h1>Nice Weather!</h1>")
  f.puts("<ul>")

  weather_hash.each do |city,weather|
    f.puts(" <li>" + city + " " + weather + "</li>")
  end
  
  f.puts("<ul>")
  f.puts("</body>\n")
  f.puts("</html>\n")

end