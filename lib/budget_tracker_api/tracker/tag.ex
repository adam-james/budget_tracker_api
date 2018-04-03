defmodule BudgetTracker.Tracker.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  alias BudgetTracker.Tracker.{Expense, ExpenseTag}


  schema "tags" do
    field :name, :string
    many_to_many :expenses, Expense, join_through: ExpenseTag, unique: true

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
