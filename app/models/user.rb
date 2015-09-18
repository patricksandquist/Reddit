# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  session_token   :string           not null
#

class User < ActiveRecord::Base
  attr_reader :password

  validates :username, :password_digest, presence: true
  validates :username, uniqueness: true

  def password=(password)
    self.password = password
    self.password_digest = BCrypt::Password.create(password)
    self.save!
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    session[:session_token] = @session_token
    self.save!
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
    self.save!
  end
end
