defmodule BudgetTrackerWeb.ExpenseTagController do
  use BudgetTrackerWeb, :controller

  alias BudgetTracker.Tracker
  alias BudgetTracker.Tracker.{ExpenseTag, Tag}

  action_fallback BudgetTrackerWeb.FallbackController

  def create(conn, %{"expense_id" => expense_id, "tag" => tag_params}) do
    expense = Tracker.get_expense!(expense_id)
    name = tag_params["name"]

    cond do
      is_nil(name) ->
        name_required(conn)
      tag = Tracker.find_tag(name) ->
        handle_add_tag(conn, expense, tag)
      true ->
        create_and_add_tag(conn, expense, tag_params)
    end
  end

  defp name_required(conn) do
    conn
    |> put_status(:bad_request)
    |> render("errors.json", %{ errors: %{"name": ["is required"]}})
  end

  defp create_and_add_tag(conn, expense, tag_params) do
    with {:ok, %Tag{} = tag} <- Tracker.create_tag(tag_params) do
      handle_add_tag(conn, expense, tag)
    end
  end

  defp handle_add_tag(conn, expense, tag) do
    with {:ok, %ExpenseTag{} = expense_tag} <- Tracker.add_tag(expense, tag) do
      conn
      |> put_status(:created)
      |> render("show.json", expense_tag: expense_tag)
    end
  end
end
