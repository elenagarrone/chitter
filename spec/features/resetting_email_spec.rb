require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature "Resetting the password" do

  before(:each) do
    User.create(:name => "Elena Garrone",
    :username => "elena15",
    :email => "elena@example.com",
    :password => "elena",
    :password_confirmation => "elena")
  end

  scenario "when on the sign in page" do
    visit '/sessions/new'
    expect(page).to have_link('Forgot your password?')
  end

  scenario "clicking on the link" do
    visit '/sessions/new'
    click_on('Forgot your password?')
    expect(page).to have_content('Please, insert your email:')
    expect(page).to have_button('Reset Password')
  end

end
