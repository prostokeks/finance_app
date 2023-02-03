class OperationsController < ApplicationController

  before_action :set_operation, only: %i[show edit update destroy]

  def show
  end

  def new
    @operation = Operation.new
  end

  def create
    @operation = current_user.operations.build(operation_params)
    if @operation.save
      redirect_to root_path, notice: "Операцію успішно створено."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @operation.update(operation_params)
      redirect_to root_path, notice: "Операцію успішно оновлено."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @operation.destroy
    redirect_to operations_path, status: :see_other, notice: "Операцію успішно видалено."
  end

  private

  def operation_params
    params.require(:operation).permit(:amount, :description, :odate, :type_operation, :category_id, images:[])
  end

  def set_operation
    @operation = Operation.find(params[:id])
  end

end