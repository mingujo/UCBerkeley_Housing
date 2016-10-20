#require "emails"

Given /^row "(.*)" contains e\-mail address "(.*)" and name "(.*)"$/ do |row, name, email|
    put_email(row.to_i, name, email)
end

Given /^the e\-mail address of "(.*)" should be "(.*)"$/ do |name, email|
    value = get_email_mappings[name]
    expect(value).to equal(email)
end