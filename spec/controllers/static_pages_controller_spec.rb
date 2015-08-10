require "rails_helper"

describe StaticPagesController do
  describe "GET home" do
    context "with guess" do
      before{get :home}
      it{expect(response).to redirect_to new_user_session_path}
      it{expect(response).to have_http_status 302}
    end
    context "with logged user" do
      let!(:user){FactoryGirl.create :user}
      before{
        sign_in user
        get :home
      }
      it{expect(response).to be_success}
      it{expect(response).to have_http_status 200}
      it{expect(response).to render_template :home}
    end
  end
end
