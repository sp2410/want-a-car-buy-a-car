require 'rails_helper'

RSpec.describe "activity_loggers/index", type: :view do
  before(:each) do
    assign(:activity_loggers, [
      ActivityLogger.create!(
        :contact => "Contact",
        :activity => "Activity",
        :type => "Type"
      ),
      ActivityLogger.create!(
        :contact => "Contact",
        :activity => "Activity",
        :type => "Type"
      )
    ])
  end

  it "renders a list of activity_loggers" do
    render
    assert_select "tr>td", :text => "Contact".to_s, :count => 2
    assert_select "tr>td", :text => "Activity".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
  end
end
