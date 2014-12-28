# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Operator.find_or_create_by(name: 'Firm_One')
Operator.find_or_create_by(name: 'Firm_Two')
Operator.find_or_create_by(name: 'Firm_Three')
Operator.find_or_create_by(name: 'Firm_Four')
Operator.find_or_create_by(name: 'Firm_Five')

Invoice.find_or_create_by(operator_id: 1, title: 'I', done: true, value: 5)
Invoice.find_or_create_by(operator_id: 1, title: 'II', value: 3)
