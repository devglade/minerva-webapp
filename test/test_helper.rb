ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  include Devise::Test::IntegrationHelpers

  setup do
    @user1 = FactoryBot.create(:user)
    # @project = FactoryBot.create(:project)
    # @post= FactoryBot.create(:post)

  end
end