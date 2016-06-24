defmodule ExgingerapiTest do
  use ExUnit.Case
  doctest Exgingerapi

  test "checking grammar or normal text" do
    result = Exgingerapi.check_grammar("Some text here")
    assert result == []
  end

  test "checking grammar on bad text" do
    result = Exgingerapi.check_grammar("Soem text goes her")
    assert result == [%{"Replace" => "soem", "With" => "some"}, %{"Replace" => "her", "With" => "here"}]
  end

  test "checking text that is too long" do

    # Intentionally mispell regular
    string = "Early in 1801, even before his inauguration as third president of the United States, Thomas Jefferson had invited Captain Lewis, twenty-seven and thus roughly the age of Colter and Drouillard, to join his household as private secretary. Seven years of military service had equipped Lewis with knowledge in two realms with which the president had to deal. One was the frontier West, already drawing Americans across the Appalachian Mountains and down the great valleys descending to the Mississippi River; Jefferson himself had never traveled far beyond Virginia's Blue Ridge. The other was knowledge of the reglar army, an institution for which Jefferson, steeped in the militia tradition, had little sympathy."

    result = Exgingerapi.check_grammar(string)
    assert result == [%{"Replace" => "early", "With" => "early"}, %{"Replace" => "thomas", "With" => "thomas'"},
                      %{"Replace" => "jefferson", "With" => "jefferson"}, %{"Replace" => "lewis", "With" => "lewis"},
                      %{"Replace" => "drouillard", "With" => "drouillard"}, %{"Replace" => "of", "With" => "of"},
                      %{"Replace" => "lewis", "With" => "lawyers"}, %{"Replace" => "americans", "With" => "americans"},
                      %{"Replace" => "appalachian", "With" => "appalachian"}, %{"Replace" => "mississippi", "With" => "mississippi"}]
  end

  test "checking text that is too long and not a sentence" do

    # Not sentences
    string = "This is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and it never ends."

    result = Exgingerapi.check_grammar(string)
    assert result == [%{"Replace" => "this", "With" => "this"}, %{"Replace" => "runon", "With" => "run on"},
                      %{"Replace" => "runon", "With" => "run on"}, %{"Replace" => "runon", "With" => "run on"},
                      %{"Replace" => "runon", "With" => "run on"}, %{"Replace" => "runon", "With" => "run on"},
                      %{"Replace" => "runon", "With" => "run on"}, %{"Replace" => "sentence", "With" => "sentence"},
                      %{"Replace" => "runon", "With" => "run on"}, %{"Replace" => "runon", "With" => "run on"},
                      %{"Replace" => "runon", "With" => "run on"}, %{"Replace" => "runon", "With" => "run on"},
                      %{"Replace" => "runon", "With" => "run on"}, %{"Replace" => "long", "With" => "long"},
                      %{"Replace" => "runon", "With" => "run on"}, %{"Replace" => "runon", "With" => "run on"},
                      %{"Replace" => "runon", "With" => "run on"}, %{"Replace" => "runon", "With" => "run on"},
                      %{"Replace" => "runon", "With" => "run on"}, %{"Replace" => "runon", "With" => "run on"}]
  end

  test "checking text with no suggestions returned" do
    result = Exgingerapi.check_grammar("mecedes")
    assert result == [%{"Replace" => "mecedes", "With" => "mecedes"}]
  end

end
