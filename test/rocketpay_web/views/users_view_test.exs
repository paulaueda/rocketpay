defmodule RocketpayWeb.UsersViewTest do
  use RocketpayWeb.ConnCase

  # para usar o render
  import Phoenix.View

  alias Rocketpay.{Account, User}
  alias RocketpayWeb.UsersView

  test "renders create.json" do
    params = %{
      name: "Brioche",
      password: "bibihtinha00",
      nickname: "bibilindinha",
      email: "briochinha@gmail.com",
      age: 80
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} =
      Rocketpay.create_user(params)

    response = render(UsersView, "create.json", user: user)

    # balance = Decimal.new("0.00")

    # assert %{
    #          message: "User created",
    #          user: %{
    #            account: %{
    #              balance: ^balance,
    #              id: ^account_id
    #            },
    #            id: ^user_id,
    #            name: "Brioche",
    #            nickname: "bibilindinha"
    #          }
    #        } = response

    expected_response = %{
               message: "User created",
               user: %{
                 account: %{
                   balance: Decimal.new("0.00"),
                   id: account_id
                 },
                 id: user_id,
                 name: "Brioche",
                 nickname: "bibilindinha"
               }
             }
    assert expected_response == response
  end
end
