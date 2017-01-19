# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

kinployer = Kinployer.create(
  user: User.new(
    email:            "kinployer@example.com",
    name:             "Jackie Kinployer",
    password_digest:  Crypto.secure_digest( "password" ),
    role:             'kinployer' ) )
kinployees = Kinployee.create( [
  { user: User.new(
      email:            "kinployee@example.com",
      name:             "Joe Helper",
      password_digest:  Crypto.secure_digest( "password" ),
      role:             'kinployee' ),
    availability:             40,
    cultural_backgrounds:     [ "South American", "North African", "South African", "South Asian", "Middle Eastern" ],
    culture_match_preference: 'no_preference',
    languages:                [ 'english', 'swahili' ],
    location:                 { city: "San Francisco", state: "CA" },
    sex:                      'male',
    skills:                   [ "Home - Housekeeping", "Home - Childcare", "Business - Secretarial" ] },
  { user: User.new(
      email:            "kinployee+1@example.com",
      name:             "Jane Helper",
      password_digest:  Crypto.secure_digest( "password" ),
      role:             'kinployee' ),
    availability:             40,
    cultural_backgrounds:     [ "Caribbean/West Indian", "Central African", "East Asian", "Southeast Asian" ],
    culture_match_preference: 'similar',
    languages:                [ 'english', 'spanish' ],
    location:                 { city: "San Francisco", state: "CA" },
    sex:                      'female',
    skills:                   [ "Home - Handiwork", "Home - Cooking", "Business - Filing" ] },
  { user: User.new(
      email:            "kinployee+2@example.com",
      name:             "Samantha Sometime",
      password_digest:  Crypto.secure_digest( "password" ),
      role:             'kinployee' ),
    availability:             20,
    cultural_backgrounds:     [ "South American", "Caribbean/West Indian", "North African", "Central African", "South African" ],
    culture_match_preference: 'not_similar',
    languages:                [ 'english', 'mandarin' ],
    location:                 { city: "Miami", state: "FL" },
    sex:                      'other',
    skills:                   [ "Home - Housekeeping", "Home - Handiwork", "Home - Childcare" ] },
  { user: User.new(
      email:            "kinployee+3@example.com",
      name:             "Brendan Busybody",
      password_digest:  Crypto.secure_digest( "password" ),
      role:             'kinployee' ),
    availability:             5,
    cultural_backgrounds:     [ "East Asian", "South Asian", "Southeast Asian", "Middle Eastern" ],
    culture_match_preference: 'no_preference',
    languages:                [ 'english', 'swahili', 'spanish', 'mandarin' ],
    location:                 { city: "Miami", state: "FL" },
    sex:                      'male',
    skills:                   [ "Home - Cooking", "Business - Secretarial", "Business - Filing" ] }

] )
kinployment = Kinployment.create(
  name:                     "Help Around the House",
  kinployer:                kinployer,
  kinployee:                nil,
  cultural_backgrounds:     [ "South American", "Central African", "South African", "Southeast Asian", "Middle Eastern" ],
  culture_match_preference: 'similar',
  location:                 { city: "Berkeley", state: "CA" },
  preferred_availability:   15,
  preferred_languages:      [ 'english', 'spanish', 'mandarin' ],
  preferred_sex:            'no_preference',
  preferred_skills:         [ "Home - Housekeeping", "Home - Handiwork", "Home - Childcare", "Home - Cooking" ] )