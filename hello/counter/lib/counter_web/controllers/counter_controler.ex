defmodule CounterWeb.CounterController do
  use CounterWeb, :controller

  def index(conn, _params) do
    count = Counter.Count.get()
    render(conn, "index.html", count: count)
  end

  def update(conn, _params) do
    increment =
      case Integer.parse(conn.params["increment"]) do
        {integer, _remainder_of_binary} ->
          integer

        _ ->
          1
      end

    Counter.Count.increment(increment)

    redirect(conn, to: Routes.counter_path(conn, :update, increment: increment))
  end
end
