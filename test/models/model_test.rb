require 'test_helper'

class ModelTest < ActiveSupport::TestCase
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
  end
end
