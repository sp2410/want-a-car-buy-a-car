require 'rails_helper'

RSpec.describe "activity_loggers/show", type: :view do
  before(:each) do
    @activity_logger = assign(:activity_logger, ActivityLogger.create!(
      :contact => "Contact",
      :activity => "Activity",
      :type => "Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Contact/)
    expect(rendered).to match(/Activity/)
    expect(rendered).to match(/Type/)
  end
end
