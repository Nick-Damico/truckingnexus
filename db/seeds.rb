# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts 'SEEDING COMPANIES'

Scrapers::Company.new.call unless File.exist?(Scrapers::Company::JSON_DATA_FILE_PATH)

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
  name: 'Combination Endorsement Practice Test',
  description: 'Test your knowledge of combination vehicles with our CDL quiz. Challenge yourself with questions about coupling and uncoupling procedures, and safe driving practices for these complex commercial vehicles.'
)

questions_data = [
  {
    content: 'You are coupling a semi trailer to your tractor but have not yet backed under. The trailer is at the right height when:',
    answers: [
      'It will be raised slightly when the tractor is backed under it.',
      'The kingpin is about 1 1/4 inches above the fifth wheel.',
      'The end of the kingpin is even with the top of the fifth wheel.'
    ],
    correct_anwser: 'The end of the kingpin is even with the top of the fifth wheel.'
  },
  {
    content: 'You should not back a tractor under a trailer until the whole air system is:',
    answers: [
      'Between 60 and 80 psi.',
      'At normal pressure',
      'Bled down to half the maximum pressure.'
    ],
    correct_anwser: 'At normal pressure'
  },
  {
    content: 'Which part of the kingpin should the locking jaws close around?',
    answers: [
      'The base',
      'The shank',
      'The head'
    ],
    correct_anwser: 'The shank'
  },
  {
    content: 'When you get ready to back under the semi trailer you should line up:',
    answers: [
      'About 12 degrees off the line of the trailer',
      'The kingpin to engage the driver\'s side locking jaw first.',
      'Directly in front of the trailer.'
    ],
    correct_anwser: 'Directly in front of the trailer.'
  },
  {
    content: 'How should you test the tractor semi trailer connection for security?',
    answers: [
      'Pull gently forward in low gear against the locked trailer brakes, then look at it carefully',
      'Put the tractor in gear and pull ahead with a sharp jerk.',
      'Rock the trailer back and forth with the trailer brakes locked.'
    ],
    correct_anwser: 'Pull gently forward in low gear against the locked trailer brakes, then look at it carefully'
  },
  {
    content: 'When should you use the hand valve to park a combination vehicle?',
    answers: [
      'To park at loading docks.',
      'Never',
      'To park on a grade'
    ],
    correct_anwser: 'Never'
  },
  {
    content: 'You supply air to the trailer tanks by:',
    answers: [
      'Pushing in the trailer air supply valve.',
      'Pulling out the trailer air supply valve.',
      'Connecting the service line glad hand.'
    ],
    correct_anwser: 'Pushing in the trailer air supply valve.'
  },
  {
    content: 'Why should you be sure that the fifth wheel plate is greased as required?',
    answers: [
      'To reduce heat and noise.',
      'To prevent steering problems',
      'To ensure good electrical connections'
    ],
    correct_anwser: 'To prevent steering problems'
  },
  {
    content: 'After you supply air to the trailer, make sure the air lines are not crossed and the trailer brakes are working. This is done by:',
    answers: [
      'Applying and releasing the trailer brakes and listening for brake sounds.',
      'Lifting the brake pedal.',
      'Turning on the parking brakes from the cab.'
    ],
    correct_anwser: 'Applying and releasing the trailer brakes and listening for brake sounds.'
  },
  {
    content: 'There are two things that a driver can do to prevent a roll over. They are: (1) Keep the cargo as close to the ground as possible; and (2):',
    answers: [
      'Make sure that the brakes are properly adjusted',
      'Keep the fifth wheel\'s free play as tight as possible',
      'Go slowly around turns'
    ],
    correct_anwser: 'Go slowly around turns'
  },
  {
    content: 'Before you back under a trailer, make sure the:',
    answers: [
      'Air suply knob is in.',
      'Air brakes are off',
      'Trailer brakes are locked.'
    ],
    correct_anwser: 'Trailer brakes are locked.'
  },
  {
    content: 'If the service air lines comes apart while you are driving a combination vehicle but the emergency line stays together, what will happen right away?',
    answers: [
      'Nothing is likely to happen until you try to apply the brakes.',
      'The trailer\'s air tank will exhaust through the open line.',
      'The emergency tractor brakes will come on.'
    ],
    correct_anwser: 'Nothing is likely to happen until you try to apply the brakes.'
  },
  {
    content: 'The air leakage rate for a combination vehicle (engine off, brakes on) should not be more than ___ psi per minute.',
    answers: %w[4 2 6],
    correct_anwser: '4'
  },
  {
    content: 'In normal driving, some drivers use the hand valve before applying the brake pedal to prevent a jackknife. Which of statements is true?',
    answers: [
      'If the trailer has no spring brakes, you can drive away, but you will not have trailer brakes.',
      'The brake pedal will work the trailer spring brakes instead of the air brakes',
      'The hand valve will apply the tractor brakes instead of the trailer brakes.'
    ],
    correct_anwser: 'If the trailer has no spring brakes, you can drive away, but you will not have trailer brakes.'
  },
  {
    content: 'Why should you lock the tractor glad hands (or dummy couplers) to each other when you are not towing a trailer?',
    answers: [
      'The connected brake circuit becomes a back up air tank.',
      'If you did not, you could never build system pressure.',
      'It will keep dirt and water out of the lines.'
    ],
    correct_anwser: 'It will keep dirt and water out of the lines.'
  },
  {
    content: 'For coupling to be completed, the saftey catch for the fifth wheel locking lever must be:',
    answers: [
      'Straight up.',
      'Over the locking lever',
      'Through the locking lever.'
    ],
    correct_anwser: 'Over the locking lever'
  },
  {
    content: 'The front trailer supports are up and the trailer is resting on the tractor. Make sure:',
    answers: [
      'There is enough clearance between the upper and lower fifth wheel.',
      'The saftey latch is in the unlocked position.',
      'There is enough clearance between the tractor frame and the landing gear.'
    ],
    correct_anwser: 'There is enough clearance between the tractor frame and the landing gear.'
  },
  {
    content: 'You have a major leak in the service line and you put on the brakes. Service air pressure will escape and cause the:',
    answers: [
      'Trailer tank pressure to be lost.',
      'Trailer emergency brakes to come on.',
      'Tractor spring brakes to lock on.'
    ],
    correct_anwser: 'Trailer emergency brakes to come on.'
  },
  {
    content: 'When backing a tractor under a trailer you should expect:',
    answers: [
      'Trailer will be lifted slightly when the tractor backs under it.',
      'End of the kingpin is even with the top of the fifth wheel',
      'Trailer landing gear is fully extended.'
    ],
    correct_anwser: 'Trailer will be lifted slightly when the tractor backs under it.'
  },
  {
    content: 'The driver crosses the air lines when hooking up to an old trailer. What will happen?',
    answers: [
      'If the trailer has no spring brakes, you can drive away, but you will not have trailer brakes.',
      'The brake pedal will work the trailer spring brakes instead of the air brakes.',
      'The hand valve will apply the tractor brakes instead of the trailer brakes.'
    ],
    correct_anwser: 'If the trailer has no spring brakes, you can drive away, but you will not have trailer brakes.'
  },
  {
    content: 'You are coupling a tractor to a semi trailer and have backed up but are not under it. What should you hook up before backing under the semitrailer?',
    answers: [
      'The emergency and service air lines.',
      'The electrical service cable.',
      'Nothing, back up and lock the fifth wheel.'
    ],
    correct_anwser: 'The emergency and service air lines.'
  },
  {
    content: 'Air lines on a combination vehicle are often colored to keep them from getting mixed up. The emergency line is ___; The service line is ___.',
    answers: [
      'Red, Blue',
      'Blue, Red',
      'Black, Yellow'
    ],
    correct_anwser: 'Red, Blue'
  },
  {
    content: 'Which of these statements is true?',
    answers: [
      'Light vehicles need more braking power to stop than heavy ones.',
      'Always delay braking a heavy vehicle until you have no other choice.',
      '"Bobtail" tractors can take longer to stop than a combination vehicle loaded to the maximum gross weight.'
    ],
    correct_anwser: '"Bobtail" tractors can take longer to stop than a combination vehicle loaded to the maximum gross weight.'
  }
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_anwser: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_anwser: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_anwser: 'Never'
  # },
  # {
  #   content: '',
  #   answers: [
  #     'To park on a grade'
  #   ],
  #   correct_anwser: 'Never'
  # }

  # Add more questions and answers as needed
]

combo_quiz.questions.create!(questions_data.map do |q_data|
  {
    content: q_data[:content],
    answers_attributes: q_data[:answers].map { |answer| { content: answer } }
  }
end)

puts 'SEEDING QUIZ ANSWERS'
questions_data.each do |question_data|
  question = Question.find_by(content: question_data[:content])
  question.correct_answer = Answer.find_by(content: question_data[:correct_anwser], question_id: question.id)
  question.save!
end
