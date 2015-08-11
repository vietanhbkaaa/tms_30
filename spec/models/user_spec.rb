require "rails_helper"
require "cancan/matchers"

describe "User" do
  describe "create user" do
    context "when be valid user" do
      let(:user){FactoryGirl.create :user}
      it{expect(user.errors).to be_empty}
    end
    context "when be invalid password" do
      let(:user){User.create FactoryGirl.attributes_for :invalid_password_user}
      it{expect(user.errors[:password]).to be_present}
    end
    context "when be invalid email" do
      let(:user){User.create FactoryGirl.attributes_for :invalid_email_user}
      it{expect(user.errors[:email]).to be_present}
    end
  end

  describe "has abilities" do
    context "when is an admin account" do
      let(:user){FactoryGirl.create :admin}
      subject(:ability){Ability.new(user)}
      it{is_expected.to be_able_to :manage, Course}
      it{is_expected.to be_able_to :manage, Subject}
      it{is_expected.to be_able_to :manage, User}
    end

    context "when is an normal account" do
      let(:user){FactoryGirl.create :user}
      subject(:ability){Ability.new(user)}
      it{is_expected.not_to be_able_to :manage, Course.new}
      it{is_expected.to be_able_to :manage, user.managing_courses.create(name: "new course")}
      it{is_expected.not_to be_able_to :manage, Subject}
      it{is_expected.not_to be_able_to :manage, User}
    end
  end

  describe "has 2 courses" do
    let!(:user){FactoryGirl.create :user}
    let(:user_courses){nil}
    before{
      FactoryGirl.create :user
      user.courses.create FactoryGirl.attributes_for :course
      user.courses.create FactoryGirl.attributes_for :course
    }
    it{expect(user.courses.count).to eq 2}
    context "when deleting the user" do
      before{user.destroy}
      it{expect(user.courses.count).to eq 0}
    end
  end
end
