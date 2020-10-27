# frozen_string_literal: true

module TestsHelper
  def seconds_to_time(sec)
    Time.at(sec).utc.strftime('%H:%M:%S')
  end
end
