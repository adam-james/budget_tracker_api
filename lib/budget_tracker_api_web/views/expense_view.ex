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
    if is_list(expense.tags) do
      render_with_tags(expense)
    else
      render_without_tags(expense)
    end
  end

  defp render_with_tags(expense) do
    %{id: expense.id,
      date: expense.date,
      description: expense.description,
      amount: expense.amount,
      tags: render_many(expense.tags, TagView, "tag.json")}
  end

  defp render_without_tags(expense) do
    %{id: expense.id,
      date: expense.date,
      description: expense.description,
      amount: expense.amount}
  end
end
