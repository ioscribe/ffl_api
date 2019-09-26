defmodule FflApiWeb.Router do
  use FflApiWeb, :router

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

  scope "/", FflApiWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", FflApiWeb do
    pipe_through :api
    resources "/dealers", DealerController, except: [:new, :edit]
    resources "/dealer_options", DealerOptionController, except: [:new, :edit]
  end

  # Other scopes may use custom stacks.
  # scope "/api", FflApiWeb do
  #   pipe_through :api
  # end
end
