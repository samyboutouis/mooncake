# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
courses = Course.create([{ department: "COMPSCI", course_number: "101L", section_number: "01-LAB", capacity: 100}, { department: "COMPSCI", course_number: "201L", section_number: "02-LAB", capacity: 100}, { department: "ECON", course_number: "101", section_number: "01-LAB", capacity: 100}])
questions = Question.create([{question_type:  "text", question_text: "Full name:"}, {question_type:  "text", question_text: "Email:"}, {question_type:  "text", question_text: "Graduation year:"}, {question_type:  "text", question_text: "Please enter your majors, separated by comma:"}, {question_type:  "text", question_text: "Please enter your minors, separated by comma:"}, {question_type:  "Checkbox", question_text: "Which courses have you taken:"}])
