# frozen_string_literal: true

module BadgesHelper
  def badge_rules
    {
      one_try: t('badge_rules.one_try'),
      all_by_level_1: t('badge_rules.all_by_level_1'),
      all_by_cat_backend: t('badge_rules.all_by_cat_backend')
    }.to_a
  end
end
