defmodule InfoSys.Wolfram do
  @moduledoc """
  A backend to fetch data from wolfram
  """

  import SweetXml
  alias InfoSys.Result

  @behaviour InfoSys.Backend

  @base "http://api.wolframalpha.com/v2/query"

  @impl true
  def name, do: "wolfram"

  @impl true
  def compute(query_str, _opts) do
    query_str
    |> fetch_xml()
    |> xpath(~x"//queryresult/pod[text()]/subpod/plaintext/text()")
    |> build_result()
  end

  defp build_results(nil), do: []

  defp build_result(answer) do
    [%Result{backend: __MODULE__, score: 95, text: to_string(answer)}]
  end

  defp fetch_xml(query) do
    {:ok, {_, _, body}} = :httpc.request(String.to_charlist(url(query)))
    body
  end

  defp url(input) do
    "#{@base}?" <> URI.encode_query(appid: id(), input: input, format: "plaintext")
  end

  defp id, do: Application.get_env(:rumbl, :wolfram)[:app_id]
end
