# == Schema Information
#
# Table name: services
#
#  id           :integer          not null, primary key
#  institute_id :integer
#  title        :string
#  description  :text
#  price        :integer
#  duration     :integer
#  category     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_services_on_institute_id  (institute_id)
#

class Service < ActiveRecord::Base
  belongs_to :institute
  has_many :bookings, dependent: :destroy
  has_many :timetables, dependent: :destroy

  validates :title, presence:true
  validates :duration, presence:true
  validates :price, presence:true
  validates :category, presence:true

end
