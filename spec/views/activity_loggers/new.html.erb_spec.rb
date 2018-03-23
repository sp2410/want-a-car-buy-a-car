require 'rails_helper'

RSpec.describe "activity_loggers/new", type: :view do
  before(:each) do
    assign(:activity_logger, ActivityLogger.new(
      :contact => "MyString",
      :activity => "MyString",
      :type => ""
    ))
  end

  it "renders new activity_logger form" do
    render

    assert_select "form[action=?][method=?]", activity_loggers_path, "post" do

      assert_select "input#activity_logger_contact[name=?]", "activity_logger[contact]"

      assert_select "input#activity_logger_activity[name=?]", "activity_logger[activity]"

      assert_select "input#activity_logger_type[name=?]", "activity_logger[type]"
    end
  end
end
