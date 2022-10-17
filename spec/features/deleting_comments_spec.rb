require "rails_helper"

RSpec.feature "Users can remove comments from posts" do
  let(:admin) { FactoryBot.create(:user, :admin) }
  let(:user) { FactoryBot.create(:user, username: "user1") }
  let(:user2) { FactoryBot.create(:user, username: "user2") }
  let(:user3) { FactoryBot.create(:user, username: "user3") }
  let!(:post) { FactoryBot.create(:post, author: user) }

  before do
    login_as(user2)
    visit post_path(post)
      within(".comments") do
        fill_in with: "Added a comment!"
        click_button "Create Comment"
      end
  end

  scenario "The comment poster can" do
    within(".comments") do
      click_link "Delete Comment"
    end

    expect(page).to have_content "Comment removed successfully."
  end

  scenario "OP can" do
    login_as(user)

    within(".comments") do
      click_link "Delete Comment"
    end

    expect(page).to have_content "Comment removed successfully."
  end

  scenario "Admin can" do
    within(".comments") do
      login_as(admin)
      click_link "Delete Comment"
    end

    expect(page).to have_content "Comment removed successfully."
  end

  scenario "but other users can't" do
    login_as(user3)

    expect(page).to have_content "Added a comment!"
    expect(page).to_not have_button "Delete Comment"
  end
end
