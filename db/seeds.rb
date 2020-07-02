# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
questions = Question.create([{question_type:  "text", question_text: "Full name:"}, {question_type:  "text", question_text: "Email:"}, {question_type:  "text", question_text: "Graduation year:"}, {question_type:  "text", question_text: "Major(s), separated by comma:"}, {question_type:  "text", question_text: "Minor(s), separated by comma:"}])
