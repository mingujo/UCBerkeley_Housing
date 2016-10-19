require 'rails_helper'

RSpec.describe "schedulers/index", type: :view do
  before(:each) do
    assign(:schedulers, [
      Scheduler.create!(
        :name => "Name",
        :email => "Email",
        :login => "Login"
      ),
      Scheduler.create!(
        :name => "Name",
        :email => "Email",
        :login => "Login"
      )
    ])
  end

  it "renders a list of schedulers" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Login".to_s, :count => 2
  end
end
