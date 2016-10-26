require 'rails_helper'

RSpec.describe "schedulers/edit", type: :view do
  before(:each) do
    @scheduler = assign(:scheduler, Scheduler.create!(
      :name => "MyString",
      :email => "MyString",
      :login => "MyString"
    ))
  end

  it "renders the edit scheduler form" do
    render

    assert_select "form[action=?][method=?]", scheduler_path(@scheduler), "post" do

      assert_select "input#scheduler_name[name=?]", "scheduler[name]"

      assert_select "input#scheduler_email[name=?]", "scheduler[email]"

      assert_select "input#scheduler_login[name=?]", "scheduler[login]"
    end
  end
end
