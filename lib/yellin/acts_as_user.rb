module Yellin
  module ActsAsUser
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      def acts_as_user
        attr_accessor :remember_token, :activation_token, :reset_token
        has_secure_password
        before_save :downcase_email
        before_create :create_activation_digest
        validates :password, presence: true, length: { minimum: 12 }, allow_nil: true
        # See https://davidcel.is/posts/stop-validating-email-addresses-with-regex/ for regex reasoning
        validates :email, presence: true, length: { maximum: 255 }, format: { with: /@/ },
                          uniqueness: { case_sensitive: false }

        def self.digest(string)
          cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
          BCrypt::Password.create(string, cost: cost)
        end

        def self.new_token
          SecureRandom.urlsafe_base64
        end

        include Yellin::ActsAsUser::LocalInstanceMethods
      end
    end

    module LocalInstanceMethods
      def activate
        update_columns(activated: true, activated_at: Time.zone.now)
      end

      def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
      end

      def create_reset_digest
        self.reset_token = Yellin.user_class.new_token
        update_columns(reset_digest: Yellin.user_class.digest(reset_token), reset_sent_at: Time.zone.now)
      end

      def forget
        update_attribute(:remember_digest, nil)
      end

      def password_reset_expired?
        reset_sent_at < Yellin.reset_timeout_hours.hours.ago
      end

      def remember
        self.remember_token = Yellin.user_class.new_token
        update_attribute(:remember_digest, Yellin.user_class.digest(remember_token))
      end

      def reset_password(params)
        update_attributes(password: params[:password], password_confirmation: params[:password_confirmation], reset_digest: nil)
      end

      def send_activation_email
        UserMailer.account_activation(self).deliver_now
      end

      def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
      end

      def downcase_email
        self.email.downcase!
      end

      def create_activation_digest
        self.activation_token = Yellin.user_class.new_token
        self.activation_digest = Yellin.user_class.digest(activation_token)
      end
    end
  end
end
