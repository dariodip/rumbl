defmodule InfoSysTest do
  use ExUnit.Case
  doctest InfoSys
  alias InfoSys.Result

  defmodule TestBackend do
    def start_link(query, ref, owner, limit) do
      Task.start_link(__MODULE__, :fetch, [query, ref, owner, limit])
    end

    def name(), do: "Wolfram"

    def compute("results", _opts) do
      [%Result{backend: __MODULE__, text: "result"}]
    end

    def compute("none", _opts), do: []

    def compute("timeout", _opts) do
      :timer.sleep(:infinity)
    end

    def compute("boom", _opts) do
      raise "boom!"
    end
  end

  test "compute/2 with backend results" do
    assert [%Result{backend: TestBackend, text: "result"}] ==
             InfoSys.compute("results", backends: [TestBackend])
  end

  test "compute/2 with no backend results" do
    assert [] = InfoSys.compute("none", backends: [TestBackend])
  end

  test "compute/2 with timeout returns no results" do
    results = InfoSys.compute("timeout", backends: [TestBackend], timeout: 10)
    assert results == []
  end

  @tag :capture_log
  test "compute/2 discards backend errors" do
    assert InfoSys.compute("boom", backends: [TestBackend]) == []
  end
end
