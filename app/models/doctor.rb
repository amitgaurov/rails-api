class Doctor < ApplicationRecord
  acts_as_token_authenticatable
	has_many :appointments,dependent: :destroy
	has_many :patients, through: :appointments

  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :specialist, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # validates :doctor_id, presence: true
  # validates :content, presence: true, length: { maximum: 140 }
  # validate  :picture_size


  private

    # Validates the size of an uploaded picture.
    # def picture_size
    #   if picture.size > 5.megabytes
    #     errors.add(:picture, "should be less than 5MB")
    #   end
    # end
  def generate_jwt
      JWT.encode({ id: id,
                exp: 60.days.from_now.to_i },
               Rails.application.secrets.secret_key_base)
  end

end
