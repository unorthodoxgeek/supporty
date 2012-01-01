require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr
    config.mock_with :rspec

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    config.use_transactional_fixtures = true
  end

  require "factories.rb"
end

Spork.each_run do
  # This code will be run each time you run your specs.
  Dir["#{Rails.root}/app/models/**/*.rb"].each do |model|
    load model
  end
  Dir["#{Rails.root}/app/controllers/**/*.rb"].each do |controller|
    load controller
  end

  load "#{Rails.root}/config/routes.rb"
end
