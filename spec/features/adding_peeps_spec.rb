require 'spec_helper'
require_relative 'helpers/session'

feature "User post a new peep" do

	before(:each) do
		User.create(:name => "Elena Garrone",
		:username => "elena15",
		:email => "elena@example.com",
		:password => "elena",
		:password_confirmation => "elena")
	end

	feature "when browsing the homepage" do

		scenario "while signed in" do
			sign_in('elena15', 'elena')
			expect(Peep.count).to eq(0)
			visit '/'
			add_peep("Hi everyone!")
			expect(Peep.count).to eq(1)
			peep = Peep.first
			expect(peep.message).to eq("Hi everyone!")
		end

		scenario "cannot add a peep if not logged in" do
				visit '/'
				expect(page).not_to have_field('#new_peep')
				expect(page).not_to have_button('Add peep')
		end

	end

end
