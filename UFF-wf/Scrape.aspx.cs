using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using HtmlAgilityPack;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Concurrent;

namespace UFF_wf
{
    public partial class Scrape : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //lblMessage.Visible = false;
            }

            lblStandingsLastUpdated.Text = GetLastUpdateDate_Standings();
        }

        public string GetLastUpdateDate_Standings()
        {
            using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                var sql = "SELECT TOP 1 CreatedDate FROM Standings ORDER BY CreatedDate Desc";

                using (SqlCommand command = new SqlCommand(sql, sqlConnection))
                {
                    DataSet ds = new DataSet();
                    sqlConnection.Open();
                    command.CommandType = CommandType.Text;

                    SqlDataAdapter da = new SqlDataAdapter();
                    da.SelectCommand = command;

                    da.Fill(ds);
                    sqlConnection.Close();

                    return ds.Tables[0].Rows[0]["CreatedDate"].ToString();
                }

            }


        }

        public void btnScrapeStandings_Click(object sender, EventArgs e)
        {

            HtmlWeb web = new HtmlWeb();
            HtmlDocument doc = web.Load("http://games.espn.com/ffl/standings?leagueId=19933&seasonId=2018");

            var smallTable = doc.DocumentNode.SelectNodes("//tr[@class='tableBody']").ToList();
            var bigTable = doc.DocumentNode.SelectNodes("//tr[@class='evenRow bodyCopy sortableRow']").ToList();
            var bigTableOdd = doc.DocumentNode.SelectNodes("//tr[@class='oddRow bodyCopy sortableRow']").ToList();

            foreach (var item in bigTableOdd)
            {
                bigTable.Add(item);
            }

            var htmlStandings = new List<HtmlNodeCollection>();
            var textTeams = new List<string>();
            var textWins = new List<string>();
            var textLosses = new List<string>();
            var textTies = new List<string>();
            var textPercentage = new List<string>();
            var textBigTable = new List<string[]>();

            foreach (var item in smallTable)
            {
                htmlStandings.Add(item.SelectNodes("td//a"));
                textTeams.Add(item.SelectNodes("td//a").First().Attributes["title"].Value.ToString());
                textWins.Add(item.ChildNodes[1].InnerText.ToString());
                textLosses.Add(item.ChildNodes[2].InnerText.ToString());
                textTies.Add(item.ChildNodes[3].InnerText.ToString());
                textPercentage.Add(item.ChildNodes[4].InnerText.ToString());
            }

            int i = 0;
            string division = "East";
            foreach (var item in bigTable)
            {
                i++;
                if (i > 5)
                    division = "West";

                string[] arrayBigTable = new string[6];

                //Team Name
                arrayBigTable[0] = item.ChildNodes[0].InnerText.ToString().Split('(', ')')[0];
                //PF
                arrayBigTable[1] = item.ChildNodes[1].InnerText.ToString();
                //PA
                arrayBigTable[2] = item.ChildNodes[2].InnerText.ToString();
                //Streak
                arrayBigTable[3] = item.ChildNodes[6].InnerText.ToString();
                //Divison
                arrayBigTable[4] = division;
                //Team Owner
                try
                {
                    arrayBigTable[5] = item.ChildNodes[0].InnerText.ToString().Split('(', ')')[1].Split(',')[0];
                }
                catch
                {
                    arrayBigTable[5] = null;
                }

                textBigTable.Add(arrayBigTable);
            }

            ConcurrentStack<string> finalStats = new ConcurrentStack<string>();
            foreach (var item in textBigTable)
            {
                var tbtName = item[0].ToString();
                var tbtIndex = textBigTable.FindIndex(x => x.Contains(tbtName));

                var ttPosition = textTeams.FindIndex(x => x.Contains(item[0].Substring(0, 5))); //
                var ttName = textTeams[ttPosition].ToString();

                if (ttName.Substring(0, 5) == tbtName.Substring(0, 5))
                {

                    var Wins = textWins[ttPosition].ToString();
                    var Losses = textLosses[ttPosition];
                    var Ties = textTies[ttPosition];
                    var Percentage = textPercentage[ttPosition];

                    //TeamName, PF, PA, Streak, Division, Owner, Wins, Losses, Ties, Percentage
                    List<string> statArray = new List<string>() { item[0], item[1], item[2], item[3], item[4], item[5], Wins, Losses, Ties, Percentage };

                    var concatedString = statArray.Aggregate((a, b) => Convert.ToString(a) + "," + Convert.ToString(b));

                    finalStats.Push(concatedString);
                }
            }

            var Standings = finalStats.ToList();

            UpdateDB(Standings);
        }

        public void btnScrapeHistory_Click(object sender, EventArgs e)
        {
            HtmlWeb web = new HtmlWeb();
            HtmlDocument doc = web.Load("http://games.espn.com/ffl/tools/finalstandings?leagueId=19933&seasonId=2016");

            var smallTable = doc.DocumentNode.SelectNodes("//table[@id='finalRankingsTable']").ToList();
            var TeamData = new List<HtmlNode> { smallTable[0].ChildNodes[5], smallTable[0].ChildNodes[7], smallTable[0].ChildNodes[9], smallTable[0].ChildNodes[11], smallTable[0].ChildNodes[13], smallTable[0].ChildNodes[15], smallTable[0].ChildNodes[17], smallTable[0].ChildNodes[19], smallTable[0].ChildNodes[21], smallTable[0].ChildNodes[23] };

            ConcurrentStack<string> finalStats = new ConcurrentStack<string>();
            foreach (var item in TeamData)
            {

            }

        }

        public void UpdateDB(List<string> Standings)
        {

            using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                var sql = "up_ProcessFormattedStandingsBatch";
                sqlConnection.Open();

                Random rnd = new Random();
                int batch = rnd.Next(10000000, 99999999);



                foreach (var item in Standings)
                {
                    var parameters = item.Split(',');


                    SqlCommand sqlCommand = new SqlCommand(sql, sqlConnection);
                    sqlCommand.CommandType = CommandType.StoredProcedure;

                    sqlCommand.Parameters.Add(new SqlParameter("@batchid", batch));
                    sqlCommand.Parameters.Add(new SqlParameter("@teamname", parameters[0].Split('(')[0]));
                    sqlCommand.Parameters.Add(new SqlParameter("@pf", Convert.ToInt32(parameters[1])));
                    sqlCommand.Parameters.Add(new SqlParameter("@pa", Convert.ToInt32(parameters[2])));
                    sqlCommand.Parameters.Add(new SqlParameter("@streak", Convert.ToInt32(parameters[3])));
                    sqlCommand.Parameters.Add(new SqlParameter("@division", parameters[4]));
                    sqlCommand.Parameters.Add(new SqlParameter("@teamowner", parameters[5]));
                    sqlCommand.Parameters.Add(new SqlParameter("@wins", Convert.ToInt32(parameters[6])));
                    sqlCommand.Parameters.Add(new SqlParameter("@losses", Convert.ToInt32(parameters[7])));
                    sqlCommand.Parameters.Add(new SqlParameter("@ties", Convert.ToInt32(parameters[8])));
                    sqlCommand.Parameters.Add(new SqlParameter("@percentage", Convert.ToDouble(parameters[9])));


                    sqlCommand.ExecuteNonQuery();
                    sqlCommand.Dispose();
                }

                sqlConnection.Close();
            }
        }
    }
}
