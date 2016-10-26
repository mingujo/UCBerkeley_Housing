require 'rails_helper'

RSpec.describe "schedulers/new", type: :view do
  before(:each) do
    assign(:scheduler, Scheduler.new(
      :name => "MyString",
      :email => "MyString",
      :login => "MyString"
    ))
  end

  it "renders new scheduler form" do
    render

    assert_select "form[action=?][method=?]", schedulers_path, "post" do

      assert_select "input#scheduler_name[name=?]", "scheduler[name]"

      assert_select "input#scheduler_email[name=?]", "scheduler[email]"

      assert_select "input#scheduler_login[name=?]", "scheduler[login]"
    end
  end
end
