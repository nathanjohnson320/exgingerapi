defmodule Exgingerapi do

  @base_url "http://services.gingersoftware.com/Ginger/correct/json/GingerTheText?lang=US&clientVersion=2.0&apiKey=6ae0c3a0-afdc-4532-a810-82ded0054236&text="
  @words_per_request 40

  # Check the grammar of given text
  def check_grammar(text) do

    # Can't do String.length in guards so we check here
    cond do
      String.length(text) < 600 ->

      # Send the request
      {:ok, %HTTPoison.Response{body: body, headers: _, status_code: _}} = HTTPoison.get(@base_url <> URI.encode(text), [], [recv_timeout: :infinity])

        # Decode the json response
        case Poison.decode(body) do
          # No issues
          {:ok, %{"LightGingerTheTextResult" => []}} -> []

          # There were issues loop over them
          {:ok, %{"LightGingerTheTextResult" => issues }} ->

              # Loop over the suggestions and format a response
              result = Enum.map issues, fn(issue) ->
                from = issue["From"]
                to = issue["To"]

                top_suggestion = Enum.find issue["Suggestions"], fn(suggestion) ->
                  suggestion["LrnCatId"] == issue["TopLrnCatId"]
                end

                # Replace _ with _
                %{"Replace" => String.slice(text, Range.new(from, to)), "With" => top_suggestion["Text"]}
              end
              result |> Enum.filter(fn(issue) ->
                if not is_nil(issue["Replace"]) and not is_nil(issue["With"]) do
                  String.downcase(issue["Replace"]) != String.downcase(issue["With"])
                else
                  false
                end
              end)
          _ ->
              {:error, "Could not match"}
        end
      String.length(text) >= 600 ->
        # Split the string into sentences
				text = text |> String.replace(~r/[^A-Za-z0-9 ]/, " ")
				|> String.downcase
				|> String.split
				|> Enum.chunk(@words_per_request)

        # Run each sentence through the grammar check
        Enum.map(text, fn(sentence) -> Task.async(fn -> Enum.join(sentence, " ") |> check_grammar end) end)
        |> Enum.map(&Task.await(&1, 30000))
        |> List.flatten()
    end
  end
end
