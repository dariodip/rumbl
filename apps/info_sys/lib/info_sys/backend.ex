defmodule InfoSys.Backend do
  @moduledoc """
  A behaviour for abstracting backends
  """

  @callback name() :: String.t()
  @callback compute(query :: String.t(), opts :: Keyword.t()) :: [InfoSys.Result.t()]
end
