require "rails_helper"

RSpec.feature "Users can sign up" do
    scenario "when providing valid details" do
        visit "/"
        click_link "Sign up"
        fill_in "Username", with: "testusername"
        fill_in "Email", with: "text@example.com"
        fill_in "Password", with: "password"
        fill_in "Password confirmation", with: "password"
        click_button "Sign up"
        expect(page). to have_content("Signed up successfully, thanks for joining the Margot Emporium!")
    end
end