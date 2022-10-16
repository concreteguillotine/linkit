require "rails_helper"

RSpec.feature "Users can only see the appropriate links" do
    let(:user) { FactoryBot.create(:user) }
    let(:admin) { FactoryBot.create(:user, :admin) }
    let(:post) { FactoryBot.create(:post) }

    context "anonymous users" do
        scenario "cannot see the New post link" do
            visit "/"
            expect(page).not_to have_link "New post"
        end

        scenario "cannot see the Edit post or Remove post links" do
            visit post_path(post)
            expect(page).not_to have_link "Edit post"
            expect(page).not_to have_link "Remove post"
        end
    end

    context "regular users" do
        before { login_as(user) }

        scenario "cannot see the New post link" do
            visit "/"
            expect(page).not_to have_link "New post"
        end

        scenario "cannot see the Edit post or Remove post links" do
            visit post_path(post)
            expect(page).not_to have_link "Edit post"
            expect(page).not_to have_link "Remove post"
        end
    end

    context "admin users" do
        before { login_as(admin) }

        scenario "can see the New post link" do
            visit "/"
            expect(page).to have_link "New post"
        end

        scenario "can see the Edit post or Remove post links" do
            visit post_path(post)
            expect(page).to have_link "Edit post"
            expect(page).to have_link "Remove post"
        end
    end
end