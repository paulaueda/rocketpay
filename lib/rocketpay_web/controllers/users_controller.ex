defmodule RocketpayWeb.UsersController do
  use RocketpayWeb, :controller

  alias Rocketpay.User

  action_fallback RocketpayWeb.FallbackController

  def create(conn, params) do
    params
    |> Rocketpay.create_user()
    |> handle_response(conn)
  end

  defp handle_response({:ok, %User{} = user}, conn) do
    conn
    |> put_status(:created)
    # aqui não precisa de put view pois utilizei o mesmo nome do controller
    # na RocketpayWeb.UsersView, assim, ele saberá
    |> render("create.json", user: user)
  end

  # Lidar com exceção: empurra o erro para o fallback
  defp handle_response({:error, _result} = error, _conn), do: error
end
