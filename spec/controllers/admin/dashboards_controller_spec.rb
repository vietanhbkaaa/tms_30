require "rails_helper"

describe Admin::DashboardsController do
  let!(:admin){FactoryGirl.create :admin}
  let!(:user){FactoryGirl.create :user}
  describe "GET index" do
    context "with un-admin account" do
      before{
        sign_in user
        get :index
      }
      it{expect(response).to redirect_to root_path}
      it{expect(response).to have_http_status 302}
    end
    context "with admin account" do
      before{
        sign_in admin
        get :index
      }
      it{expect(response).to be_success}
      it{expect(response).to have_http_status 200}
      it{expect(response).to render_template :index}
    end
  end
end
