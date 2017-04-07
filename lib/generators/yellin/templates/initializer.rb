# this is used to identify the application in account activation emails
Yellin.app_name = <%= Rails.application.class.parent %>

# this is used in the mailer to send account activation and password reset emails
Yellin.default_from_address = "noreply@example.com"

# this defines the minimum acceptable length of a password
Yellin.password_minimum_length = 12

# this is the number of hours after which a password reset expires. Should be an integer.
Yellin.reset_timeout_hours = 2

# this is the name of the class implementing the User API
Yellin.user_class = "<%= name %>"

