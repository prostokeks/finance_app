class CategoriesController < ApplicationController

  before_action :set_category, only: %i[edit update destroy]

  def index
    @user = User.where(workgroup: "admin")
    @categories = Category.where(user_id: @user).or(Category.where(user_id: current_user.id)).page(params[:page])
  end

  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.build(category_params)
    if @category.save
      redirect_to categories_path, notice: "Категорію успішно створено."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: "Категорію успішно оновлено."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path, status: :see_other, notice: "Категорію успішно видалено."
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
