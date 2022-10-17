FactoryBot.define do
    factory :post do
        link_to_example_image = "spec/fixtures/logo.jpg"
        name { "Example post" }
        image { Rack::Test::UploadedFile.new link_to_example_image, "image/jpg" }
        association :author, factory: :user
    end
end