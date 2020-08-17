# frozen_string_literal: true

# create users
user1 = User.find_or_initialize_by(first_name: 'Ivan', last_name: 'Ivanov', email: 'user1@users.ru')
user1.password = '112233'
user1.password_confirmation = '112233'
user1.save!

user2 = User.find_or_initialize_by(first_name: 'Petr', last_name: 'Smirnov', email: 'user2@users.ru', role: :admin)
user2.password = '112233'
user2.password_confirmation = '112233'
user2.save!

# create categories
programming = Category.find_or_create_by!(title: 'Programming')
alg_and_data = Category.find_or_create_by!(title: 'Data structures and algorithms')
backend = Category.find_or_create_by!(title: 'Backend')
frontend = Category.find_or_create_by!(title: 'Frontend')

# create tests
ruby_test = Test.find_or_create_by!(title: 'Ruby programming language', level: 2, category: programming, author: user2)
alg_test = Test.find_or_create_by!(title: 'Algorithms', level: 3, category: alg_and_data, author: user2)
rails_test = Test.find_or_create_by!(title: 'Rails framework', level: 2, category: backend, author: user2)
front_test = Test.find_or_create_by!(title: 'HTML and CSS', category: frontend, author: user2)

# create questions and answers
rtq1 = Question.find_or_create_by!(body: 'What the puts function is responsible for?', test: ruby_test)
Answer.find_or_create_by!(body: 'Console output', correct: true, question: rtq1)
Answer.find_or_create_by!(body: 'Addition of numbers', correct: false, question: rtq1)

atq1 = Question.find_or_create_by!(body: 'What is the linear complexity of the algorithm?', test: alg_test)
Answer.find_or_create_by!(body: 'O(log n)', correct: false, question: atq1)
Answer.find_or_create_by!(body: 'O(n)', correct: true, question: atq1)

ratq1 = Question.find_or_create_by!(body: 'What ORM is used by default in Rails?', test: rails_test)
Answer.find_or_create_by!(body: 'Active Record', correct: true, question: ratq1)
Answer.find_or_create_by!(body: 'Hibernate', correct: false, question: ratq1)

ftq1 = Question.find_or_create_by!(body: 'What function does the <a> tag do?', test: front_test)
Answer.find_or_create_by!(body: 'Creates a link', correct: true, question: ftq1)
Answer.find_or_create_by!(body: 'Creates a paragraph', correct: false, question: ftq1)
