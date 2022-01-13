defmodule InfoSys.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      InfoSys.Supervisor
    ]

    opts = [strategy: :one_for_one, name: InfoSys.Application]
    Supervisor.start_link(children, opts)
  end
end
