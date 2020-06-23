require 'nokogiri'
require 'net/http'

Application.destroy_all
Position.destroy_all
User.destroy_all

u = User.create(first_name: 'elliott', last_name: 'king', email: 'ek@fi.com')

def seed_positions(data)
  data.each do |position|
    city =  "New York"
    # removes html tags
    description = Nokogiri::HTML::DocumentFragment.parse(position["description"]).text
    p = Position.create!(title: position['title'], city: city, description: description)
  end
end

def self.api_call(page)
  first_fifty = "https://jobs.github.com/positions.json"
  next_page = first_fifty + "?page=" + page.to_s
  
  if page == 0
    uri = URI.parse(URI.escape(first_fifty))
  else
    uri = URI.parse(URI.escape(next_page))
  end

  response = Net::HTTP.get_response(uri)
  data = JSON.parse(response.body)
  seed_positions(data)
  return data
end

page = 1
loop do
  data = api_call(page)
  page += 1
  if data.empty? 
    break
  end
end

