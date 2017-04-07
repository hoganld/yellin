# app_name is used to identify the application in account activation emails
Yellin.app_name = <%= Rails.application.class.parent %>

# default_from_address is used in the mailer to send account activation and password reset emails
Yellin.default_from_address = "noreply@example.com"

# reset_timeout_hours is the number of hours after which a password reset expires. Should be an integer.
Yellin.reset_timeout_hours = 2

# user_class is the name of the class implementing the User API
Yellin.user_class = "<%= name %>"

