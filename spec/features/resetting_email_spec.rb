require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature "Resetting the password" do

  before(:each) do
    User.create(:name => "Elena Garrone",
    :username => "elena15",
    :email => "elena@example.com",
    :password => "elena1",
    :password_confirmation => "elena1")
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
    expect(current_path).to eq('/request_password')
  end

  scenario "entering the wrong email to reset the password" do
    visit '/request_password'
    fill_in :email, :with => 'elena@wrong.com'
    click_button('Reset Password')
    expect(page).to have_content('Sorry, there were the following problems with the form:')
    expect(page).to have_content("The user you've entered does not exist, try again.")
  end

  scenario "entering the correct email to reset the password" do
    visit '/request_password'
    fill_in :email, :with => 'elena@example.com'
    click_button('Reset Password')
    expect(page).to have_content('Here is your token:')
  end

end
