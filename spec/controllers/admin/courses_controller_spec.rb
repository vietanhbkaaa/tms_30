require "spec_helper"
require "rails_helper"

describe Admin::CoursesController do
  let!(:admin){FactoryGirl.create :admin}
  let!(:course){FactoryGirl.create :course}
  let!(:another_course){FactoryGirl.create :course}
  before{sign_in admin}

  describe "GET index" do
    before{get :index}
    it{expect(response).to be_success}
    it{expect(response).to have_http_status 200}
    it{expect(response).to render_template :index}
    it{expect(assigns(:courses)).to match_array([course, another_course])}
  end

  describe "GET new" do
    before{get :new}
    it{expect(response).to be_success}
    it{expect(response).to have_http_status 200}
    it{expect(response).to render_template :new}
  end

  describe "POST create" do
    context "with invalid name" do
      before{post :create, course: FactoryGirl.attributes_for(:invalid_name_course)}
      it{expect(response).to have_http_status 200}
      it{expect(response).to render_template :new}
    end
    context "with valid name" do
      before{post :create, course: FactoryGirl.attributes_for(:course)}
      it{expect(response).to have_http_status 302}
      it{expect(response).to redirect_to action: :index}
    end
  end

  describe "DELETE destroy" do
    before{delete :destroy, id: course.id}
    it{expect(response).to redirect_to action: :index}
    it{expect(response).to have_http_status 302}
  end
end
