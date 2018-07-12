using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UFF_wf.Controls
{
    public partial class ucStandings : UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            rpStandings.DataSource = Standings().Tables[0];
            rpStandings.DataBind();
        }

        public DataSet Standings()
        {
            using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                var sql = "up_GetStandings";

                using (SqlCommand command = new SqlCommand(sql, sqlConnection))
                {
                    DataSet ds = new DataSet();
                    sqlConnection.Open();
                    command.CommandType = CommandType.StoredProcedure;

                    SqlDataAdapter da = new SqlDataAdapter();
                    da.SelectCommand = command;

                    da.Fill(ds);
                    sqlConnection.Close();

                    return ds;
                }

            }
        }
    }
}