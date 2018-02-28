require 'rails_helper'

RSpec.describe "new_dealer_contats/index", type: :view do
  before(:each) do
    assign(:new_dealer_contats, [
      NewDealerContat.create!(
        :fullname => "Fullname",
        :email => "Email",
        :phone => "Phone",
        :zip => "Zip",
        :address => "Address",
        :city => "City",
        :state => "State",
        :website => "Website",
        :inventoryhost => "Inventoryhost",
        :dealershipname => "Dealershipname"
      ),
      NewDealerContat.create!(
        :fullname => "Fullname",
        :email => "Email",
        :phone => "Phone",
        :zip => "Zip",
        :address => "Address",
        :city => "City",
        :state => "State",
        :website => "Website",
        :inventoryhost => "Inventoryhost",
        :dealershipname => "Dealershipname"
      )
    ])
  end

  it "renders a list of new_dealer_contats" do
    render
    assert_select "tr>td", :text => "Fullname".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Zip".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "Website".to_s, :count => 2
    assert_select "tr>td", :text => "Inventoryhost".to_s, :count => 2
    assert_select "tr>td", :text => "Dealershipname".to_s, :count => 2
  end
end
