require "spec_helper"

module Refinery
  module API
    RSpec.describe Images do
      let(:client) { Images.new }
      let(:image_cat) do
        { "image" => {
            "image" => [upload_file('thinking-cat.jpg')],
            "image_title" => 'Cat'
          }
        }
      end

      describe "#index" do
        it "fetches a list of images" do
          VCR.use_cassette("images/index") do
            response = client.index
            expect(response.status).to eq(200)
            expect(JSON.parse(response.body)["images"]).not_to be_empty
          end
        end
      end

      # Still buggy, look at upload_file function into fixtures_helpers.rb
      # describe "#create" do
      #   it "creates a image" do
      #     VCR.use_cassette("images/create") do
      #       response = client.create(image: image_cat)
      #       expect(response.status).to eq(201)
      #       expect(JSON.parse(response.body)["image_title"]).to eq("Cat")
      #     end
      #   end
      # end

      #   it "returns errors when payload is invalid" do
      #     VCR.use_cassette("products/create/invalid") do
      #       response = client.create(product: payload["product"].update(name: ""))
      #       expect(response.status).to eq(422)

      #       expect(JSON.parse(response.body)["errors"]["name"])
      #         .to(include("can't be blank"))
      #     end
      #   end
      # end

      describe "#show" do
        it "retrieves a given image's attributes" do
          VCR.use_cassette("images/show") do
            response = client.show(id: 1)
            expect(response.status).to eq(200)
            expect(JSON.parse(response.body)["image_title"]).to eq("entreprise")
          end
        end
      end

      # describe "#update" do
      #   it "updates attributes on the given product" do
      #     VCR.use_cassette("products/update") do
      #       response = client.update(id: 10,
      #         product: { product: { name: "Cool updated" } })

      #       expect(response.status).to eq(200)
      #       expect(JSON.parse(response.body)["name"]).to eq("Cool updated")
      #     end
      #   end

      #   it "returns errors if the payload is not valid" do
      #     VCR.use_cassette("products/update/invalid") do
      #       response = client.update(id: 9,
      #         product: { product: { name: "" } })

      #       expect(response.status).to eq(422)
      #       expect(JSON.parse(response.body)["errors"]["name"])
      #         .to(include("can't be blank"))
      #     end
      #   end
      # end

      # describe "#delete" do
      #   it "deletes a given product" do
      #     VCR.use_cassette("products/delete") do
      #       response = client.delete(id: 10)
      #       expect(response.status).to eq(204)
      #     end
      #   end
      # end
    end
  end
end
