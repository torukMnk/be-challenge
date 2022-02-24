## Back End Challenge

### Overview

  In this challenge you'll be connecting to an external API, recieving reports in various formats, and will have to translate them and store them in the databse. You'll have to create a user and use the given token for http authentication. This excercise mimics how vendor portals portals behave in real-world applications. You may use any tools and add any gems as you see fit. You are allowed to use google, stack overflow, etc and to ask us questions. There are 3 different report formats formats: JSON(20), CSV(25) and XML(25). You're not expected to complete all of them.  The goal of this excercise is not to completle it to perfection, but to see how you approach problems and design it's solutions. The challenge is encapsulated inside a sinatra app. You are not required to run it or build any views, it was just a convenient boilerplate.

### Objective
  The objective of this challenge is for your to recieve a transaction report, and store each individual transaction in the database, extracting the attributes required by the Transaction ActiveRecord model found on `./models/transaction.rb`

### Instructions

1. Clone this repository
2. create a branch with your name
3. Run `bundle install`
4. Run `rake db:create` and `rake db:migrate RACK_ENV=test`
5. Run `rake spec` and ensure there are no failing tests. 
6. Visit https://be-challenge-api.herokuapp.com/
7. Follow the on screen instructions to create a user, recieve a token and conenct to the API.
8. Use any means you see fit to accomplish the objective outlined above. 
