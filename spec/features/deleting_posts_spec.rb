require "rails_helper"

RSpec.feature "Admins can delete existing posts" do
    before do
        login_as(FactoryBot.create(:user, :admin))
    end

    scenario "successfully" do
        FactoryBot.create(:post)

        visit "/"

        within(".posts") do
            click_link "Example post"
        end
        
        click_link "Remove post"

        expect(page).to have_content "Post successfully removed."
        expect(page.current_url).to eq posts_url
        expect(page).to have_no_content "Example post"
    end
end