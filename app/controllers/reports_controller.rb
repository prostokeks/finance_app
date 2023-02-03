class ReportsController < ApplicationController
  def index
    @categories = Category.where(user_id: User.where(workgroup: "admin")).or(Category.where(user_id: current_user.id))
  end

  def report_by_category
    operations = Operation.where(user_id: current_user.id)
    start_date = params[:start_date]
    end_date = params[:end_date]
    type_operation = params[:type_operation]
    category = params[:category]
    t_operation = operations.where(type_operation: type_operation)

    if category == "Виберіть категорію"
      date = t_operation.where("odate BETWEEN ? AND ?", start_date, end_date).group("category_id").sum(:amount)
      all_amount = t_operation.where("odate BETWEEN ? AND ?", start_date, end_date).sum(:amount)
    else
      cat = t_operation.where(category_id: category)
      date = cat.where("odate BETWEEN ? AND ?", start_date, end_date).group("category_id").sum(:amount)
      all_amount = cat.where("odate BETWEEN ? AND ?", start_date, end_date).sum(:amount)
    end

    @all = date
    @all_amount = all_amount
    @category = date.map { |e| e[0]}
    @amount = date.map { |e| e[1].to_f}
    @start_date = start_date
    @end_date = end_date
    @t_operation = type_operation
  end

  def report_by_dates
    operations = Operation.where(user_id: current_user.id)
    start_date = params[:start_date]
    end_date = params[:end_date]
    type_operation = params[:type_operation]
    category = params[:category]
    t_operation = operations.where(type_operation: type_operation)

    if category == "Виберіть категорію"
      date = t_operation.where("odate BETWEEN ? AND ?", start_date, end_date).group("odate").sum(:amount)
      all_amount = t_operation.where("odate BETWEEN ? AND ?", start_date, end_date).sum(:amount)
    else
      cat = t_operation.where(category_id: category)
      date = cat.where("odate BETWEEN ? AND ?", start_date, end_date).group("odate").sum(:amount)
      all_amount = cat.where("odate BETWEEN ? AND ?", start_date, end_date).sum(:amount)
    end

    @all = date
    @all_amount = all_amount
    @dates = date.map { |e| e[0].to_s}
    @amount = date.map { |e| e[1].to_f}
    @start_date = start_date
    @end_date = end_date
    @t_operation = type_operation
  end
end
