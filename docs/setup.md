Rails Setup Instructions
-------
Install [Rails.](http://installrails.com/)

1. Clone the Github repo `git clone https://github.com/calblueprint/dream-rails.git`

2. Install all appropriate gems `bundle install`

4. Create `config/application.yml` using the template at `config/application.yml.sample`. Generate a new secret key using `rake secret` and paste the key into the file as `secret_key_base`. Generate a new secret test key using `rake secret test` and paste the key into the file as `secret_key_base_test`.

5. Run `rake db:create` and `rake db:migrate` to set up the database completely.

6. Run `rails s` to start the server, and then navigate to `localhost:3000` to see the website running on your computer!