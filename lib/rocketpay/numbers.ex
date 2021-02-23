defmodule Rocketpay.Numbers do
  def sum_from_file(filename) do
    # Abrindo arquivo
    # pattern matching
    # file = File.read("#{filename}.csv")
    # handle_file(file)

    # pipe operator pega o retorno da operação anterior e passa como o primeiro
    # parametro da função
    "#{filename}.csv"
    |> File.read()
    |> handle_file()

  end
  # funcao privada
  # elixir => linguagem funcional -> imutabilidade
  # imutabilidade: dados nao mudam na memoria (seguranca com threads)
  defp handle_file({:ok, result}) do
    result =
      result
      |> String.split(",")
      # função anonima
      # |> Enum.map(fn number -> String.to_integer(number) end)
      # |> Enum.sum()

      # Operador stream só executa qdo precisamos do resultado (lazy)
      # Compilador agrupa operações: vai converter para inteiro e somar junto
      |> Stream.map(fn number -> String.to_integer(number) end)
      |> Enum.sum()

    # ultima linha é o que retorno
    {:ok, %{result: result}}

  end
  defp handle_file({:error, _reason}), do: {:error, %{message: "Invalid file!"}}
end
