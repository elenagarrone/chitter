require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature "User post a new peep" do

  before(:each) do
    User.create(:name => "Elena Garrone",
      :username => "elena15",
      :email => "elena@example.com",
      :password => "elena1",
      :password_confirmation => "elena1")
  end

  scenario "when browsing the homepage" do
    sign_in('elena15', 'elena1')
    expect(Peep.count).to eq(0)
    visit '/'
    add_peep("Hi everyone!")
    expect(Peep.count).to eq(1)
    peep = Peep.first
    expect(peep.message).to eq("Hi everyone!")
  end

  scenario "I should see the username of who posted the peep" do
    sign_in('elena15', 'elena1')
    visit '/'
    add_peep("Hi everyone!")
    peep = Peep.first
    expect(page).to have_content('Hi everyone! --> ' + "#{ peep.date } " + "(Peeped by: elena15)")
  end

  scenario "only when logged in" do
    visit '/'
    expect(page).not_to have_field('#new_peep')
    expect(page).not_to have_button('Add peep')
    sign_in('elena15', 'elena1')
    expect(page).to have_button('Add peep')
  end

end
