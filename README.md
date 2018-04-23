
### Design suggestions:
● Users;
● Bicycle Categories (bicycle can have only one category);
● “Bicycles”. Possible attributes: name, image (Bugcycles must have a
face!), description.
● Suggestions to “Bicycles”. Each logged in user can edit a bike, but this
changes will be suggested to “bicycle” owner, so he can approve it.
● “Bicycle” Usage (think about it as about Likes). When I mark something as
used I don’t want see it in the search result anymore!!!
### Key Features:
● Ajax Search by title and description. (no gems). Case insensitive. Don’t
forget to exclude bikes which was already used by current user.
● Filtering by Categories
● Pagination (gem could be used)
● Authentication (Devise could be used, but your own implementation
would be appreciated as well)
● Restrictions: no more than 1 suggesion to one “Bicycle”.
● Each user has his own panel where he can add/remove his bicycles
or merge suggestions.
● Each bike should have unique name (case insensitive).
● Please use Bootstrap or Foundation for FE.
● Authorization via CanCanCan or Pundit. There is no much things to
authorize, but just show that you Can do it.


### Setup
* Ruby 2.4.1, Rails 5.1.4
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
`rake db:seed:user` this seed will create user with email: 'pierre@michaux.com', password: 'progenitor'
`rake db:seed:users`
`rake db:seed:categories`
`rake db:seed:items`
### Notes
