require "rails_helper"

RSpec.feature "users can create posts" do
    before do
        login_as(FactoryBot.create(:user))
        visit "/"
        click_link "Image"
    end
    
    scenario "with only a name and image" do
        fill_in "Name", with: "Chi Ball"
        attach_file("Image", "spec/fixtures/avatar.png")
        click_button "Create Post"

        expect(page). to have_content "This post has been added!"

        within(".post") do
            expect(page).to have_css("img[src*='avatar.png']")
        end
    end

    scenario "with tags as well" do
        fill_in "Name", with: "Example post"
        fill_in "Caption", with: "This is an example post"
        fill_in "Tags", with: "test, text"
        click_button "Create Post"

        expect(page). to have_content "This post has been added!"

        within(".attributes .tags") do
            expect(page).to have_content "test"
            expect(page).to have_content "text"
        end
    end
end