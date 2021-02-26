defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = %{
        name: "Brioche",
        password: "bibihtinha00",
        nickname: "bibilindinha",
        email: "briochinha@gmail.com",
        age: 80
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      # ^upin operator para não usar pattern matching, fixa valor anteriormente
      # preestabelecido
      assert %User{name: "Brioche", age: 80, id: ^user_id} = user
    end

    test "when there are invalid params, returns an error" do
      params = %{
        name: "Brioche",
        nickname: "bibilindinha",
        email: "briochinha@gmail.com",
        age: 15
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }

      # errors_on é da DataCase, além disto o DataCase configura o banco
      # para sandbox nos tests, depois de rodar tudo da rollback
      assert errors_on(changeset) == expected_response
    end
  end
end
