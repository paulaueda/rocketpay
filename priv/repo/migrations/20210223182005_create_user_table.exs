defmodule Rocketpay.Repo.Migrations.CreateUserTable do
  use Ecto.Migration

  def change do
    create table :users do
      # ecto ja sabe que tem id e por default ele é integer
      add :name, :string
      add :age, :integer
      add :email, :string
      add :password_hash, :string
      add :nickname, :string

      # o comando a seguir adiciona automaticamente inserted_at e updated_at
      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:nickname])

    # def up, def down
  end
end
