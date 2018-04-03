defmodule BudgetTracker.Tracker.ExpenseTag do
  use Ecto.Schema
  import Ecto.Changeset
  alias BudgetTracker.Tracker.{Expense, ExpenseTag, Tag}


  schema "expenses_tags" do
    belongs_to :expense, Expense
    belongs_to :tag, Tag

    timestamps()
  end

  @doc false
  def changeset(%ExpenseTag{} = expense_tag, attrs) do
    expense_tag
    |> cast(attrs, [:expense_id, :tag_id])
    |> validate_required([:expense_id, :tag_id])
    |> unique_constraint(:tag_id, name: :expenses_tags_expense_id_tag_id_index)
  end
end
