require 'spec_helper'

feature "In order to see what people have to say, I want to see all peeps: " do
	before(:each) {
		Peep.create(:message => "Hi everyone!")
	}

	scenario "when opening the homepage" do
		visit'/'
		expect(page).to have_content("Hi everyone!")
	end
end


context "In order to use chitter as a maker I want to: " do
	
	feature "sign up to the service" do
		scenario "when being logged out" do
			expect{sign_up}.to change(User, :count).by(1)
			expect(page).to have_content("Welcome to Chitter!")
			expect(User.first.username).to eq("elena15")
		end

		def sign_up(username = "elena15",
					email = "elena@example.com",
					password = "elena")
			visit 'users/new'
			expect(page.status_code).to eq(200)
			fill_in :username, :with => username
			fill_in :email, :with => email
			fill_in :password, :with => password
			click_button "Sign up"
		end
	end


end