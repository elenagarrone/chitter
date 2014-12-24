require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature "I should see these buttons: " do

  before(:each) do
    User.create(:name => "Elena Garrone",
    :username => "elena15",
    :email => "elena@example.com",
    :password => "elena1",
    :password_confirmation => "elena1")
  end

  context "on the homepage" do

    scenario "when signed in i should see 'Sign out'" do
      sign_in('elena15', 'elena1')
      visit '/'
      expect(page).to have_button('Sign out')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end

    scenario "when signed out I should see 'Sign in' and 'Sign out'" do
      visit '/'
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
      expect(page).not_to have_button('Sign out')
    end

  end

end
