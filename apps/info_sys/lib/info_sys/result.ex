defmodule InfoSys.Result do
  @moduledoc """
  Result is a struct to handle results from the backends
  """

  @type t :: %InfoSys.Result{}
  defstruct score: 0, text: nil, url: nil, backend: nil
end
