defmodule BudgetTracker.Tracker.Expense do
  use Ecto.Schema
  import Ecto.Changeset
  alias BudgetTracker.Tracker.{ExpenseTag, Tag}


  schema "expenses" do
    field :amount, :float
    field :date, :date
    field :description, :string
    many_to_many :tags, Tag, join_through: ExpenseTag, unique: true

    timestamps()
  end

  @doc false
  def changeset(expense, attrs) do
    expense
    |> cast(attrs, [:date, :description, :amount])
    |> validate_required([:date, :description, :amount])
  end
end
