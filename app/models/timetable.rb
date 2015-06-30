# == Schema Information
#
# Table name: timetables
#
#  id                   :integer          not null, primary key
#  service_id           :integer
#  monday_start_time    :time
#  monday_end_time      :time
#  tuesday_start_time   :time
#  tuesday_end_time     :time
#  wednesday_start_time :time
#  wednesday_end_time   :time
#  thursday_start_time  :time
#  thursday_end_time    :time
#  friday_start_time    :time
#  friday_end_time      :time
#  saturday_start_time  :time
#  saturday_end_time    :time
#  sunday_start_time    :time
#  sunday_end_time      :time
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_timetables_on_service_id  (service_id)
#

class Timetable < ActiveRecord::Base
  belongs_to :service
end
