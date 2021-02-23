defmodule Rocketpay do
  alias Rocketpay.Users.Create, as: UserCreate

  # Criando a fachada: Rocketpay.create_user
  defdelegate create_user(params), to: UserCreate, as: :call
end
