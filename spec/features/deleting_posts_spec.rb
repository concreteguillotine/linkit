require "rails_helper"

RSpec.feature "OP's and admins can delete existing posts" do
    let(:user) { FactoryBot.create(:user, username: "user1") }
    let(:admin) { FactoryBot.create(:user, :admin) }
    let!(:post) { FactoryBot.create(:post, author: user) }

    scenario "successfully" do
        login_as(user)
        
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