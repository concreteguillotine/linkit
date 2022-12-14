require "rails_helper"

RSpec.feature "Users can vote on posts" do
    let(:user) { FactoryBot.create(:user) }
    let(:post_1) { FactoryBot.create(:post, name: "Chi Ball") }
    let(:post_2) { FactoryBot.create(:post, name: "Dragonmode") }


    before do
        login_as(user)

        visit post_path(post_1)
    end

    scenario "by clicking a link" do

        within(".votes") do
            click_link('like')
            expect(page).to have_content "1 like"
        end
    end

    scenario "clicking the button again takes the vote away" do
    
        click_link('like')

        click_link('unlike')

        within(".votes") do
            expect(page).to have_content "0 likes"
        end
    end
end