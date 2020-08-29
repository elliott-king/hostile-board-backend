require 'nokogiri'
require 'net/http'

Message.destroy_all
Application.destroy_all
Position.destroy_all
Company.destroy_all
User.destroy_all

u = User.create(first_name: 'Elliott', last_name: 'King', email: 'ek@fi.com')

def seed_positions(data)
  data.each do |position|
    company = Company.find_by(name: position["company"])
    if !company
      company_user = User.create!(
        first_name: 'Admin',
        last_name: position['company'].delete(' '),
        email: 'admin@' + position['company'].downcase.delete(' ') + '.com',
        is_company: true,
      )
      company = Company.create!(
        name: position["company"], 
        website: position["company_url"], 
        company_logo: position["company_logo"],
        user_id: company_user.id)
    end

    city =  position["location"]
    # removes html tags
    description = Nokogiri::HTML::DocumentFragment.parse(position["description"]).text
    p = Position.create!(
      title: position['title'], 
      city: city, 
      description: description, 
      company: company)
  end
end

def api_call(page)
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

Application.create!(
  user: u, 
  position: Company.last.positions.first,
  skills: ["Ruby", "Rails"], 
  job_history: "something, somewhere", 
  projects: "somewhat, sometime", 
  written_introduction: "I am broke"
)
Message.create!(
  user: u, 
  company: Company.last, 
  content: "This is a sample message from a company to thee",
  position: Company.last.positions.first,
)

Application.create!(
  user: u, 
  position: Company.first.positions.first,
  skills: ["Ruby", "Rails"], 
  job_history: "something, somewhere", 
  projects: "somewhat, sometime", 
  written_introduction: "I am broke"
)
Message.create!(
  user: u, 
  company: Company.first, 
  content: "You are just not a good fit at this time",
  position: Company.first.positions.first,
)