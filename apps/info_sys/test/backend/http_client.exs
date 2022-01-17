defmodule InfoSys.Test.HTTPClient do
  @wolfram_xml File.read!("test/fixtures/wolfram.xml")

  def request(url) do
    url = to_string(url)

    if String.contains?(url, "1%2B1") do
      {:ok, {[], [], @wolfram_xml}}
    else
      {:ok, {[], [], "<queryresult></queryresult>"}}
    end
  end
end
