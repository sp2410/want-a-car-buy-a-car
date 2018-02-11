require 'rails_helper'

RSpec.describe "comments/index", type: :view do
  before(:each) do
    assign(:comments, [
      Comment.create!(
        :comment_by => 2,
        :note => "Note"
      ),
      Comment.create!(
        :comment_by => 2,
        :note => "Note"
      )
    ])
  end

  it "renders a list of comments" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Note".to_s, :count => 2
  end
end
