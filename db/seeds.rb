# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts 'SEEDING USERS'

admin =
  User.create!(
    email: 'admin@truckingnexus.com',
    password: '1234trucking',
    password_confirmation: '1234trucking',
    username: 'SamPuppies'
  )

john_doe =
  User.create!(
    email: 'john_doe@truckingnexus.com',
    password: '1234trucking',
    password_confirmation: '1234trucking',
    username: 'Riding with John'
  )

puts 'SEEDING COMPANIES'

Scrapers::Company.new.call unless File.exist?(Scrapers::Company::JSON_DATA_FILE_PATH)
test_company = Company.find_or_create_by(name: 'ABC-Trucking', city: 'Nashville', state: 'TN')

file = File.open(Scrapers::Company::JSON_DATA_FILE_PATH)
JSON.parse(file.read).each do |company|
  Company.find_or_create_by!(
    name: company['name'],
    city: company['city'],
    state: company['state']
  )
end

puts 'SEEDING QUIZZES'

combo_quiz = Quiz.find_or_create_by!(
  author: admin,
  name: 'Combination Endorsement',
  description: 'Test your knowledge of combination vehicles with our CDL quiz. Challenge yourself with questions about coupling and uncoupling procedures, and safe driving practices for these complex commercial vehicles.',
  draft: false
)
airbrake_quiz = Quiz.find_or_create_by!(
  author: admin,
  name: 'Airbrake Endorsement',
  description: 'Take our CDL airbrake quiz to assess your understanding of air brake systems used in commercial vehicles. Explore topics like air brake components, maintenance, and proper operation to ensure safe and efficient braking.',
  draft: false
)

combo_questions_data = [
  {
    quiz_id: 1,
    content: 'You are coupling a semi trailer to your tractor but have not yet backed under. The trailer is at the right height when:',
    answers: [
      'It will be raised slightly when the tractor is backed under it.',
      'The kingpin is about 1 1/4 inches above the fifth wheel.',
      'The end of the kingpin is even with the top of the fifth wheel.'
    ],
    correct_answer_index: 2
  },
  {
    quiz_id: 1,
    content: 'You should not back a tractor under a trailer until the whole air system is:',
    answers: [
      'Between 60 and 80 psi.',
      'At normal pressure',
      'Bled down to half the maximum pressure.'
    ],
    correct_answer_index: 1
  },
  {
    quiz_id: 1,
    content: 'Which part of the kingpin should the locking jaws close around?',
    answers: [
      'The base',
      'The shank',
      'The head'
    ],
    correct_answer_index: 1
  },
  {
    quiz_id: 1,
    content: 'When you get ready to back under the semi trailer you should line up:',
    answers: [
      'About 12 degrees off the line of the trailer',
      'The kingpin to engage the driver\'s side locking jaw first.',
      'Directly in front of the trailer.'
    ],
    correct_answer_index: 2
  },
  {
    quiz_id: 1,
    content: 'How should you test the tractor semi trailer connection for security?',
    answers: [
      'Pull gently forward in low gear against the locked trailer brakes, then look at it carefully',
      'Put the tractor in gear and pull ahead with a sharp jerk.',
      'Rock the trailer back and forth with the trailer brakes locked.'
    ],
    correct_answer_index: 0
  },
  {
    quiz_id: 1,
    content: 'When should you use the hand valve to park a combination vehicle?',
    answers: [
      'To park at loading docks.',
      'Never',
      'To park on a grade'
    ],
    correct_answer_index: 1
  },
  {
    quiz_id: 1,
    content: 'You supply air to the trailer tanks by:',
    answers: [
      'Pushing in the trailer air supply valve.',
      'Pulling out the trailer air supply valve.',
      'Connecting the service line glad hand.'
    ],
    correct_answer_index: 0
  },
  {
    quiz_id: 1,
    content: 'Why should you be sure that the fifth wheel plate is greased as required?',
    answers: [
      'To reduce heat and noise.',
      'To prevent steering problems',
      'To ensure good electrical connections'
    ],
    correct_answer_index: 1
  },
  {
    quiz_id: 1,
    content: 'After you supply air to the trailer, make sure the air lines are not crossed and the trailer brakes are working. This is done by:',
    answers: [
      'Applying and releasing the trailer brakes and listening for brake sounds.',
      'Lifting the brake pedal.',
      'Turning on the parking brakes from the cab.'
    ],
    correct_answer_index: 0
  },
  {
    quiz_id: 1,
    content: 'There are two things that a driver can do to prevent a roll over. They are: (1) Keep the cargo as close to the ground as possible; and (2):',
    answers: [
      'Make sure that the brakes are properly adjusted',
      'Keep the fifth wheel\'s free play as tight as possible',
      'Go slowly around turns'
    ],
    correct_answer_index: 2
  },
  {
    quiz_id: 1,
    content: 'Before you back under a trailer, make sure the:',
    answers: [
      'Air suply knob is in.',
      'Air brakes are off',
      'Trailer brakes are locked.'
    ],
    correct_answer_index: 2
  },
  {
    quiz_id: 1,
    content: 'If the service air lines comes apart while you are driving a combination vehicle but the emergency line stays together, what will happen right away?',
    answers: [
      'Nothing is likely to happen until you try to apply the brakes.',
      'The trailer\'s air tank will exhaust through the open line.',
      'The emergency tractor brakes will come on.'
    ],
    correct_answer_index: 0
  },
  {
    quiz_id: 1,
    content: 'The air leakage rate for a combination vehicle (engine off, brakes on) should not be more than ___ psi per minute.',
    answers: %w[4 2 6],
    correct_answer_index: 0
  },
  {
    quiz_id: 1,
    content: 'In normal driving, some drivers use the hand valve before applying the brake pedal to prevent a jackknife. Which of statements is true?',
    answers: [
      'If the trailer has no spring brakes, you can drive away, but you will not have trailer brakes.',
      'The brake pedal will work the trailer spring brakes instead of the air brakes',
      'The hand valve will apply the tractor brakes instead of the trailer brakes.'
    ],
    correct_answer_index: 0
  },
  {
    quiz_id: 1,
    content: 'Why should you lock the tractor glad hands (or dummy couplers) to each other when you are not towing a trailer?',
    answers: [
      'The connected brake circuit becomes a back up air tank.',
      'If you did not, you could never build system pressure.',
      'It will keep dirt and water out of the lines.'
    ],
    correct_answer_index: 2
  },
  {
    quiz_id: 1,
    content: 'For coupling to be completed, the saftey catch for the fifth wheel locking lever must be:',
    answers: [
      'Straight up.',
      'Over the locking lever',
      'Through the locking lever.'
    ],
    correct_answer_index: 1
  },
  {
    quiz_id: 1,
    content: 'The front trailer supports are up and the trailer is resting on the tractor. Make sure:',
    answers: [
      'There is enough clearance between the upper and lower fifth wheel.',
      'The saftey latch is in the unlocked position.',
      'There is enough clearance between the tractor frame and the landing gear.'
    ],
    correct_answer_index: 2
  },
  {
    quiz_id: 1,
    content: 'You have a major leak in the service line and you put on the brakes. Service air pressure will escape and cause the:',
    answers: [
      'Trailer tank pressure to be lost.',
      'Trailer emergency brakes to come on.',
      'Tractor spring brakes to lock on.'
    ],
    correct_answer_index: 1
  },
  {
    quiz_id: 1,
    content: 'When backing a tractor under a trailer you should expect:',
    answers: [
      'Trailer will be lifted slightly when the tractor backs under it.',
      'End of the kingpin is even with the top of the fifth wheel',
      'Trailer landing gear is fully extended.'
    ],
    correct_answer_index: 0
  },
  {
    quiz_id: 1,
    content: 'The driver crosses the air lines when hooking up to an old trailer. What will happen?',
    answers: [
      'If the trailer has no spring brakes, you can drive away, but you will not have trailer brakes.',
      'The brake pedal will work the trailer spring brakes instead of the air brakes.',
      'The hand valve will apply the tractor brakes instead of the trailer brakes.'
    ],
    correct_answer_index: 0
  },
  {
    quiz_id: 1,
    content: 'You are coupling a tractor to a semi trailer and have backed up but are not under it. What should you hook up before backing under the semitrailer?',
    answers: [
      'The emergency and service air lines.',
      'The electrical service cable.',
      'Nothing, back up and lock the fifth wheel.'
    ],
    correct_answer_index: 0
  },
  {
    quiz_id: 1,
    content: 'Air lines on a combination vehicle are often colored to keep them from getting mixed up. The emergency line is ___; The service line is ___.',
    answers: [
      'Red, Blue',
      'Blue, Red',
      'Black, Yellow'
    ],
    correct_answer_index: 0
  },
  {
    quiz_id: 1,
    content: 'Which of these statements is true?',
    answers: [
      'Light vehicles need more braking power to stop than heavy ones.',
      'Always delay braking a heavy vehicle until you have no other choice.',
      '"Bobtail" tractors can take longer to stop than a combination vehicle loaded to the maximum gross weight.'
    ],
    correct_answer_index: 2
  },
  {
    quiz_id: 1,
    content: 'After connecting the air lines, but before backing under the trailer you should:',
    answers: [
      'Make sure that the trailer brakes are off.',
      'Supply air to the trailer system, then pull out the air supply knob.',
      'Walk around the rig to make sure it is clear.'
    ],
    correct_answer_index: 1
  },
  {
    quiz_id: 1,
    content: 'The air leakage rate for a single vehicle (engine off, brakes off) should be no more than ___ psi per minute.',
    answers: %w[2 3 4],
    correct_answer_index: 2
  },
  {
    quiz_id: 1,
    content: 'The fifth wheel locking lever is not locked after the jaws close around the kingpin. This means that:',
    answers: [
      'You can set the fifth wheel for weight balance.',
      'The coupling is not right and should be fixed before driving the vehicle.',
      'The parking lock is off and you may drive away.'
    ],
    correct_answer_index: 1
  },
  {
    quiz_id: 1,
    content: 'You are driving a combination vehicle when the trailer breaks away, pulling apart both air lines. You would expect the trailer brakes to come on and:',
    answers: [
      'The trailer supply valve to stay open',
      'The tractor to lose all air pressure',
      'The tractor protection valve to close.'
    ],
    correct_answer_index: 2
  },
  {
    quiz_id: 1,
    content: 'Semi trailers made before 1975 that are equipped with air brakes:',
    answers: [
      'Often do not have spring brakes.',
      'Usually need a glad hand converter',
      'Are easier to brake because they are heavier.'
    ],
    correct_answer_index: 0
  },
  {
    quiz_id: 1,
    content: 'Almost half of all truck driver deaths are the result of:',
    answers: [
      'Speed.',
      'Rollovers.',
      'Following too closely.'
    ],
    correct_answer_index: 1
  },
  {
    quiz_id: 1,
    content: 'What statement best explains "crack the whip effect"?',
    answers: [
      'When you make a quick lane change or sudden movement with your steering wheel the rear trailer tends to swing out. The force of the rear trailer becomes amplified causing it to roll over (rearward amplification).',
      'Your trailer is half full and the cargo is loaded in the front of the trailer. When you make a sudden steering wheel movement cargo will tend to forcefully slide to the back of the trailer, forcing the trailer to rollover.',
      'When you make a quick lane chagne or sudden movement with your steering wheel the tractor tends to rock and sway. The velocity of the rear most trailer forces the tractor to rollover before the trailer.'
    ],
    correct_answer_index: 0
  },
  {
    quiz_id: 1,
    content: 'Which type of truck-trailer combination has the best chance of the "crack the whip" rollover?',
    answers: [
      'A single tractor trailer',
      'A tractor pulling doubles',
      'A tractor pulling triples'
    ],
    correct_answer_index: 2
  },
  {
    quiz_id: 1,
    content: 'Which trailers are most likely to get stuck on railroad tracks?',
    answers: [
      'Lowboy trailers. A low slung unit.',
      'Tandem axle tractor pulling a flatbed.'
    ],
    correct_answer_index: 0,
    multiple: true # QUESTION TYPES NOT IMPLEMENTED YET.
  },
  {
    quiz_id: 1,
    content: 'Where should the tractor be when you inspect landing gear after uncoupling the trailer?',
    answers: [
      'With the tractor frame under the trailer.',
      'Completely cleared from the trailer',
      'With the fifth wheel directly beneath the kingpin.'
    ],
    correct_answer_index: 0
  },
  {
    quiz_id: 1,
    content: 'Under good driving conditions, you should leave at least one second of space between your vehicle and the vehicle ahead for every ___ feet of your vehicles length.',
    answers: %w[10 20 30],
    correct_answer_index: 0
  },
  {
    quiz_id: 1,
    content: 'The safest way to make turn without entering another traffic lane is:',
    answers: [
      'You should turn wide before you start the turn.',
      'You should turn wide as you complete the turn.',
      'You should not make a turn and move to another place where you can make a turn without crossing other lane.'
    ],
    correct_answer_index: 1
  },
  {
    quiz_id: 1,
    content: 'In general, the higher your truck\'s center of gravity, the:',
    answers: [
      'Easier it is to turn around corners.',
      'More stable it is when turning.',
      'Easier it is to turn over.'
    ],
    correct_answer_index: 2
  },
  {
    quiz_id: 1,
    content: 'If the service line comes apart while you are driving a combination vehicle but the emergency line stays together, what will happen right away?',
    answers: [
      'The trailer\'s tank will exhaust through the open line.',
      'The emergency trailer brakes will come on.',
      'Nothing is likely to happen until you try to apply the brakes.'
    ],
    correct_answer_index: 2
  },
  {
    quiz_id: 1,
    content: 'Glad hands are used to connect the:',
    answers: [
      'Electric lines from the tractor to trailer',
      'Kingpin from the trailer to the locking jaws of the fifth wheel.',
      'Service and emergency air lines from the truck to the trailer.'
    ],
    correct_answer_index: 2
  },
  {
    quiz_id: 1,
    content: 'A driver crosses the air lines when hooking up to an old trailer. What will happen?',
    answers: [
      'The hand valve will apply the tractor brakes instead of the trailer brakes.',
      'If the trailer has no spring brakes, you could drive away but you wouldn\'t have trailer brakes.',
      'The brake lights will come on when the brake pedal is pressed.'
    ],
    correct_answer_index: 1
  },
  {
    quiz_id: 1,
    content: 'The hand valve should be used:',
    answers: [
      'As a parking brake.',
      'Only with foot brake.',
      'To test the trailer brakes.'
    ],
    correct_answer_index: 2
  },
  {
    quiz_id: 1,
    content: 'When driving a set of doubles it is necessary to close which shut-off valve in the last trailer.',
    answers: [
      'Front.',
      'Back.',
      'Middle section.'
    ],
    correct_answer_index: 1
  },
  {
    quiz_id: 1,
    content: 'Your emergency air line breaks, or it gets pulled apart while you are driving. The loss of pressure will cause the:',
    answers: [
      'Air compressor to unload instead of pumping air.',
      'Emergency trailer brakes to come on.',
      'Trailer supply valve to open.'
    ],
    correct_answer_index: 1
  },
  {
    quiz_id: 1,
    content: 'How much space should be between upper and lower fifth wheel after coupling?',
    answers: [
      'Just enough to see light through it.',
      'About 1/4 inch.',
      'None.'
    ],
    correct_answer_index: 2
  },
  {
    quiz_id: 1,
    content: 'If the brakes are not released when you pushed the trailer air supply valve you should:',
    answers: [
      'Check air line connection.',
      'Cross the airlines.',
      'Check electrical cable.'
    ],
    correct_answer_index: 0
  },
  {
    quiz_id: 1,
    content: 'You have pushed the trailer air supply valve. You should not back a tractor under a trailer until the whole air system is:',
    answers: [
      'At normal pressure.',
      'Empty.',
      'Between 60 and 80 psi.'
    ],
    correct_answer_index: 0
  },
  {
    quiz_id: 1,
    content: 'You are coupling tractor to a semitrailer. You have connected the airlines. Before backing under the trailer you should:',
    answers: [
      'Supply air to the trailer system, then pull out the air supply knob.',
      'Pull ahead to test the glad hands connections.',
      'Make sure that the trailer brakes are off.'
    ],
    correct_answer_index: 0
  },
  {
    quiz_id: 1,
    content: 'After you have coupled the trailer you should have to raise the landing gear by using:',
    answers: [
      'Low gear.',
      'Intermediate.',
      'High gear'
    ],
    correct_answer_index: 0
  },
  {
    quiz_id: 1,
    content: 'When connecting the glad hands press the two seals with the coupler together at what degree?',
    answers: %w[45 90 180],
    correct_answer_index: 0
  },
  {
    quiz_id: 1,
    content: 'The iron trailer supports are up and the trailer is resting on the tractor. Make sure:',
    answers: [
      'There is enough clearance between the upper and lower fifth wheels.',
      'There is enough clearance between the tractor frame and the landing gear.',
      'The safety latch is in unlocked position.'
    ],
    correct_answer_index: 1
  },
  {
    quiz_id: 1,
    content: 'When you are uncoupling a loaded trailer lower the landing gear until it:',
    answers: [
      'Reaches the ground.',
      'Makes contact with the ground and leave the trailer off the fifth wheel.',
      'Makes firm contact with the ground.'
    ],
    correct_answer_index: 2
  }
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_answer_index: 'Never'
  # }

  # Add more questions and answers as needed
]

airbrake_questions_data = [
  {
    quiz_id: 2,
    content: 'Oil and water usually collect in compressed air tanks. If you do not have an automatic tank drain, when should you drain the air tanks?',
    answers: [
      'After every working day.',
      'After every four hours of service.',
      'Once a week.'
    ],
    correct_answer_index: 0
  },
  {
    quiz_id: 2,
    content: 'Why drain water form the compressed air tanks?',
    answers: [
      'To keep from fouling the air compressor oil.',
      'Water can freeze in cold weather and cause brake failure.',
      'The low boiling point of water reduces braking power.'
    ],
    correct_answer_index: 1
  },
  {
    quiz_id: 2,
    content: 'The air brake system for a straight truck or bus should not leak at a rate of more than ___ psi per minute with the engine off and the brakes released.',
    answers: %w[1 2 3],
    correct_answer_index: 2
  },
  {
    quiz_id: 2,
    content: 'To make an emergency stop with air brakes, using the stab braking method, you should:',
    answers: [
      'Pump the brake pedal rapidly and lightly.',
      'Brake hard until the wheels lock, and then get off the brakes for as much time as the wheels were locked.',
      'Press on the brake pedal as hard as you can, release the brakes when the wheels locked, put on the brakes again when the wheels start rolling.'
    ],
    correct_answer_index: 2
  },
  {
    quiz_id: 2,
    content: 'You should know that your brakes are fading when:',
    answers: [
      'Pressure on the brake pedal is released and speed increases.',
      'You have to press the brake pedal harder to control speed on a downgrade.',
      'The brake feels spongy when pressure is applied.'
    ],
    correct_answer_index: 1
  },
  {
    quiz_id: 2,
    content: 'If the air compressor should develop a leak, what keeps the air in the tanks?',
    answers: [
      'The tractor protection valve.',
      'The emergency relay valve.',
      'The one way check valve.'
    ],
    correct_answer_index: 2
  }
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # },
  # {
  #   content: '',
  #   answers: [],
  #   correct_answer_index:
  # }
]

puts 'SEEDING QUIZ QUESTIONS'

[ { quiz: combo_quiz, data: combo_questions_data },
 { quiz: airbrake_quiz, data: airbrake_questions_data } ].each do |hash|
  quiz, data = hash.values_at(:quiz, :data)
  quiz.questions.create!(data.map do |q_data|
    {
      content: q_data[:content],
      answers_attributes: q_data[:answers].map { |answer| { content: answer } }
    }
  end)
end

puts 'SEEDING QUIZ ANSWERS'

[ combo_questions_data ].each do |question_data|
  question_data.each do |data|
    question = Question.find_by(content: data[:content], quiz_id: data[:quiz_id])
    content = data[:answers][data[:correct_answer_index]]
    answer = Answer.find_by(content: content, question_id: question.id)
    answer.update_column(:correct, true)
  end
end

puts 'GENERATING ACTIVE QUIZZES FOR USERS'
[ admin ].each do |user|
  quiz = Quiz.first
  user_quiz = user.user_quizzes.create(quiz:)
  user_quiz.prep_for_quiz
  answer_sheet = user_quiz.answer_sheet

  rand(answer_sheet.answer_sheet_questions.count).times do |i|
    as_question = answer_sheet.answer_sheet_questions[i]
    as_question.update(answer: as_question.question.answers.sample)
  end
end

puts 'GENERATING COMPLETED QUIZZES FOR USERS'
[ admin ].each do |user|
  quiz = Quiz.first
  user_quiz = user.user_quizzes.create(quiz:)
  user_quiz.prep_for_quiz
  answer_sheet = user_quiz.answer_sheet

  answer_sheet.answer_sheet_questions.each do |as_question|
    as_question.update(answer: as_question.question.answers.sample)
  end

  QuizService::Grader.new(user_quiz:).call
end

puts 'GENERATING REVIEWS'
review_data = [
  {
    title: 'Excellent Training Program!',
    content: 'I recently completed the training program at XYZ Trucking, and it was outstanding. The instructors were knowledgeable, the facilities were top-notch, and the hands-on experience was invaluable. I feel well-prepared for my career in trucking. Highly recommend!',
    rating: 5,
    reviewable: test_company
  },
  {
    title: 'Great Company Culture',
    content: 'Working at ABC Logistics has been a fantastic experience. The company truly values its employees, and the training is comprehensive. From safety protocols to route planning, they cover it all. The supportive environment makes it a pleasure to be a part of this team.',
    rating: 4,
    reviewable: test_company
  },
  {
    title: 'Solid Training, Room for Improvement',
    content: "I completed the training program at DEF Haulage, and while the basics were covered well, I believe there's room for improvement. More practical on-road training would have been beneficial. However, the overall experience was decent, and the staff was friendly.",
    rating: 3,
    reviewable: test_company
  },
  {
    title: 'Smooth Onboarding Process',
    content: "My onboarding process at LMN Trucking was seamless. The paperwork was minimal, and the training was well-organized. The company's emphasis on safety is commendable. I feel confident and ready to hit the road. Thank you, LMN!",
    rating: 4,
    reviewable: test_company
  },
  {
    title: 'Supportive Team and Mentorship',
    content: 'Joining PQR Transport was a great decision. The mentorship program paired me with an experienced driver, and the support from both colleagues and supervisors has been exceptional. The training was thorough, and I appreciate the emphasis on continuous learning.',
    rating: 5,
    reviewable: test_company
  },
  {
    title: 'Average Experience',
    content: "My time at RST Trucking was average. The training covered the basics, but there wasn't much focus on advanced skills. The work environment was okay, but it didn't stand out. It's a decent starting point, but there are better options out there.",
    rating: 2,
    reviewable: test_company
  }
]

admin.reviews.create!(review_data[0])
john_doe.reviews.create!(review_data[1])
