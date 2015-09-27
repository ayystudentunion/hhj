# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

# precompile university stylsheets
Rails.application.config.assets.precompile += Dir[Rails.root.join('public/universities/*/stylesheet/*.styl')].map{
  |f| Pathname(f).relative_path_from(Rails.root.join('public/universities')).to_s.chomp(File.extname(f))
}
