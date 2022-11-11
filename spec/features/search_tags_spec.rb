require "rails_helper"

RSpec.feature "users can search for tags and then see the posts that come up" do

    before do
        login_as(FactoryBot.create(:user))
        visit "/"
        click_link "Text post"
    end

    scenario "tag search" do
        fill_in "Name", with: "Example post"
        fill_in "Text", with: "This is an example post"
        fill_in "Tags", with: "test, text"
        click_button "Create Post"

        expect(page).to have_content "This post has been added!"

        visit "/"

        within(".sidebar") do
            fill_in "search", with: "test"
            click_button "Search"
        end
                
        within(".tags") do
            expect(page).to have_content "test"
            expect(page).not_to have_content "text"
        end
    end
end
            