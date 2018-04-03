defmodule BudgetTrackerWeb.Router do
  use BudgetTrackerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BudgetTrackerWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", BudgetTrackerWeb do
    pipe_through :api

    resources "/expenses", ExpenseController, except: [:new, :edit] do
      resources "/tags", ExpenseTagController, only: [:create]
    end
    resources "/tags", TagController, except: [:new, :edit]
  end
end
