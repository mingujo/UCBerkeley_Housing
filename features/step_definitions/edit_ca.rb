
Given /^the following CAs exist:$/ do |cas_table|
  cas_table.hashes.each do |ca|
    cas = Ca.new(:name => ca["name"], :email =>
ca["email"], :phone_number => ca["phone_number"])
    cas.save
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
end





