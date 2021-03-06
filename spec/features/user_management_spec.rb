require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature "In order to see what people have to say, I want to see all peeps: " do

  before(:each) do
    Peep.create(:message => "Hi everyone!")
  end

  scenario "when opening the homepage" do
    visit'/'
    sign_up
    add_peep("Hi everyone!")
    expect(page).to have_content("Hi everyone!")
  end

end


context "In order to use chitter as a maker I want to: " do

  feature "sign up to the service" do

    scenario "when being logged out" do
      expect{ sign_up }.to change(User, :count).by(1)
      expect(page).to have_content("CHITTER")
      expect(User.first.username).to eq("elena15")
    end

    scenario "with a password that doesn't match" do
      expect{ sign_up('ele', 'ele', 'e@e.com', 'tratra', 'username') }.to change(User, :count).by (0)
      expect(current_path).to eq('/users')
      expect(page).to have_content("Your passwords don't match")
    end

    scenario "with a password that is not long enough" do
      expect{ sign_up('ele', 'ele', 'e@e.com', 'four', 'four') }.to change(User, :count).by (0)
      expect(page).to have_content("Password needs to be of at least 6 characters")
    end

    scenario "with an email that is already registered" do
      expect{ sign_up }.to change(User, :count).by(1)
      expect{ sign_up }.to change(User, :count).by(0)
      expect(page).to have_content("This email is already taken")
    end

    scenario "with a username that is already taken" do
      expect{ sign_up }.to change(User, :count).by(1)
      expect{ sign_up }.to change(User, :count).by(0)
      expect(page).to have_content("This username is already taken")
    end

    scenario "with a username that is longer than what it should be" do
      expect{ sign_up('ele', '111111111111111111111', 'e@e.com', 'helloo', 'helloo') }.to change(User, :count).by (0)
      expect(page).to have_content("Username must be between 1 and 20 characters long")
    end

  end

  feature "sign in" do

    before(:each) do
      User.create(:name => "Elena Garrone",
        :username => "elena15",
        :email => "elena@example.com",
        :password => "elena1",
        :password_confirmation => "elena1")
    end

    scenario "with correct credentials" do
      visit '/'
      expect(page).not_to have_content("Welcome, elena15")
      sign_in('elena15', 'elena1')
      expect(page).to have_content("Welcome, elena15")
    end

    scenario "with incorrect credentials" do
      visit '/'
      expect(page).not_to have_content("Welcome, elena15")
      sign_in('elena15', 'wrong1')
      expect(page).not_to have_content("Welcome, elena15")
    end

  end

  feature "sign out" do

    before(:each) do
      User.create(:name => "Elena Garrone",
        :username => "elena15",
        :email => "elena@example.com",
        :password => "elena1",
        :password_confirmation => "elena1")
    end

    scenario "while being signed in" do
      sign_in('elena15', 'elena1')
      click_button "Sign out"
      expect(page).to have_content("Good bye!")
      expect(page).not_to have_content("Welcome, elena15")
    end

  end

end
