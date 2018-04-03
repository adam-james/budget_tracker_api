defmodule BudgetTracker.Repo.Migrations.CreateExpensesTags do
  use Ecto.Migration

  def change do
    create table(:expenses_tags) do
      add :expense_id, references(:expenses, on_delete: :delete_all),
                       null: false
      add :tag_id, references(:tags, on_delete: :delete_all),
                   null: false

      timestamps()
    end

    create unique_index(:expenses_tags, [:expense_id, :tag_id])
    create index(:expenses_tags, [:expense_id])
    create index(:expenses_tags, [:tag_id])
  end
end
