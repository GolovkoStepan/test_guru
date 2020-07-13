# frozen_string_literal: true

module ApplicationHelper
  def current_year
    Time.current.year
  end

  def github_url(author, repo)
    author += '/' unless author.end_with? '/'
    url = URI.join('https://github.com', author, repo)
    link_to 'GitHub', url.to_s, target: '_blank'
  end

  def school_link
    link_to(
      'Учебный проект в онлайн-школе Thinknetica',
      'https://thinknetica.com',
      target: '_blank'
    )
  end

  def flash_msg(type:, tag:, css_class:)
    content_tag tag, flash[type], class: css_class if flash[type]
  end
end
