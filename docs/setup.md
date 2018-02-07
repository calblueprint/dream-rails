Setup Instructions
-------
Install [Rails](http://installrails.com/) 

1. Clone the dream-rails repo `git clone https://github.com/calblueprint/dream-rails.git`

2. Install all appropriate gems `bundle install`

3. Create `config/application.yml` using the template at `config/application.yml.sample`. Generate a new secret key using `rake secret` and paste the key into the file as `secret_key_base`. Generate a new secret test key using `rake secret test` and paste the key into the file as `secret_key_base_test`.

4. Run `rake db:create` and `rake db:migrate` to set up the database completely.

5. Clone the dream-mobile repo `git clone https://github.com/calblueprint/dream-mobile.git`

Install [React Native](https://facebook.github.io/react-native/docs/getting-started.html)
- Try running `npm start`
- Possible issues: https://github.com/react-community/create-react-native-app/issues/233, 
- If faced above issue, try to change npm & node versions: npm version 5.5.1, node version 6.2.0

6. Install Watchman `brew install watchman`

Probably Aivant and Wilson: If you don't have postgres/postgresql (they are the same thing) installed: 
- Install postgresql `brew install postgres`
- `brew services start postgresql`
- More info: https://medium.com/@bitadj/completely-uninstall-and-reinstall-psql-on-osx-551390904b86

8. cd into dream-rails and run `rails s` to start the server

9. On another terminal window, cd into dream-mobile and run `npm install` to install all the gems. Then, run `npm start` to start the application.
