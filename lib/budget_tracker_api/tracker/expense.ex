defmodule BudgetTracker.Tracker.Expense do
  use Ecto.Schema
  import Ecto.Changeset


  schema "expenses" do
    field :amount, :float
    field :date, :date
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(expense, attrs) do
    expense
    |> cast(attrs, [:date, :description, :amount])
    |> validate_required([:date, :description, :amount])
  end
end
