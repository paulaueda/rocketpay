defmodule RocketpayWeb.AccountsControllerTest do
  # para teste de controller
  use RocketpayWeb.ConnCase

  alias Rocketpay.{Account, User}

  describe "deposit/2" do
    # vai precisar criar coisas antes
    setup %{conn: conn} do
      params = %{
        name: "Brioche",
        password: "bibihtinha00",
        nickname: "bibilindinha",
        email: "briochinha@gmail.com",
        age: 80
      }

      {:ok, %User{account: %Account{id: account_id}}} = Rocketpay.create_user(params)

      conn = put_req_header(conn, "authorization", "Basic YmFuYW5hOm5hbmljYTEyMw==")

      {:ok, conn: conn, account_id: account_id}
    end

    test "when all params are valid, make the deposit", %{conn: conn, account_id: account_id} do
      params = %{"value" => "50.00"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        # isso aqui ja faz assert no status_code
        |> json_response(:ok)

      assert %{
               "message" => "Ballance changed successfully",
               "user" => %{"balance" => "50.00", "id" => _id}
             } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn, account_id: account_id} do
      params = %{"value" => "banana"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:bad_request)

      expected_response = %{"message" => "Invalid deposit value!"}
      assert expected_response == response
    end
  end
end
