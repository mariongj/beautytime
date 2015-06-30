# == Schema Information
#
# Table name: bookings
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  service_id     :integer
#  start_datetime :datetime
#  end_datetime   :datetime
#  canceled       :boolean
#  manual         :boolean
#  manual_email   :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_bookings_on_service_id  (service_id)
#  index_bookings_on_user_id     (user_id)
#

class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :service
  has_many :reviews
end
