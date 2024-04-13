import json
import requests
with open("playables.txt", "r") as file:
    playables = file.read()

playables = json.loads(playables)
scraped = {}
for i in range(len(playables)):
    print("info: scraping", playables[i][0])
    url = playables[i][1]
    response = requests.get(url)
    if response.status_code == 200:
        content = response.text
        last_occurrence = content.rfind("privateDoNotAccessOrElseTrustedResourceUrlWrappedValue")
        next_colon = content.find(":", last_occurrence)
        next_quote = content.find('"', next_colon)
        end_quote = content.find('"', next_quote + 1)
        url_value = content[next_quote + 1:end_quote]
        if ("gamesnacks.com" in url_value):
            print("warn: this is a gamesnacks game. direct urls break in all sorts of ways.")
        elif ("usercontent.goog" not in url_value):
            print("info: this is not a usercontent.goog domain, the game might be double iframed.")
            print("info: i'm stopping here, this might be a gamesnacks game.")
        
        scraped[playables[i][0].replace(" ","-").replace("'","").lower()] = url_value
        
    else:
        print("error: Non-200 status code recieved: ", response.status_code)
        print("info: skipping.")
print(str(scraped).replace("'",'"'))