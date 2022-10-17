require "rails_helper"

RSpec.feature "admins can upload images" do
    before do
        login_as(FactoryBot.create(:user))
    end
    
    scenario "with only a name and image" do
        
        visit "/"
        click_link "New post"

        fill_in "Name", with: "Chi Ball"
        attach_file("Image", "spec/fixtures/logo.jpg")
        click_button "Create Post"

        expect(page). to have_content "This post has been added!"

        within(".post") do
            expect(page).to have_content "Chi Ball"
            expect(page).to have_css("img[src*='logo.jpg']")
        end
    end
end