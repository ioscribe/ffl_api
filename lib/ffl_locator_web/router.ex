defmodule FflLocatorWeb.Router do
  use FflLocatorWeb, :router

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

  scope "/", FflLocatorWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/install", BigCommerceController, :install
    get "/load", BigCommerceController, :load
  end

  # Other scopes may use custom stacks.
  scope "/api", FflLocatorWeb do
    pipe_through :api
    resources "/dealers", DealerController, except: [:new, :edit]
  end
end
