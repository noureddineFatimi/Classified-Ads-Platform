class UserApp < ApplicationRecord
  belongs_to :role
  has_many :announcements
  has_secure_password

  validates :username, presence: true
  validates :email, presence: true
  validates :password_digest, presence: true

  # Unicité
  validates :username, uniqueness: true
  validates :email, uniqueness: true

  # Format de l’email
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "n'est pas valide" }

  # Longueur du mot de passe (si tu utilises has_secure_password)
  has_secure_password
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
end
