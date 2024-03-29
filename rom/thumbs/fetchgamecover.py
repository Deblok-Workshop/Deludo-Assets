import asyncio
import aiohttp
from bs4 import BeautifulSoup
import urllib.parse
from os import mkdir
from shutil import rmtree

async def download_file(url, destination):
    async with aiohttp.ClientSession() as session:
        async with session.get(url) as response:
            if response.status == 200:
                with open(destination, 'wb') as f:
                    while True:
                        chunk = await response.content.read(1024)
                        if not chunk:
                            break
                        f.write(chunk)
                return 0;
            else:
                return response.status

async def fetch_cover(session, query):
    try:
          mkdir("tmpcovers")
    except:
          rmtree("tmpcovers")
          mkdir("tmpcovers")
    query_words = query.split()[:3]  # Take first 3 words of the query
    query_url = "+".join(query_words)
    base_url = f"https://openretro.org/browse?q={query_url}&disabled=1&unpublished=0"
    i = 0
    async with session.get(base_url) as response:
       html = await response.text()
       soup = BeautifulSoup(html, 'html.parser')
       game_boxes = soup.select('.game_box')

       for game_box in game_boxes:
        text = next(game_box.stripped_strings, '').strip()
        if query.lower() == text.lower():
         img_src = game_box.find('a').find("img")['src']
         cover_link = "https://openretro.org" + img_src.split('?')[0] + "?w=256&h=256&f=jpg&t=lbcover"
         print("Found cover:\n", cover_link)
         print(f"Downloading found cover {i}...")

         await download_file(cover_link,f"tmpcovers/cover-{i}.jpg")
         i = i+1
         # return

async def main():
    async with aiohttp.ClientSession() as session:
        query = input("Enter game name: ")
        await fetch_cover(session, query)

if __name__ == "__main__":
    asyncio.run(main())

