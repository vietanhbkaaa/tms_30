require "rails_helper"

describe Course do
  describe "create course" do
    context "when valid name" do
      let(:course){FactoryGirl.create :course}
      it{expect(course.errors).to be_empty}
    end
    context "when invalid name" do
      let(:course){Course.create FactoryGirl.attributes_for :invalid_name_course}
      it{expect(course.errors[:name]).to be_present}
    end
  end

  describe "has 2 subjects" do
    let!(:course){FactoryGirl.create :course}
    let(:course_subjects){nil}
    before{
      FactoryGirl.create :course
      course.subjects.create FactoryGirl.attributes_for :subject
      course.subjects.create FactoryGirl.attributes_for :subject
    }
    it{expect(course.subjects.count).to eq 2}
    context "when deleting the course" do
      before{course.destroy}
      it{expect(course.subjects.count).to eq 0}
    end
  end

  describe "association" do
    it{should have_many :course_subjects}
    it{should have_many :user_courses}
    it{should have_many :supervisor_courses}
    it{should have_many(:subjects).through :course_subjects}
    it{should have_many(:users).through :user_courses}
    it{should have_many(:supervisors).through :supervisor_courses}
    it{should have_many(:tasks).through :subjects}
  end

  describe "#date_duration" do
    let!(:course){FactoryGirl.create :course}
    let!(:subject){course.subjects.create name: "subject", date_duration: 3}
    let!(:another_subject){course.subjects.create name: "another subject", date_duration: 2}
    it{expect(course.date_duration).to eq subject.date_duration + another_subject.date_duration}
  end

  describe "#expired_date" do
    let!(:course){FactoryGirl.create :course}
    let!(:subject){course.subjects.create name: "subject", date_duration: 3}
    it{expect(course.expired_date).to eq course.created_at + subject.date_duration.day}
  end
end
