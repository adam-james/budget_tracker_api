defmodule BudgetTrackerWeb.PageController do
  use BudgetTrackerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
