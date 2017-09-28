require 'test_helper'

class LMServiceTest < ActiveSupport::TestCase
  setup do
    Model.delete_all
    Rails.application.load_seed
  end

  teardown do
    Client.delete_all
  end

  test "initializes all the models" do
    #LMService.new

    assert_equal Model.all.size, LMService.instance.matchers.size
  end

  test "returns initialized Experiment object after successful run" do
    test_content = File.read 'test/fixtures/files/MIT'
    u = Client.all.first

    expr = LMService.instance.run_experiment(u, test_content)

    assert expr.is_a?(Experiment)
    assert_equal Model.all.size, expr.results.size

  end
end
