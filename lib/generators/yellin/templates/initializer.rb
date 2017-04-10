# this is used to identify the application in account activation emails
Yellin.app_name = <%= Rails.application.class.parent %>

# this is used in the mailer to send account activation and password reset emails
Yellin.default_from_address = "noreply@example.com"

# this defines the notifications seen by the user
Yellin.flash = {
  account_inactive: "Account not activated. Check your email for the activation link.",
  activation_pending: "Please check your email to activate your account.",
  activation_success: "Account activated.",
  activation_invalid: "Invalid activation link.",
  bad_credentials: "Invalid email/password combination.",
  login_required: "Please sign in.",
  reset_sent: "Email sent with password reset instructions.",
  reset_success: "Your password has been reset.",
  reset_expired: "Password reset has expired.",
}

# this defines the minimum acceptable length of a password
Yellin.password_minimum_length = 12

# this is the number of hours after which a password reset expires. Should be an integer.
Yellin.reset_timeout_hours = 2

# this is the name of the class implementing the User API
Yellin.user_class = "<%= name %>"

