require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  setup do
    Client.delete_all
    Experiment.delete_all
    Model.delete_all
  end

  teardown do
    Client.delete_all
    Experiment.delete_all
    Model.delete_all
  end

  test "saves the user" do
    u = Client.new(
      name: "Test User1",
      token: "axe-123",
      active: true
   )

    assert u.save
    assert_equal 1, Client.all.size
  end


  test "saves client experiement with results " do
    u = Client.new(
      name: "Test User2",
      token: "axe-123",
      active: true
    )

    assert u.save

    mdl = Model.new(
      label: "t1",
      language: "rust",
      summary: "test example"
    )

    assert mdl.save

    Client.transaction do
      res1 = Result.new(
        label: "mit",
        score: 0.912,
        exec_time: 0.1,
        model: mdl
      )

      ex1 = Experiment.new(
        text: "test text",
        results: [res1]
      )

      u.experiments << ex1
      u.save
    end

    u.reload
    assert_equal 1, u.experiments.size
    assert_equal "test text", u.experiments.first.text
  end
end
