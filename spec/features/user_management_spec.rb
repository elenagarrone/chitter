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

		scenario "with a password that doesn't match" do
			expect{sign_up('e@e.com', 'pass', 'tra', 'username')}.to change(User, :count).by (0)
		end

		scenario "with a password that doesn't match" do
			expect{sign_up('e@e.com', 'pass', 'tra', 'username')}.to change(User, :count).by (0)
			expect(current_path).to eq('/users')
			expect(page).to have_content("Sorry, ether your password is incorrect or your username is already in use. Try again.")
		end


		def sign_up(name = "Elena Garrone",
					username = "elena15",
					email = "elena@example.com",
					password = "elena",
					password_confirmation = "elena")
			visit 'users/new'
			expect(page.status_code).to eq(200)
			fill_in :name, :with => name
			fill_in :username, :with => username
			fill_in :email, :with => email
			fill_in :password, :with => password
			fill_in :password_confirmation, :with => password_confirmation
			click_button "Sign up"
		end

	end


end