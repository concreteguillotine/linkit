require "rails_helper"

RSpec.feature "Users can edit existing posts" do
    let(:user) { FactoryBot.create(:user, username: "user1") }
    let!(:post) { FactoryBot.create(:post, author: user) }

    before do
        login_as(user)

        visit "/"

        within(".posts") do
            click_link "Example post"
        end

    end
    
    scenario "to change the name (for now)" do
        
        within(".post") do
            expect(page).to have_css("img[src*='logo.jpg']")
        end

        click_link "Edit post"
        fill_in "Name", with: "Ball of Chi"
        click_button "Update"

        expect(page).to have_content "This post's name has been changed!"
        expect(page).to have_content "Ball of Chi"
    end
end