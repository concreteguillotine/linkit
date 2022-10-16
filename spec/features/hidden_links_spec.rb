require "rails_helper"

RSpec.feature "Users can only see the appropriate links" do
    let(:user) { FactoryBot.create(:user) }
    let(:admin) { FactoryBot.create(:user, :admin) }
    let(:post) { FactoryBot.create(:post) }

    context "anonymous users" do
        scenario "cannot see the New Margot link" do
            visit "/"
            expect(page).not_to have_link "New Margot"
        end

        scenario "cannot see the Edit this Margot or Remove this Margot links" do
            visit post_path(post)
            expect(page).not_to have_link "Edit this Margot"
            expect(page).not_to have_link "Remove this Margot"
        end
    end

    context "regular users" do
        before { login_as(user) }

        scenario "cannot see the New Margot link" do
            visit "/"
            expect(page).not_to have_link "New Margot"
        end

        scenario "cannot see the Edit this Margot or Remove this Margot links" do
            visit post_path(post)
            expect(page).not_to have_link "Edit this Margot"
            expect(page).not_to have_link "Remove this Margot"
        end
    end

    context "admin users" do
        before { login_as(admin) }

        scenario "can see the New Margot link" do
            visit "/"
            expect(page).to have_link "New Margot"
        end

        scenario "can see the Edit this Margot or Remove this Margot links" do
            visit post_path(post)
            expect(page).to have_link "Edit this Margot"
            expect(page).to have_link "Remove this Margot"
        end
    end
end