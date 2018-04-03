defmodule BudgetTrackerWeb.ExpenseController do
  use BudgetTrackerWeb, :controller

  alias BudgetTracker.Tracker
  alias BudgetTracker.Tracker.Expense

  action_fallback BudgetTrackerWeb.FallbackController

  def index(conn, _params) do
    expenses = Tracker.list_expenses()
    render(conn, "index.json", expenses: expenses)
  end

  def create(conn, %{"expense" => expense_params}) do
    with {:ok, %Expense{} = expense} <- Tracker.create_expense(expense_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", expense_path(conn, :show, expense))
      |> render("show.json", expense: expense)
    end
  end

  def show(conn, %{"id" => id}) do
    expense = Tracker.get_expense!(id)
    render(conn, "show.json", expense: expense)
  end

  def update(conn, %{"id" => id, "expense" => expense_params}) do
    expense = Tracker.get_expense!(id)

    with {:ok, %Expense{} = expense} <- Tracker.update_expense(expense, expense_params) do
      render(conn, "show.json", expense: expense)
    end
  end

  def delete(conn, %{"id" => id}) do
    expense = Tracker.get_expense!(id)
    with {:ok, %Expense{}} <- Tracker.delete_expense(expense) do
      send_resp(conn, :no_content, "")
    end
  end
end
