# frozen_string_literal: true

# create categories
programming = Category.find_or_create_by!(title: 'Programming')
alg_and_data = Category.find_or_create_by!(title: 'Data structures and algorithms')
backend = Category.find_or_create_by!(title: 'Backend')
frontend = Category.find_or_create_by!(title: 'Frontend')

# create tests
ruby_test = Test.find_or_create_by!(title: 'Ruby programming language', level: 2, category_id: programming.id)
alg_test = Test.find_or_create_by!(title: 'Algorithms', level: 3, category_id: alg_and_data.id)
rails_test = Test.find_or_create_by!(title: 'Rails framework', level: 2, category_id: backend.id)
front_test = Test.find_or_create_by!(title: 'HTML and CSS', category_id: frontend.id)

# create questions and answers
rtq1 = Question.find_or_create_by!(body: 'What the puts function is responsible for?', test_id: ruby_test.id)
Answer.find_or_create_by!(body: 'Console output', correct: true, question_id: rtq1.id)
Answer.find_or_create_by!(body: 'Addition of numbers', correct: false, question_id: rtq1.id)

atq1 = Question.find_or_create_by!(body: 'What is the linear complexity of the algorithm?', test_id: alg_test.id)
Answer.find_or_create_by!(body: 'O(log n)', correct: false, question_id: atq1.id)
Answer.find_or_create_by!(body: 'O(n)', correct: true, question_id: atq1.id)

ratq1 = Question.find_or_create_by!(body: 'What ORM is used by default in Rails?', test_id: rails_test.id)
Answer.find_or_create_by!(body: 'Active Record', correct: true, question_id: ratq1.id)
Answer.find_or_create_by!(body: 'Hibernate', correct: false, question_id: ratq1.id)

ftq1 = Question.find_or_create_by!(body: 'What function does the <a> tag do?', test_id: front_test.id)
Answer.find_or_create_by!(body: 'Creates a link', correct: true, question_id: ftq1.id)
Answer.find_or_create_by!(body: 'Creates a paragraph', correct: false, question_id: ftq1.id)

# create users
user1 = User.find_or_create_by!(first_name: 'Ivan', last_name: 'Ivanov')
user2 = User.find_or_create_by!(first_name: 'Petr', last_name: 'Smirnov')

# create statistics
Statistic.find_or_create_by!(user_id: user1.id, test_id: ruby_test.id, state: 1)
Statistic.find_or_create_by!(user_id: user1.id, test_id: rails_test.id, state: 1)
Statistic.find_or_create_by!(user_id: user1.id, test_id: alg_test.id, state: 1)
