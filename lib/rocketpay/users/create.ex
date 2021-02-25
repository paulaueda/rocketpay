defmodule Rocketpay.Users.Create do
  # Vai permitir criar user e account em uma mesma trx
  alias Ecto.Multi
  alias Rocketpay.{Account, Repo, User}

  def call(params) do
    # inicia Multi operação
    Multi.new()
    |> Multi.insert(:create_user, User.changeset(params))
    # o multi run permite ler o resultado da op anterior
    #  %{nome_da_op_anterior: resultado})
    |> Multi.run(:create_account, fn repo, %{create_user: user} ->
      insert_account(repo, user)
    end)
    |> Multi.run(:preload_data, fn repo, %{create_user: user} -> preload_data(repo, user) end)
    |> run_transaction()
  end

  defp insert_account(repo, user) do
    user.id
    |> account_changeset()
    |> repo.insert()
  end

  defp account_changeset(user_id) do
    %{user_id: user_id, balance: "0.00"}
    |> Account.changeset()
  end

  defp preload_data(repo, user) do
    # para devolver o usuario com a conta carregada
    {:ok, repo.preload(user, :account)}
  end

  defp run_transaction(multi) do
    # outra forma de fazer pattern match: case
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_data: user}} -> {:ok, user}
    end
  end
end
