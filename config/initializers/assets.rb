# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

Rails.application.config.assets.precompile += %w( main.css font-awesome.min.css )
Rails.application.config.assets.precompile += %w( jquery.min.js skel.min.js util.js ie/respond.min.js main.js )
Rails.application.config.assets.precompile += %w( fontawesome-webfont.woff2 fontawesome-webfont.woff fontawesome-webfont.ttf fontawesome-webfont.svg )
Rails.application.config.assets.precompile += %w( *.jpg )
Rails.application.config.assets.precompile += %w( *.png )
Rails.application.config.assets.precompile += %w( *.sass )

# Precompile additional assets.
# application.js, application.scss, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
