FactoryBot.define do
    factory :post do
        link_to_example_image = "spec/fixtures/logo.jpg"
        name { "Example Margot" }
        image { Rack::Test::UploadedFile.new link_to_example_image, "image/jpg" }
    end
end