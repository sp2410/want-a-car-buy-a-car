require 'rails_helper'

RSpec.describe "activity_loggers/edit", type: :view do
  before(:each) do
    @activity_logger = assign(:activity_logger, ActivityLogger.create!(
      :contact => "MyString",
      :activity => "MyString",
      :type => ""
    ))
  end

  it "renders the edit activity_logger form" do
    render

    assert_select "form[action=?][method=?]", activity_logger_path(@activity_logger), "post" do

      assert_select "input#activity_logger_contact[name=?]", "activity_logger[contact]"

      assert_select "input#activity_logger_activity[name=?]", "activity_logger[activity]"

      assert_select "input#activity_logger_type[name=?]", "activity_logger[type]"
    end
  end
end
