module TimetablesHelper

  def time_two_digits(time_string)
    time = time_string.split(".")
    if time[1] == 5
      "#{hour_minutes[0]}h30"
    else
      "#{hour_minutes[0]}h00"
    end
  end
end
