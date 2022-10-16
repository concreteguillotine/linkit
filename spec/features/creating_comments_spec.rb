require "rails_helper"

RSpec.feature "Users can comment on Margot posts" do
    let(:user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post) }

    before do
        login_as(user)
    end

    scenario "with valid attributes" do
        visit post_path(post)

        within(".comments") do
            fill_in with: "Added a comment!"
            click_button "Create Comment"
        end

        expect(page).to have_content "Comment has been created!"

        within(".comments") do
            expect(page).to have_content "Added a comment!"
        end
    end

    scenario "with invalid attributes" do
        visit post_path(post)
        click_button "Create Comment"

        expect(page).to have_content "Comment not created, please revise."
    end
end
