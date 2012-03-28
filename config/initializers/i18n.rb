require "i18n/backend/fallbacks"

# This needs to be here in separate file. Will not work in application.rb (like: config.I18n.fallbacks = ...)
::I18n.fallbacks = {
  en: [:en, :fi, :se],
  fi: [:fi, :se, :en],
  se: [:se, :fi, :en]
}

