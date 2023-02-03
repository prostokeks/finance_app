class StaticPagesController < ApplicationController
  def index
    @operations = Operation.where(user_id: current_user.id).page(params[:page]) if user_signed_in?
  end

  def faq
  end
end
