defmodule RocketpayWeb.FallbackController do
  use RocketpayWeb, :controller

  # para nao ter que ficar repetindo
  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(RocketpayWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
