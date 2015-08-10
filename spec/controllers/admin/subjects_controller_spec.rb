require "spec_helper"
require "rails_helper"

describe Admin::SubjectsController do
  let!(:admin){FactoryGirl.create :admin}
  let!(:subject){FactoryGirl.create :subject}
  let!(:another_subject){FactoryGirl.create :subject}
  before{sign_in admin}
  
  describe "GET index" do
    before{get :index}
    it{expect(response).to be_success}
    it{expect(response).to have_http_status 200}
    it{expect(response).to render_template :index}
    it{expect(assigns(:subjects)).to match_array([subject, another_subject])}
  end

  describe "GET new" do
    before{get :new}
    it{expect(response).to be_success}
    it{expect(response).to have_http_status 200}
    it{expect(response).to render_template :new}
  end

  describe "POST create" do
    context "with invalid name" do
      before{post :create, subject: FactoryGirl.attributes_for(:invalid_name_subject)}
      it{expect(response).to have_http_status 200}
      it{expect(response).to render_template :new}
    end
    context "with valid name" do
      before{post :create, subject: FactoryGirl.attributes_for(:subject)}
      it{expect(response).to have_http_status 302}
      it{expect(response).to redirect_to action: :index}
    end
  end

  describe "DELETE destroy" do
    before{delete :destroy, id: subject.id}
    it{expect(response).to redirect_to action: :index}
    it{expect(response).to have_http_status 302}
  end
end
