defmodule InfoSys.Counter do
  @moduledoc """
  A counter using GenServer
  """

  use GenServer

  def inc(pid), do: GenServer.cast(pid, :inc)
  def dec(pid), do: GenServer.cast(pid, :dec)
  def val(pid), do: GenServer.call(pid, :val)

  def start_link(init_val), do: GenServer.start_link(__MODULE__, init_val)

  def init(init_val) do
    Process.send_after(self(), :tick, 1_000)
    {:ok, init_val}
  end

  def handle_info(:tick, val) when val <= 0, do: raise("BOOOOM!")

  def handle_info(:tick, val) do
    IO.puts("tick#{val}")
    Process.send_after(self(), :tick, 1_000)
    {:noreply, val - 1}
  end

  def handle_cast(:inc, val), do: {:noreply, val + 1}
  def handle_cast(:dec, val), do: {:noreply, val - 1}
  def handle_call(:val, _from, val), do: {:reply, val, val}
end
