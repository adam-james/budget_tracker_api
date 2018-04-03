defmodule BudgetTrackerWeb.ExpenseTagControllerTest do
  use BudgetTrackerWeb.ConnCase

  alias BudgetTracker.Tracker

  @expense_attrs %{amount: 120.5, date: ~D[2010-04-17], description: "some description"}
  @tag_attrs %{name: "tag"}

  def fixture(:expense) do
    {:ok, expense} = Tracker.create_expense(@expense_attrs)
    expense
  end

  def fixture(:tag) do
    {:ok, tag} = Tracker.create_tag(@tag_attrs)
    tag
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "add tag to expense" do
    test "renders error when no name", %{conn: conn} do
      expense = fixture(:expense)
      conn = post conn, expense_expense_tag_path(conn, :create, expense), tag: %{}

      assert json_response(conn, 400)["errors"]["name"] == ["is required"]
    end

    test "renders expense tag when tag already exists", %{conn: conn} do
      expense = fixture(:expense)
      tag = fixture(:tag)
      conn = post conn, expense_expense_tag_path(conn, :create, expense), 
                  tag: %{name: tag.name}

      assert json_response(conn, 201)["data"] == %{
        "expense_id" => expense.id,
        "tag_id" => tag.id
      }
    end

    test "renders new tag when tag doesn't exist", %{conn: conn} do
      expense = fixture(:expense)
      conn = post conn, expense_expense_tag_path(conn, :create, expense),
                        tag: %{name: "new tag"}

      assert json_response(conn, 201)["data"]["expense_id"] == expense.id
    end
  end
end
