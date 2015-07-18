class Admin::SubjectsController < ApplicationController
  def index
    @subjects = Subject.recent.paginate page: params[:page],
      per_page: Settings.subjects.per_page
  end
end
