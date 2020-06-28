# frozen_string_literal: true

module ApplicationHelper
  def current_year
    Time.zone.now.year
  end

  def github_url(author, repo)
    link_to "TestGuru. Author: #{author}", repo
  end

  def school_link
    link_to 'Учебный проект в онлайн-школе Thinknetica', 'https://thinknetica.com'
  end
end
