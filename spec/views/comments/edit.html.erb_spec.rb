require 'rails_helper'

RSpec.describe "comments/edit", type: :view do
  before(:each) do
    @comment = assign(:comment, Comment.create!(
      :comment_by => 1,
      :note => "MyString"
    ))
  end

  it "renders the edit comment form" do
    render

    assert_select "form[action=?][method=?]", comment_path(@comment), "post" do

      assert_select "input#comment_comment_by[name=?]", "comment[comment_by]"

      assert_select "input#comment_note[name=?]", "comment[note]"
    end
  end
end
