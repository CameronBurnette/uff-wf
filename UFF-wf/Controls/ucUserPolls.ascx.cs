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
    public partial class ucUserPolls : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            rpPolls.DataSource = GetActivePoll().Tables[1];
            rpPolls.DataBind();
        }

        public DataSet GetActivePoll()
        {
            using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                var sql = "GetActivePoll";

                DataSet dt = new DataSet();
                SqlDataAdapter adapter = new SqlDataAdapter();
                adapter.SelectCommand = new SqlCommand(sql, sqlConnection);
                adapter.SelectCommand.CommandType = CommandType.StoredProcedure;

                sqlConnection.Open();
                adapter.Fill(dt);
                sqlConnection.Close();

                return dt;
            }
        }

        public DataSet GetPollOptions(int pollid)
        {
            using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                var sql = "up_GetPollOptions";

                DataSet dt = new DataSet();
                SqlDataAdapter adapter = new SqlDataAdapter();
                adapter.SelectCommand = new SqlCommand(sql, sqlConnection);
                adapter.SelectCommand.CommandType = CommandType.StoredProcedure;
                adapter.SelectCommand.Parameters.Add(new SqlParameter("@pollid", pollid));

                sqlConnection.Open();
                adapter.Fill(dt);
                sqlConnection.Close();

                return dt;
            }
        }

        protected void rpPolls_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                HiddenField hdnpollid = e.Item.FindControl("hdnpollid") as HiddenField;               
                var pollid = Convert.ToInt32(hdnpollid.Value);                               

                Repeater rp = e.Item.FindControl("rpOptions") as Repeater;
                //RadioButtonList rbl = e.Item.FindControl("rblOptions") as RadioButtonList;

                rp.DataSource = GetPollOptions(pollid).Tables[0];
                rp.DataBind();
            }
        }

        protected void rpOptions_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var checkbox = e.Item.FindControl("cbVote") as CheckBox;

                if (checkbox.Checked == true)
                {

                }
            }
        }
    }
}