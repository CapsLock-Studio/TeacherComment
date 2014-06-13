require 'test_helper'
require 'generators/login/login_generator'

class LoginGeneratorTest < Rails::Generators::TestCase
  tests LoginGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
