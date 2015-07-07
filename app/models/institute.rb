# == Schema Information
#
# Table name: institutes
#
#  id                    :integer          not null, primary key
#  name                  :string
#  description           :text
#  address               :string
#  user_id               :integer
#  validated             :boolean
#  zipcode               :string
#  city                  :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  picture1_file_name    :string
#  picture1_content_type :string
#  picture1_file_size    :integer
#  picture1_updated_at   :datetime
#  picture2_file_name    :string
#  picture2_content_type :string
#  picture2_file_size    :integer
#  picture2_updated_at   :datetime
#  picture3_file_name    :string
#  picture3_content_type :string
#  picture3_file_size    :integer
#  picture3_updated_at   :datetime
#  latitude              :float
#  longitude             :float
#
# Indexes
#
#  index_institutes_on_user_id  (user_id)
#

class Institute < ActiveRecord::Base
  belongs_to :user

  has_many :services
  has_many :reviews

  validates :name, presence: true

  geocoded_by :full_address
  after_validation :geocode, if: :address_changed?

  has_attached_file :picture1,
     styles: { medium: "300x300>", thumb: "100x100>" }

  validates_attachment_content_type :picture1,
   content_type: /\Aimage\/.*\z/

  has_attached_file :picture2,
    styles: { medium: "300x300>", thumb: "100x100>" }

  validates_attachment_content_type :picture2,
   content_type: /\Aimage\/.*\z/

  has_attached_file :picture3,
    styles: { medium: "300x300>", thumb: "100x100>" }

  validates_attachment_content_type :picture3,
   content_type: /\Aimage\/.*\z/

  def full_address
    "#{address}, #{zipcode} #{city}"
  end
end
