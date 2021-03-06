# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'
    when /^the "edit" page for "(.*)"$/ 
      edit_ca_path(Ca.find_by name: $1)
    when /^the "CA page"$/ 
      cas_path
    when /^the CA page$/
      cas_path
    when /^the CA page for "(.*)"$/
      ca_path(Ca.find_by name: $1)
    when /^the CA page for email "(.*)"$/
      ca_path(Ca.find_by email: $1)
    when /^the "Add CA page"$/
      new_ca_path
    when /^the add CA page$/
      new_ca_path
    when /^"Details" for the CA "(.*)"$/
      ca_path(Ca.find_by name: $1)
    when /^the "Details" page for the CA "(.*)"$/
      ca_path(Ca.find_by name: $1)
    when /^the login page$/
      '/auth/login'
    when /^the auth page$/
      '/auth/google_oauth2'
    when /^the auth callback$/
      '/auth/google_oauth2/callback'
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
