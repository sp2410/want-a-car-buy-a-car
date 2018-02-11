require 'rails_helper'

RSpec.describe "comments/new", type: :view do
  before(:each) do
    assign(:comment, Comment.new(
      :comment_by => 1,
      :note => "MyString"
    ))
  end

  it "renders new comment form" do
    render

    assert_select "form[action=?][method=?]", comments_path, "post" do

      assert_select "input#comment_comment_by[name=?]", "comment[comment_by]"

      assert_select "input#comment_note[name=?]", "comment[note]"
    end
  end
end
