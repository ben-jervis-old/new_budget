class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  include ExpensesHelper

  # GET /expenses
  # GET /expenses.json
  def index
    if logged_in?
      @expenses = current_user.expenses.all.sort { |a, b| b.convert_to_fortnightly <=> a.convert_to_fortnightly }
      @new_expense = current_user.expenses.new
      @sum_expenses = sum_fortnightly_amounts(@expenses)
      @frequencies = freq_list
      @pay_period_string = "convert_to_#{current_user.pay_period.downcase}"
      respond_to do |format|
        format.html
        format.csv { send_data @expenses.to_csv, filename: "ExpenseList#{Time.now.in_time_zone("Sydney").strftime("%H%M%S_%d%m%Y")}.csv" }
      end
    else
      redirect_to login_url
    end
  end


  # GET /expenses/1
  def show
    @frequencies = freq_list
  end

  # GET /expenses/new
  def new
    @expense = current_user.expenses.new
    @frequencies = freq_list
  end

  # GET /expenses/1/edit
  def edit
    @frequencies = freq_list
  end

  # POST /expenses
  # POST /expenses.json
  def create
    @expense = current_user.expenses.new(expense_params)
    if @expense.save
      flash.now[:success] = 'Expense was successfully created'
      redirect_to expenses_path
    else
      flash.now[:danger] = 'Expense creation failed'
      render 'index'
    end
  end

  # PATCH/PUT /expenses/1
  def update
    if @expense.update(expense_params)
      flash.now[:success] = 'Expense was successfully updated.'
      redirect_to root_url
    else
      flash.now[:danger] = 'Expense update failed'
      render :edit
    end
  end

  # DELETE /expenses/1
  def destroy
    @expense.destroy
    flash.now[:primary] = 'Expense was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = current_user.expenses.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_params
      params.require(:expense).permit(:title, :amount, :frequency)
    end

    def sum_fortnightly_amounts(expenses)
        sum_val = 0.0
        expenses.each { |exp| sum_val += exp.convert_to_fortnightly }
        return sum_val
    end
end
