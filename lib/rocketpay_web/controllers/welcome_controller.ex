defmodule RocketpayWeb.WelcomeController do

  # Modulo com nome do contexto em que está inserido (rocketpayweb)
  # Modulo: agrupamento de funcoes

  # define que é controller
  use RocketpayWeb, :controller

  # todo controller recebe 2 parametros, para ignorar parametro, usar _ antes
  def index(conn, _params) do
    text(conn, "Welcome to the RocketPayAPI")
  end

end
