require 'test_helper'

class ExperimentTest < ActiveSupport::TestCase
  setup do
    Model.delete_all
    Client.delete_all

    Rake::Task['db:seed'].invoke
  end

  teardown do
    Client.delete_all
    Result.delete_all
    Experiment.delete_all
    Model.delete_all
  end

  test "saving new client experiment" do
    client = Client.all.first
    models = Model.all.to_a

    results = []
    results << Result.new(model: models[0], label: "mit", score: 0.3, exec_time: 0.1)
    results << Result.new(model: models[1], label: "bsd2", score: 0.9, exec_time: 0)

    ex = Experiment.new(client: client, results: results, text: "nibin")

    assert ex.save
    ex.reload

    assert_equal client.id, ex.client.id
    assert_equal 2, ex.results.size

    res1 = ex.results.first
    assert_equal "mit", res1.label
    assert_equal 0.3, res1.score
    assert_equal 0.1, res1.exec_time
    assert_equal "UrlMatcher", res1.model.label
  end
end
