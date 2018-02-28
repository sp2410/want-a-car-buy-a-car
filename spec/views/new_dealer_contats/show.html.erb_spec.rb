require 'rails_helper'

RSpec.describe "new_dealer_contats/show", type: :view do
  before(:each) do
    @new_dealer_contat = assign(:new_dealer_contat, NewDealerContat.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Fullname/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Zip/)
    expect(rendered).to match(/Address/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/State/)
    expect(rendered).to match(/Website/)
    expect(rendered).to match(/Inventoryhost/)
    expect(rendered).to match(/Dealershipname/)
  end
end
