require "rails_helper"

RSpec.feature "Posts can be seen on the homepage" do
    before do
        login_as(FactoryBot.create(:user, :admin))
        visit "/"
    end

    scenario "and clicking the image or name will take you to the post" do

        click_link "Image post"

        fill_in "Name", with: "Chi Ball"
        attach_file("Image", "spec/fixtures/logo.jpg")
        click_button "Create Post"
        expect(page). to have_content "This post has been added!"

        click_link "Return home"
        
        within(".posts") do
            expect(page).to have_content "Chi Ball"
            expect(page).to have_css("img[src*='logo.jpg']")
        end
    end
end
