require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature "Buttons: " do

  before(:each) do
    User.create(:name => "Elena Garrone",
    :username => "elena15",
    :email => "elena@example.com",
    :password => "elena1",
    :password_confirmation => "elena1")
    sign_in('elena15', 'elena1')
  end

  context "on the homepage" do

    scenario "when signed in i should see 'Sign out'" do
      visit '/'
      expect(page).to have_button('Sign out')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end

    scenario "when signed out I should see 'Sign in' and 'Sign out'" do
      sign_out
      visit '/'
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
      expect(page).not_to have_button('Sign out')
    end

  end

  context "on the sign up page" do

    scenario "I should see 'sign in'" do
      visit '/users/new'
      expect(page).to have_link('Sign in')
    end

  end

end
