# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string
#  last_name              :string
#  is_woman               :boolean
#  phone_number           :string
#  birthdate              :string
#  address                :string
#  zipcode                :string
#  city                   :string
#  picture_file_name      :string
#  picture_content_type   :string
#  picture_file_size      :integer
#  picture_updated_at     :datetime
#  provider               :string
#  uid                    :string
#  avatar                 :string
#  name                   :string
#  token                  :string
#  token_expiry           :datetime
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

#  picture_file_name      :string
#  picture_content_type   :string
#  picture_file_size      :integer
#  picture_updated_at     :datetime
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ActiveRecord::Base
   # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable, :omniauth_providers => [ :facebook ]

  has_many :institutes
  has_many :services, through: :institutes
  has_many :reviews
  has_many :bookings

  has_attached_file :picture,
     styles: { medium: "300x300>", thumb: "100x100>" }

   validates_attachment_content_type :picture,
     content_type: /\Aimage\/.*\z/


  validates :first_name, presence: true, on: :update
  validates :last_name, presence: true, on: :update

  def profile_complete?
    return self.valid?
  end

  def self.find_for_facebook_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.name = auth.info.name
      user.picture = process_uri(auth.info.image) if auth.info.image?
      user.token = auth.credentials.token
      user.token_expiry = Time.at(auth.credentials.expires_at)
    end
  end

  def self.process_uri(uri)
    avatar_url = URI.parse(uri)
    avatar_url.scheme = 'https'
    avatar_url.to_s
  end


end
