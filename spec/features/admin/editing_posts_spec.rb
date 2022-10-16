require "rails_helper"

RSpec.feature "Admins can edit existing posts" do
    before do
        login_as(FactoryBot.create(:user, :admin))
        FactoryBot.create(:post)

        visit "/"

        within(".posts") do
            click_link "Example post"
        end

    end
    
    scenario "to change the name (for now)" do
        
        within(".post") do
            expect(page).to have_content "Example post"
            expect(page).to have_css("img[src*='logo.jpg']")
        end

        click_link "Edit post"
        fill_in "Name", with: "Ball of Chi"
        click_button "Update"

        expect(page).to have_content "This post's name has been changed!"
        expect(page).to have_content "Ball of Chi"
    end
end