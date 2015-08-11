require "rails_helper"

describe "courses/show.html.erb" do
  subject{rendered}
  let!(:user){FactoryGirl.create :user}
  let(:admin){FactoryGirl.create :admin}
  let!(:course){user.courses.create FactoryGirl.attributes_for :course}
  before{
    course.subjects.create FactoryGirl.attributes_for :subject
    course.subjects.create FactoryGirl.attributes_for :subject
    assign :course, course
  }
  context "when user is only a trainee" do
    before{
      sign_in user
      render
    }
    it{is_expected.to have_content course.name}
    it{is_expected.to have_content course.closed ? "CLOSED" : "OPENNING"}
    it{is_expected.to have_content course.description}
    it{is_expected.to have_content "Time Duration"}
    it{is_expected.to have_link course.subjects[0].name}
    it{is_expected.to have_link course.subjects[1].name}
  end

  context "when user is admin" do
    before{
      sign_in admin
      render
    }
    it{is_expected.to have_link "Manage"}
  end

  context "when user is the supervisor" do
    before{
      supervisor = course.supervisors.create FactoryGirl.attributes_for :user
      sign_in supervisor
      render
    }
    it{is_expected.to have_content "Manage"}
  end
end
