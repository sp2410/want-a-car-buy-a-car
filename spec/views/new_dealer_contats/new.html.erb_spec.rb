require 'rails_helper'

RSpec.describe "new_dealer_contats/new", type: :view do
  before(:each) do
    assign(:new_dealer_contat, NewDealerContat.new(
      :fullname => "MyString",
      :email => "MyString",
      :phone => "MyString",
      :zip => "MyString",
      :address => "MyString",
      :city => "MyString",
      :state => "MyString",
      :website => "MyString",
      :inventoryhost => "MyString",
      :dealershipname => "MyString"
    ))
  end

  it "renders new new_dealer_contat form" do
    render

    assert_select "form[action=?][method=?]", new_dealer_contats_path, "post" do

      assert_select "input#new_dealer_contat_fullname[name=?]", "new_dealer_contat[fullname]"

      assert_select "input#new_dealer_contat_email[name=?]", "new_dealer_contat[email]"

      assert_select "input#new_dealer_contat_phone[name=?]", "new_dealer_contat[phone]"

      assert_select "input#new_dealer_contat_zip[name=?]", "new_dealer_contat[zip]"

      assert_select "input#new_dealer_contat_address[name=?]", "new_dealer_contat[address]"

      assert_select "input#new_dealer_contat_city[name=?]", "new_dealer_contat[city]"

      assert_select "input#new_dealer_contat_state[name=?]", "new_dealer_contat[state]"

      assert_select "input#new_dealer_contat_website[name=?]", "new_dealer_contat[website]"

      assert_select "input#new_dealer_contat_inventoryhost[name=?]", "new_dealer_contat[inventoryhost]"

      assert_select "input#new_dealer_contat_dealershipname[name=?]", "new_dealer_contat[dealershipname]"
    end
  end
end
