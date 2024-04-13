// run in js console at https://www.youtube.com/playables
let playableContents = ytInitialData.contents.twoColumnBrowseResultsRenderer.tabs[1].tabRenderer.content.richGridRenderer.contents
function getPlayableData(idx) {
let realContent = playableContents[idx].richItemRenderer.content.miniGameCardViewModel
    return realContent;
}

function getPlayableTarget(content) {
    return "https://youtube.com/playables/"+atob(content.onTap.innertubeCommand.browseEndpoint.params.slice(0,-3)).slice(5)
}

// scrape the games so they can be further scraped
let scrapableData = []
for (let i = 0; i < playableContents.length; i++) {
    let dat = []
    let playableData = getPlayableData(i);
    dat.push(playableData.title,getPlayableTarget(playableData))
    scrapableData.push(dat)
}
console.log(JSON.stringify(scrapableData))
