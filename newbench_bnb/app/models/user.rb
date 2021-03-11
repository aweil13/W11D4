class User < ApplicationRecord
    validates_presence_of :username, :email, :session_token, :password_digest
    validates_uniqueness_of :username, :email, :session_token
    validates :password, length: {minimum: 6, allow_nil: true}
    before_validation :ensure_session_token

    attr_reader :password

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password
    end

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        user and user.is_password?(password) ? user : nil
    end

    def reset_session_token!
        self.session_token = SecureRandom.urlsafe_base64(16)
        save!
        session_token
      end

    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
    end

    def is_password?(password)
        pobject = BCrypt::Password.new(self.password_digest)
        pobject.is_password?(password)
    end

end
