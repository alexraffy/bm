# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

require 'rack/cors'
use Rack::Cors

run Rails.application
Rails.application.load_server
