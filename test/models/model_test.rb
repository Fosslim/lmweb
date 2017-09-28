require 'test_helper'

class ModelTest < ActiveSupport::TestCase
  setup do
    Model.delete_all
  end

  teardown do
    Model.delete_all
  end

  test "the truth" do
    mdl = Model.new(
      label: "t1",
      language: "rust",
      summary: "test example"
    )

    assert mdl.save
    assert_equal 1, Model.all.size
  end
end
