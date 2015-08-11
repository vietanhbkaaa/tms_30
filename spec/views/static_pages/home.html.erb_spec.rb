require "rails_helper"

describe "static_pages/home.html.erb" do
  subject{rendered}
  let!(:user){FactoryGirl.create :user}
  before{
    sign_in user
    render
  }

  it{is_expected.to have_content "Hello, #{user.name}"}
  
  context "when user have no course" do
    it{is_expected.to have_content "You are not the trainee of any courses"}
  end
  
  context "when user have no managing course" do
    it{is_expected.to have_content "You are not the supervisor of any courses"}
  end

  context "when user has some courses" do
    let(:course){user.courses.create FactoryGirl.attributes_for :course}
    let(:another_course){user.courses.create FactoryGirl.attributes_for :course}
    before{
      assign :course, course
      assign :course, another_course
      render
    }
    it{is_expected.to have_content "Courses which you are the trainee"}
    it{is_expected.to have_content course.name}
    it{is_expected.to have_content another_course.name}
    it{is_expected.to have_link course.name}
  end

  context "when user has some managing courses" do
    let(:managing_course){user.managing_courses.create FactoryGirl.attributes_for :course}
    let(:another_manaing_course){user.managing_courses.create FactoryGirl.attributes_for :course}
    before{
      assign :managing_course, managing_course
      assign :managing_course, another_manaing_course
      render
    }
    it{is_expected.to have_content "Courses which you are the supervisor"}
    it{is_expected.to have_content managing_course.name}
    it{is_expected.to have_content another_manaing_course.name}
    it{is_expected.to have_link managing_course.name}
    it{is_expected.to have_link "Manage"}
  end
end
