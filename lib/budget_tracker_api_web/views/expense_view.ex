defmodule BudgetTrackerWeb.ExpenseView do
  use BudgetTrackerWeb, :view
  alias BudgetTrackerWeb.ExpenseView
  alias BudgetTrackerWeb.TagView

  def render("index.json", %{expenses: expenses}) do
    %{data: render_many(expenses, ExpenseView, "expense.json")}
  end

  def render("show.json", %{expense: expense}) do
    %{data: render_one(expense, ExpenseView, "expense.json")}
  end

  def render("expense.json", %{expense: expense}) do
    %{id: expense.id,
      date: expense.date,
      description: expense.description,
      amount: expense.amount,
      tags: render_many(expense.tags, TagView, "tag.json")}
  end
end
