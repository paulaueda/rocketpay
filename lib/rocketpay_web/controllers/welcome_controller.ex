defmodule RocketpayWeb.WelcomeController do

  # Modulo com nome do contexto em que está inserido (rocketpayweb)
  # Modulo: agrupamento de funcoes

  # define que é controller
  use RocketpayWeb, :controller

  # Assim posso chamar só por Numbers
  alias Rocketpay.Numbers


  # Action de controler precisa receber conexao

  # todo controller recebe 2 parametros, para ignorar parametro,
  # usar _params
  # pegando o valor do filename e salvando numa variável
  # %{value: x} = %{filename: "numbers", value: 5}
  # x = 5 (pattern matching)

  # text(conn, "Welcome to the RocketPayAPI")
  def index(conn, %{"filename" => filename}) do
    filename
    |> Numbers.sum_from_file()
    |> handle_response(conn)

  end

  defp handle_response({:ok, %{result: result}}, conn) do
    conn
    |> put_status(:ok)
    # |> IO.inspect() #printa conn (já incrementado de status 200)
    |> json(%{message: "Welcome to Rocketpay API. Here is your number #{result}"})
  end
  defp handle_response({:error, reason}, conn) do
    conn
    |> put_status(:bad_request)
    |> json(reason)
  end

end
