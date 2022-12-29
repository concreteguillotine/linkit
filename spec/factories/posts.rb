FactoryBot.define do
    factory :post do
        link_to_example_image = "spec/fixtures/avatar.png"
        name { "Example post" }
        image { Rack::Test::UploadedFile.new link_to_example_image, "image/png" }
        association :author, factory: :user
    end
end