defmodule BudgetTrackerWeb.ExpenseController do
  use BudgetTrackerWeb, :controller
  use PhoenixSwagger

  alias BudgetTracker.Tracker
  alias BudgetTracker.Tracker.Expense

  action_fallback BudgetTrackerWeb.FallbackController

  # TODO: Add tags to this once tags added.
  def swagger_definitions do
    %{
      Expense: swagger_schema do
        title "Expense"
        description "An expense"
        properties do
          amount :float, "Amount spent", required: true
          date :date, "The date of expense", required: true
          description :string, "A description", required: true
        end
        example %{
          amount: 75,
          date: "2018-10-05",
          description: "gym membership"
        }
      end,
      Expenses: swagger_schema do
        title "Expenses"
        description "A collection of Expenses"
        type :array
        items Schema.ref(:Expense)
      end
    }
  end

  swagger_path :index do
    get "/api/expenses"
    description "List expenses"
    produces "application/json"
    response 200, "Success"
  end

  def index(conn, _params) do
    expenses = Tracker.list_expenses()
    render(conn, "index.json", expenses: expenses)
  end

  swagger_path :create do
    post "/api/expenses"
    description "Create new expense"
    produces "application/json"
    response 200, "Success"
  end

  def create(conn, %{"expense" => expense_params}) do
    with {:ok, %Expense{} = expense} <- Tracker.create_expense(expense_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", expense_path(conn, :show, expense))
      |> render("show.json", expense: expense)
    end
  end

  swagger_path :show do
    get "/api/expenses/{expense_id}"
    description "Get an expense by id"
    produces "application/json"
    parameters do
      expense_id :path, :string, "Expense ID", required: true
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
