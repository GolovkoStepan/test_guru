# frozen_string_literal: true

module BadgesHelper
  def badge_rules
    BadgesService::RULES.map { |rule| [rule, t("badge_rules.#{rule}")] }
  end
end
