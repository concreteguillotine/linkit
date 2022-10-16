require "rails_helper"

RSpec.feature "Admins can remove comments from Margot posts" do
  let(:admin) { FactoryBot.create(:user, :admin) }
  let(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post) }
  let(:comment) { FactoryBot.create(:comment, post: post) }

  scenario "by clicking a link" do
    login_as(admin)
    visit post_path(post)

    within(".comments") do
      fill_in with: "Added a comment!"
      click_button "Create Comment"
      click_link "Delete Comment"
    end

    expect(page).to have_content "Comment removed successfully."
  end

  scenario "but regular users can't" do
    login_as(user)
    visit post_path(post)

    within(".comments") do
      fill_in with: "Added a comment!"
      click_button "Create Comment"

      expect(page).to have_content "Added a comment!"
      expect(page).to_not have_button "Delete Comment"
    end
  end
end
