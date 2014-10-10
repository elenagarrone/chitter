require 'spec_helper'

feature "User post a new peep" do
	scenario "when browsing the homepage" do
		expect(Peep.count).to eq(0)
		visit '/'
		add_peep("Hi everyone!")
		expect(Peep.count).to eq(1)
		peep = Peep.first
		expect(peep.message).to eq("Hi everyone!")
	end

	def add_peep(message)
		within('#new-peep') do
			fill_in 'peep', :with => message
			click_button 'Add peep'
		end
	end
end

