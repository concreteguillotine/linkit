require "rails_helper"

RSpec.feature "Admins can delete existing Margots" do
    before do
        login_as(FactoryBot.create(:user, :admin))
    end

    scenario "successfully" do
        FactoryBot.create(:post)

        visit "/"

        within(".posts") do
            click_link "Example Margot"
        end
        
        click_link "Remove this Margot"

        expect(page).to have_content "Margot successfully removed."
        expect(page.current_url).to eq posts_url
        expect(page).to have_no_content "Example Margot"
    end
end