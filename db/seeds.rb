# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

require 'ffaker'

def random_access_id(first_name, middle_name, last_name)
  initials = first_name[0,1] + middle_name.to_s[0,1] + last_name[0,1]
  access_id = initials + (0..rand(1..3)).map { (1..9).to_a[rand(9)] }.join
end

def degrees
  [
    ['Master of Science', 'M.S.'],
    ['Doctor of Philosophy', 'Ph.D.'],
    ['Doctor of Education', 'Ed.D.'],
    ['Master of Architecture', 'M.Arch.'],
    ['Master of Engineering', 'M.Eng.']
  ]
end

def programs
  [
    'Human Development and Family Studies',
    'Business Administration',
    'Art History',
    'Public Health Sciences',
    'Curriculum and Instruction',
    'Materials Science and Engineering',
    'Biochemistry, Microbiology, and Molecular Biology',
    'Sociology',
    'French',
    'Information Sciences and Technology',
    'Chemistry',
    'Health Policy and Administration',
    'Educational Theory and Policy'
  ]
end

def output_with_color(color, message)
  case color
    when 'green'   then color_code = 32
    when 'red'     then color_code = 31
    when 'magenta' then color_code = 35
  end
  puts "\033[#{color_code}m#{message}\033[0m"
end

@counter = 0
60.times do
  first_name  = Faker::Name.first_name
  last_name   = Faker::Name.last_name
  middle_name = rand(1..10) == 1 ? nil : Faker::Name.first_name
  access_id   = random_access_id(first_name, middle_name, last_name)
  address_2   = rand(1..10) == 1 ? Faker::Address.secondary_address : nil
  domain      = ['@hotmail.com', '@gmail.com', '@yahoo.com'][rand(3)]
  
  Author.create!(
    access_id: access_id,
    first_name: first_name,
    last_name: last_name,
    middle_name: middle_name,
    alternate_email_address: first_name[0,1] + '.' + last_name + domain,
    psu_email_address: access_id + "@psu.edu",
    phone_number: Faker::PhoneNumber.short_phone_number,
    address_1: Faker::AddressUS.street_address, 
    address_2: address_2,
    city: Faker::AddressUS.city,
    state: Faker::AddressUS.state,
    zip: Faker::AddressUS.zip_code,
    is_alternate_email_public: rand(1..2) == 1
  )
  @counter += 1
end

output_with_color('green', "Seeded #{@counter} authors!" )

@counter = 0
degrees.each do |degree|
  begin
    Degree.create!(
      name: degree[0],
      description: degree[1],
      degree_type: Degree.degree_types.sample,
      is_active: rand(1..4) != 1
    )
    @counter += 1
  rescue ActiveRecord::RecordInvalid => e
    output_with_color('red', e )
  end
end

output_with_color('green', "Seeded #{@counter} degrees!" )

@counter = 0
programs.each do |program|
  Program.create!(
    name: program,
    is_active: rand(1..4) != 1
  )
  @counter += 1
end

output_with_color('green', "Seeded #{@counter} programs!" )

@counter = 0
Author.first(50).each do |author|
  Submission.create!(
    author: author,
    program: Program.all.sample,
    degree: Degree.all.sample,
    semester: Submission::SEMESTERS.sample,
    year: Submission.years.sample,
    status: 'collecting committee',
    title: Faker::Company.catch_phrase
  )
  @counter += 1
end

output_with_color('green', "Seeded #{@counter} submissions!" )
