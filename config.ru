# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

use Rack::Static,
:urls => ["assets/css", "assets/fonts", "assets/js", "assets/sass"],
:root => "public"

run Rails.application
