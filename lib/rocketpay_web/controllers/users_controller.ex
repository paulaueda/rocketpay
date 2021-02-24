defmodule RocketpayWeb.UsersController do
  use RocketpayWeb, :controller

  alias Rocketpay.User

  action_fallback RocketpayWeb.FallbackController

  def create(conn, params) do
    # with é pattern matching. Ele verifica um caso, executa função
    # Se o with falha, ele devolve o erro pra quem chamou a função, assim
    # o fallback controller vai receber o erro
    # pode ter vários with em cascata
    with {:ok, %User{} = user} <- Rocketpay.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end
