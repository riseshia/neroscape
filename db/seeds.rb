# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
User.create(email: 'admin@test.com', name: 'Admin', level: 999, password: 'asdfasdf')
User.create(email: 'unlock@test.com', name: 'User', level: 1, password: 'asdfasdf')
User.create(email: 'lock@test.com', name: 'Lock', level: 0, password: 'asdfasdf')
