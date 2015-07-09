# == Schema Information
#
# Table name: reviews
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  booking_id   :integer
#  rate         :integer
#  comments     :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  institute_id :integer
#
# Indexes
#
#  index_reviews_on_booking_id  (booking_id)
#  index_reviews_on_user_id     (user_id)
#

class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :booking
  belongs_to :institute

  validates :rate, presence:true
  validates_inclusion_of :rate, :in => 1..5, :message => "La note doit être comprise entre 1 et 5"
end
