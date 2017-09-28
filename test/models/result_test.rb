require 'test_helper'

class ResultTest < ActiveSupport::TestCase
  setup do
    Result.delete_all
    Model.delete_all
    Experiment.delete_all
    Client.delete_all
    Experiment.delete_all
  end

  setup do
    Result.delete_all
    Model.delete_all
    Experiment.delete_all
    Client.delete_all
    Experiment.delete_all
  end


  test "saves correctly the new result" do
    mdl = Model.create(label: "Test1", language: "rust", summary: "")
    assert_equal 1, Model.all.size
    assert mdl.id > 0

    u = Client.create(name: "Test Result user", active: true)

    ex = Experiment.create(text: "test text", client: u)
    assert_equal 1, Experiment.all.size

    res = Result.new(label: 'mit', score: 0.9, exec_time: 0.1, experiment: ex, model: mdl)
    assert res.save

    assert_equal 1, Result.all.size
    assert_equal mdl.id, res.model.id
  end
end
