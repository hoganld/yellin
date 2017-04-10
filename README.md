# Yellin
Sometimes you need secure authentication for your Rails app, but a huge library like Devise is overkill, and implementing your own using `has_secure_password` involves a bunch of typing (especially the tests). This is what Yellin is for -- it's a small Rails engine that implements a simple but secure authorization mechanism using `has_secure_password`.

### Features
* User registration
* Account activation
* Session authentication
* Password reset

### Password Resets
Matasano (now part of NCC Group) considers automated password reset one of their 7 Deadly Web App Features. The implementation here takes into careful consideration the advice in [this discussion](https://news.ycombinator.com/item?id=5033513).

### Credit where credit is due
This gem is heavily based on the authentication system developed in Michael Hartl's [Ruby on Rails Tutorial](http://railstutorial.org). Basically, I've always liked most of that code, but I got tired of re-implementing my own modified version whenever I didn't want to use Devise. So I did the obvious thing and enginified it.

## Usage
Yellin provides a generator that takes care of all configuration you need to use it. Run the generator with the name of the user model class you want to use. If the model already exists, it will be updated. Otherwise, it will be created from scratch.

```bash
$ rails generate yellin User
```

If you decide Yellin is lame and need to remove it, you can use the normal `destroy` command:

```bash
$ rails destroy yellin User
```

### Configuration options
The generator installs a generator to `config/initializers/yellin.rb`. It looks something like this:

```ruby
Yellin.app_name = Default App Name
Yellin.default_from_address = 'noreply@example.com'
Yellin.minimum_password_length = 12
Yellin.reset_timeout_hours = 2
Yellin.user_class = "User"
```

The last line (`Yellin.user_class`) is absolutely necessary and will be set correctly based on the model to which you point the generator. *The quotes are essential.*

`Yellin.app_name` is used to identify your app in the emails sent to users when they sign up or reset their passwords. Set it accordingly. `Yellin.default_from_address` is the email address from which these emails will be sent.

In order to send emails, you must have ActionMailer configured correctly. For example, in development:

```ruby
# config/environments/development.rb
Rails.application.configure do
  ...
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :test
  host = 'localhost:3000'
  config.action_mailer.default_url_options = { host: host, protocol: 'http' }
  ...
end
```

You also must have a root route defined in `routes.rb`, or Yellin will break in several places (probably along with lots of other things).

### Views and Forms
You'll likely want to modify the views and forms used by Yellin -- probably at least the user signup form. To encourage you to modify these views, Yellin provides a rake task to copy the default files into your workspace:

```bash
$ rails yellin:install:views
```

You'll find the files copied under `app/views/yellin`. Modify them in place -- if you move them, expect Yellin to misbehave.

If you change your mind, you can remove the view files like so:

```bash
$ rails yellin:uninstall:views
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'yellin'
```

And then execute:
```bash
$ bundle install
```

Or install it yourself as:
```bash
$ gem install yellin
```

## Contributing
Bugfixes, enhancements, spelling corrections are all welcome. Use the pull request button :)

To report a security issue, please notify me directly over email.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
