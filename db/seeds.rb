require 'nokogiri'
require 'net/http'

Message.destroy_all
Application.destroy_all
Position.destroy_all
Company.destroy_all
User.destroy_all

u = User.create(first_name: 'Elliott', last_name: 'King', email: 'ek@fi.com',
                resume: "{\"name\": \"Elliott King\", \"email\": \"elliottking93@gmail.com\", \"mobile_number\": \"716-650-8158\", \"skills\": [\"Ruby\", \"Testing\", \"Access\", \"Engineering\", \"Html\", \"Javascript\", \"Python\", \"Java\", \"Aws\", \"C++\", \"Github\", \"Js\", \"Researching\", \"Tensorflow\", \"Agile\", \"Technical\", \"Mathematics\", \"Analysis\", \"Sql\"], \"college_name\": null, \"degree\": null, \"designation\": [\"SOFTWARE DEVELOPER\"], \"experience\": [\"Google\", \"Software Engineering Intern\", \"Backend for the new Google Sites\", \"\\u25cf Overhauled debug access to comply with GDPR\", \"\\u25cf Implemented full integration testing to reduce technical debt\", \"\\u25cf Dogfooded new library and worked with team to roll out\", \"- Java\", \"Batch analysis of TensorFlow pipelines\", \"- Python\", \"\\u25cf Batching framework to reduce 80% of reused code in machine learning pipelines\", \"\\u25cf Built seamless integration with Google file services\"], \"company_names\": null, \"no_of_pages\": 1, \"total_experience\": 0.0}")

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