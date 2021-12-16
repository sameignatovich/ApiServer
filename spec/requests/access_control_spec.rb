require 'rails_helper'

RSpec.describe "Access control:", type: :request do
  include AuthorizationHelper

  context "without authorization" do
    it "fetch information summary" do
      get information_summary_path
      expect(response).to have_http_status(:ok)
    end

    it "fetch users data" do
      get users_path
      expect(response).to have_http_status(:unauthorized)
    end

    it "fetch posts data" do
      get posts_path
      expect(response).to have_http_status(:unauthorized)
    end

    it "create post" do
      post posts_path
      expect(response).to have_http_status(:unauthorized)
    end

    it "create user" do
      post users_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "with blocked account" do
    user = create(:blocked_user)

    it "try to signin" do
      post signin_path, params: {
        user: {
          email: user.email,
          password: user.password
        }
      }

      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)["message"]).to match("You are blocked")
    end
  end

  context "with regular account" do
    user = create(:user)

    it "try to signin" do
      post signin_path, params: {
        user: {
          email: user.email,
          password: user.password
        }
      }

      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)["message"]).to match("Access denied")
    end
  end

  context "with admin account" do
    let(:user) { create(:admin) }

    it "try to signin" do
      post signin_path, params: {
        user: {
          email: user.email,
          password: user.password
        }
      }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["token"]).not_to be_empty
      #@headers['Authorization'] = "Bearer #{token}"
    end

    let(:token) { create(:token, user: user) }

    it "fetch information summary" do
      p token
      get information_summary_path, headers: @headers
      expect(response).to have_http_status(:ok)
    end

    it "fetch users data" do
      get users_path, headers: @headers
      expect(response).to have_http_status(:ok)
    end

    it "fetch posts data" do
      get posts_path, headers: @headers
      expect(response).to have_http_status(:ok)
    end

    it "create post" do
      post posts_path, headers: @headers
      expect(response).to have_http_status(:ok)
    end

    it "create user" do
      post users_path, headers: @headers
      expect(response).to have_http_status(:ok)
    end
  end

end
