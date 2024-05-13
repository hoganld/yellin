module Yellin
  module ActsAsUser
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      def acts_as_user
        attr_accessor :remember_token
        has_secure_password
        normalizes :email, with: -> { _1.strip.downcase }
        validates :password, presence: true, length: { minimum: Yellin.password_minimum_length }, allow_nil: true
        validates :email, presence: true, length: { maximum: 254 }, format: { with: URI::MailTo::EMAIL_REGEXP },
                  uniqueness: { case_sensitive: false }

        generates_token_for :password_reset, expires_in: Yellin.reset_timeout_minutes.minutes do
          password_salt.last(10)
        end

        # TODO remove after Sessions replace remember_digest
        def self.digest(string)
          cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
          BCrypt::Password.create(string, cost: cost)
        end

        # TODO remove after Sessions replace remember_digest
        def self.new_token
          SecureRandom.urlsafe_base64
        end

        include Yellin::ActsAsUser::LocalInstanceMethods
      end
    end

    module LocalInstanceMethods
      # TODO remove or change with Session
      def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
      end

      # TODO remove or change with Session
      def forget
        update_attribute(:remember_digest, nil)
      end

      # TODO remove or change with Session
      def remember
        self.remember_token = Yellin.user_class.new_token
        update_attribute(:remember_digest, Yellin.user_class.digest(remember_token))
      end

      # TODO could this be removed in favor of :update post Rails 7.1 ?
      def reset_password(params)
        update(password: params[:password], password_confirmation: params[:password_confirmation], reset_digest: nil)
      end

      def send_password_reset_email(token)
        UserMailer.password_reset(self, token).deliver_now
      end
    end
  end
end
