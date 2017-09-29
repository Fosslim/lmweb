require 'test_helper'

class LMServiceTest < ActiveSupport::TestCase
  setup do
    Model.delete_all
    Rails.application.load_seed
  end

  teardown do
    Client.delete_all
  end

  test "returns initialized Experiment object after successful run" do
    test_content = File.read 'test/fixtures/files/MIT'
    u = Client.all.first

    expr = LMService.instance.run_experiment(u, test_content)

    assert expr.is_a?(Experiment)
    p expr.results
    assert_equal Model.all.size, expr.results.to_a.size

    res1 = expr.results[0]
    assert 0.0 < res1.exec_time
    assert "", res1.model.label
  end
end
