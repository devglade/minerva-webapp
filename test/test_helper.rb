ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  include Devise::Test::IntegrationHelpers

  setup do
    @user1 = FactoryBot.create(:user)
    # @retrospect = FactoryBot.create(:retrospect)
    # @post= FactoryBot.create(:post)

  end
end