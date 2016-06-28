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
    assert result == [%{"Replace" => "which", "With" => "witch"}, %{"Replace" => "reglar", "With" => "regular"}]
  end

  test "checking text that is too long and not a sentence" do

    # Not sentences
    string = "This is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and this is a long runon sentence and it never ends."

    result = Exgingerapi.check_grammar(string)
    assert result == [%{"Replace" => "runon", "With" => "reunion"}, %{"Replace" => "runon", "With" => "reunion"}, %{"Replace" => "runon", "With" => "reunion"},
                      %{"Replace" => "runon", "With" => "reunion"}, %{"Replace" => "runon", "With" => "reunion"}, %{"Replace" => "runon", "With" => "reunion"},
                      %{"Replace" => "runon", "With" => "reunion"}, %{"Replace" => "runon", "With" => "reunion"}, %{"Replace" => "runon", "With" => "reunion"},
                      %{"Replace" => "runon", "With" => "reunion"}, %{"Replace" => "runon", "With" => "reunion"}, %{"Replace" => "runon", "With" => "reunion"},
                      %{"Replace" => "runon", "With" => "reunion"}, %{"Replace" => "runon", "With" => "reunion"}, %{"Replace" => "runon", "With" => "reunion"},
                      %{"Replace" => "runon", "With" => "reunion"}, %{"Replace" => "runon", "With" => "reunion"}, %{"Replace" => "runon", "With" => "reunion"},
                      %{"Replace" => "runon", "With" => "reunion"}, %{"Replace" => "runon", "With" => "reunion"}, %{"Replace" => "runon", "With" => "reunion"}]
  end

  test "checking text with no suggestions returned" do
    result = Exgingerapi.check_grammar("mecedes")
    assert result == [%{"Replace" => "mecedes", "With" => "mecedes"}]
  end

  test "checking bad text" do
    text = "LOG INSIGN UP\nSUBSCRIBER SERVICES\nE-EDITION\nEMAIL NEWSLETTERS\nCONTACT US\nCLASSIFIEDS\nFIND LOCAL\nCARS\nHOMES\nJOBS\nADVERTISE\nIntroducing the redesigned 2016 Mecedes-Benz GLC- Class - Richmond Times-Dispatch: Richmond Drives: Vehicle Features\nRichmond\n79°\nNEWS\nVIRGINIA POLITICS BUSINESS\nENTERTAINMENT\nFOOD & DRINK\nSPORTS\nVIDEO\nOPINION\nWEATHER JOBS REAL ESTATE\nALL SECTIONS\n\nSELL YOUR CAR | LOCAL AUTO DEALERS | VIDEO\n\nLUXURY MINI SUV\nIntroducing the redesigned 2016 Mecedes-Benz GLC- Class\nWhat’s in a name? It used to be called the GLK-Class— now this wagon has become the larger, but lighter, GLC-Class.\nStory\nComments\nImage (3)\nPrint\nCreate a hardcopy of this page\nFont Size:\nDefault font size\nLarger font size\nMBUSA, PHOTO PROVIDED BY WHEELBASE MEDIA\nThe 2016 Mercedes-Benz GLC-Class offers Mercedes-Benz’s signature styling and well-crafted interior.\nPrevious Next\nPHOTOS PROVIDED BY MBUSA.COM\nThe luxurious interior of the 2016 Mercedes-Benz GLC- Class\nView all 3 images in gallery.\n2016 Mercedes Benz GLC- Class\nBase price (incl. destination): $40,000\nType: Four-door, rear-/all-wheel-drive compact sport-utility vehicle\nBase engine (hp): 2.0-liter DOHC I4, turbocharged (241)\nLayout: Front-engine, rear- /all-wheel-drive\nTransmission: Nine-speed automatic\nMPG (city/highway): 24/34 (est.)\nWeight (lb.): 3,890\n........................ ADVERTISEMENT ......................\nPosted: Friday, June 24, 2016 3:00 am\nContent by Wheelbase Communications\nMercedes-Benz’s model realignment continues apace with the newly branded GLC, a vehicle that was previously called the GLK. The result is better proportioned than its blocky predecessor and offers a much-improved environment for passengers. Although still a smallish mid-size wagon, the GLC300 is a full 4 inches longer between the axles than the GLK and 5 inches longer overall. Moreover, the GLC is nearly 200 pounds lighter, but some of that decrease is likely due to a smaller base engine.\nFor the vehicle’s debut, Mercedes-Benz toned down the GLC’s performance, deleted the turbo-diesel option and, instead, went for a turbocharged 2.0-liter four-cylinder that produces 241 horsepower and 273 pound-feet of torque. It’s a far cry from the previous 302-horsepower 3.5-liter V6 that used to be the standard gasoline powerplant. The engine is sourced from the current C-Class sedan, but it doesn’t share that model’s seven-speed automatic transmission. Instead, an all-new nine-speed automatic picks the gears for you. As before, rear-wheel-drive is standard, and Mercedes’ 4Matic all-wheel-drive is an option click (and an extra $2,000) away and well worth it for more secure all-weather driving.\nAmong the GLC’s unique options is an air-ride suspension (in place of steel springs). Another extra-cost upgrade is an active damping system that continually — as in milliseconds — adjusts the shocks’ firmness while negotiating turns or when traveling over rough or uneven roads.\nPosted in Richmond Drives: Vehicle Features on Friday, June 24, 2016 3:00 am.\nSimilar Stories\nMost Read\nSupreme Court vacates Bob McDonnell's convictions; says concern not with 'tawdry tales' but with 'boundless interpretation' of bribery law\nDaniel Radcliffe said he had the 'perfect meal' in Richmond\nFive mayoral candidates fail to meet ballot requirements; Tichi Pinkney Eppes disqualified for School Board\nJoe Morrissey & Myrna Warren\nAt age 90, this doc has a message for his successors\n........................ ADVERTISEMENT ......................\nSEARCH AUTOS\nCondition\nAll\nNew\nUsed\nCertified Pre-Owned\nMake\nAll Makes\nAcura\nAudi\nBentley\nBMW\nBuick\nCadillac\nChevrolet\nChrysler\nDodge\nFord\nGMC\nHonda\nHUMMER\nHyundai\nInfiniti\nJaguar\nJeep\nKia\nLand Rover\nLexus\nLincoln\nMazda\nMercedes-Benz\nMercury\nMINI\nMitsubishi\nNissan\nPontiac\nPorsche\nRAM\nSaturn\nScion\nsmart\nSubaru\nToyota\nVolkswagen\nVolvo\nModel\nAll Models\nYear\nto\nPrice\nto\nDealerships\nAll Dealerships\nBrown's Jaguar\nBrown's Volkswagen\nGary Higginbotham Auto Sales\nHaley Chevrolet\nLuck Chevrolet\nMercedes Benz Of Richmond\nMercedes-Benz Of Midlothian\nNew Millennium Auto Sales\nPatrick Buick Gmc\nPearson Honda\nPearson Hyundai\nPearson Mazda\nPearson Preowned\nWest Broad Volkswagen/Audi\nVIDEO REVIEWS\n01:32 / 01:32\n2016 Daily News Autos Awards: Luxury SUV\nNY Daily News\nMore videos:\nFIND AN AUTO DEALER\nChoose Dealer\nAcura\nAudi\nBMW\nBuick\nCadillac\nChevrolet\nChrysler / Plymouth\nDodge\nFord\nGeo\nGMC\nHonda\nHummer\nHyundai\nInfiniti\nJaguar\nJeep\nKia\nLand Rover\nLexus\nMercedes Benz\nMitsubishi\nNissan\nOldsmobile\nPontiac\nPorsche\nRolls Royce\nSaturn\nScion\nSubaru\nToyota\nVolkswagen\nVolvo\nWithin\n5 mi.\n10 mi.\n25 mi.\n50 mi.\n100 mi.\n200 mi.\nGet maps, car listings, price quotes and more.\n........................ ADVERTISEMENT ......................\nSECTIONS\nHome\nNews\nBusiness\nEntertainment\nEvents Calendar\nFood & Drink\nSports\nOutdoors\nViewpoints/Opinion\nAll Sections\nCLASSIFIEDS\nToday's Print Ads\nClassifieds\nAutomotive\nReal Estate\nEmployment\nFind Local\nSERVICES\nAdvertise With Us\nContact Us\nBusiness Directory\nBuy Photos\nEmail Newsletters\nSubscription Services\nShop Our Products\nPopMounts & Reprints\nWant to use our content?\nWork With Us\nALL ACCESS\nSign Up\nManage Subscription\nE-Edition\nChange Password\nReport an Issue\nCONTACT US\nPhone number: 804-649-6000\nAddress: 300 E. Franklin St.\nRichmond, VA 23219\nSOCIAL\nSEARCH\nSearch in:\nAll\nBusiness\nClassifieds\nEntertainment\nEvents Calendar\nFood+Drink\nLife\nNews\nOutdoors\nSports\nTravel\nViewpoints/Opinion\nRichmond Times-Dispatch, Richmond, VA © 2016 BH Media Group, Inc. Powered by BLOX Content Management System from TownNews.com. [Terms of Use]"

    result = Exgingerapi.check_grammar(text)
    assert result == [%{"Replace" => "insign", "With" => "ensign"}, %{"Replace" => "mecedes", "With" => ""}, %{"Replace" => "glc", "With" => ""}, %{"Replace" => "suv", "With" => "suv"},
                      %{"Replace" => "mecedes", "With" => ""}, %{"Replace" => "glc", "With" => ""}, %{"Replace" => "glk", "With" => ""}, %{"Replace" => "glc", "With" => ""},
                      %{"Replace" => "mbusa", "With" => ""}, %{"Replace" => "glc", "With" => ""}, %{"Replace" => "mbusa", "With" => ""}, %{"Replace" => "com", "With" => ""},
                      %{"Replace" => "glc", "With" => ""}, %{"Replace" => "glc", "With" => ""}, %{"Replace" => "incl", "With" => "incl."}, %{"Replace" => "hp", "With" => "hp"},
                      %{"Replace" => "dohc", "With" => "doc"}, %{"Replace" => "turbocharged", "With" => ""}, %{"Replace" => "est", "With" => "est"}, %{"Replace" => "lb", "With" => ""},
                      %{"Replace" => "glc", "With" => ""}, %{"Replace" => "glk", "With" => ""}, %{"Replace" => "glk", "With" => ""}, %{"Replace" => "glc", "With" => ""},
                      %{"Replace" => "glc", "With" => ""}, %{"Replace" => "turbocharged", "With" => ""}, %{"Replace" => "powerplant", "With" => ""},
                      %{"Replace" => "doesn", "With" => "design"}, %{"Replace" => "glc", "With" => ""}, %{"Replace" => "mcdonnell", "With" => "mcdonnell"},
                      %{"Replace" => "meet", "With" => "mt"}, %{"Replace" => "tichi", "With" => "techie"}, %{"Replace" => "gmc", "With" => ""}, %{"Replace" => "gmc", "With" => ""},
                      %{"Replace" => "preowned", "With" => ""}, %{"Replace" => "suv", "With" => "suv"}, %{"Replace" => "ny", "With" => "ny"}, %{"Replace" => "gmc", "With" => ""},
                      %{"Replace" => "mi", "With" => ""}, %{"Replace" => "mi", "With" => ""}, %{"Replace" => "mi", "With" => ""}, %{"Replace" => "mi", "With" => ""},
                      %{"Replace" => "mi", "With" => ""}, %{"Replace" => "mi", "With" => ""}, %{"Replace" => "our", "With" => "ore"}, %{"Replace" => "popmounts", "With" => ""},
                      %{"Replace" => "our", "With" => "ore"}, %{"Replace" => "va", "With" => "va"}, %{"Replace" => "va", "With" => "va"}]
  end

end
