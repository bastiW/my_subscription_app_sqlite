defmodule MySubscriptionAppSqliteWeb.GraphqlSocket do
  use Phoenix.Socket

  use Absinthe.Phoenix.Socket,
    schema: MySubscriptionAppSqliteWeb.GraphqlSchema

  @impl true
  def connect(params, socket, connect_info) do
    path = case connect_info[:uri] do
      %URI{path: p} -> p
      _ -> "unknown"
    end
    
    IO.puts("GraphqlSocket params #{inspect(params)}")
    IO.puts("GraphqlSocket socket #{inspect(socket)}")
    IO.puts("GraphqlSocket connected path: #{path}")

    {:ok, socket}
  end

  @impl true
  def id(_socket), do: nil
end
