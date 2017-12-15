# README
* Ruby 2.4.1, Rails 5.1.4
### Setup
* Install capybara webkit gem dependency (read https://github.com/thoughtbot/capybara-webkit), Install ImageMagic as dependency for paperclip gem
* Rename secrets.example and database.example and run:
`gem install rails`
`bundle`
`rake db:create`
`rake db:migrate`
`rake db:test:prepare`

### For tests run 
`rspec spec/`

### Seeds
* If you want, you can to add seeds to database
`rake db:seed:user` this seed will create user with email: 'pierre@michaux.com', password: 'progenitor'
`rake db:seed:users`
`rake db:seed:categories`
`rake db:seed:items`
### Notes
* I have disable destroy/update rights on Category
* Of course, this task need refactoring and not all things are optimally implemented, but unfortunately I'm limited in time. Sorry.

