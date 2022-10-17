require "rails_helper"

RSpec.feature "Users have a profile" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:post) { FactoryBot.create(:post, author: user) }

    before do
        login_as(user)
    end

    scenario "they can access it from the sidebar and see their username and posts" do
        visit "/"
        click_link "Your profile"
        expect(page).to have_content "testaccount1"
        expect(page).to have_content "Example post"
    end
end
        