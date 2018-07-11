using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using IronWebScraper;

namespace UFF_wf._code
{
    class ESPNScraper
    {
        public static void Scrape()
        {
            var scraper = new Scraper();
            scraper.Start();
        }
    }

    class Scraper : WebScraper
    {
        //public static void Main(string[] args)
        //{
        //    var scraper = new Scraper();
        //    scraper.Start();
        //}

        public override void Init()
        {
            this.LoggingLevel = WebScraper.LogLevel.All;
            this.Request("http://games.espn.com/ffl/leagueoffice?leagueId=19933&seasonId=2018", Parse);
        }

        public override void Parse(Response response)
        {
            foreach (var title_link in response.Css("h2.entry-title a"))
            {
                string strTitle = title_link.TextContentClean;
                Scrape(new ScrapedData() { { "Title", strTitle } });
            }

            if (response.CssExists("div.prev-post > a[href]"))
            {
                var next_page = response.Css("div.prev-post > a[href]")[0].Attributes["href"];
                this.Request(next_page, Parse);
            }
        }
    }
}