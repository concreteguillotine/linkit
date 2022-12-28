require "rails_helper"
require "email_spec"
require "email_spec/rspec"


RSpec.feature "Users receive notifications about new tag posts" do
    include ActiveJob::TestHelper

    let(:user1) { FactoryBot.create(:user, email: "user1@example.com") }
    let(:user2) { FactoryBot.create(:user, email: "user2@example.com") }
    let(:tag) { FactoryBot.create(:tag, name: "text") }

    before do
        tag.subscribers << user1

        login_as(user2)
        visit "/"
        within(".sidebar .actions") do
            click_link "text post"
        end
    end

    scenario "subscribers to tags get notified when a new post is made" do
        fill_in "Name", with: "Check out this meme"
        fill_in "Text", with: "Gabba-ghoul"
        click_button "Create Post"

        perform_enqueued_jobs

        email = find_email!(user1.email)
        expected_subject = "#{tag.name} has new posts!"
        expect(email.subject).to eq expected_subject

        click_email_link_matching(/post/, email)
        expect(current_path).to eq tag_show_path(tag)
    end
end
