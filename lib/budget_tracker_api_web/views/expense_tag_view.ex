defmodule BudgetTrackerWeb.ExpenseTagView do
  use BudgetTrackerWeb, :view
  alias BudgetTrackerWeb.ExpenseTagView

  def render("show.json", %{expense_tag: expense_tag}) do
    %{data: render_one(expense_tag, ExpenseTagView, "expense_tag.json")}
  end

  def render("expense_tag.json", %{expense_tag: expense_tag}) do
    %{expense_id: expense_tag.expense_id,
      tag_id: expense_tag.tag_id}
  end

  def render("errors.json", %{errors: errors}) do
    %{errors: errors}
  end
end
