# this is used to identify the application in account activation emails
Yellin.app_name = <%= Rails.application.class.module_parent %>

# this is used in the mailer to send account activation and password reset emails
Yellin.default_from_address = "noreply@example.com"

# this defines the notifications seen by the user
Yellin.flash = {
  account_inactive: "Account not activated. Check your email for the activation link.",
  activation_invalid: "Invalid activation link.",
  activation_pending: "Please check your email to activate your account.",
  activation_success: "Account activated.",
  bad_credentials: "Invalid email/password combination.",
  reset_expired: "Password reset has expired.",
  reset_invalid: "Email address not found.",
  reset_sent: "Email sent with password reset instructions.",
  reset_success: "Your password has been reset.",
  sign_in_required: "Please sign in.",
  sign_in_success: "Signed in successfully.",
}

# this defines the minimum acceptable length of a password
Yellin.password_minimum_length = 12

# this is the number of hours after which a password reset expires. Should be an integer.
Yellin.reset_timeout_hours = 2

# this is the name of the class implementing the User API
Yellin.user_class = "<%= name %>"

