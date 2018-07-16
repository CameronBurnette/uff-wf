using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UFF_wf.Models;
using Microsoft.AspNet.Identity;
using System.Data.SqlClient;
using System.Configuration;

namespace UFF_wf.Controls
{
    public partial class ucManagePolls : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            { 
                rpPollQuestions.DataSource = GetActivePoll().Tables[0];
                rpPollQuestions.DataBind();
            }
        }

        public int? pollID
        {
            get
            {
                if (HttpContext.Current.Session["pollID"] == null)
                {
                    HttpContext.Current.Session["pollID"] = new int();
                }
                return Convert.ToInt32(HttpContext.Current.Session["pollID"]);
            }
            set
            {
                HttpContext.Current.Session["pollID"] = value;
            }

        }

        public void BindQuestionsDropDown()
        {

        }

        public void BindPollQuestionsTable()
        {

            //rpPollQuestions.DataSource 
            //rpPollQuestions.DataBind();

        }


        public void btnCreatePoll_Click(object sender, EventArgs e)
        {
            var title = txtPollTitle.Text;
            var options = txtPollOptions.Text.Split('~').ToList();

            UpdatePoll(title);
            UpdateOptions(options);

            rpPollQuestions.DataSource = GetActivePoll().Tables[0];
            rpPollQuestions.DataBind();
        }

        public void UpdatePoll(string title)
        {
            using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                var sql = "NewPoll";


                SqlCommand sqlCommand = new SqlCommand(sql, sqlConnection);
                sqlCommand.CommandType = CommandType.StoredProcedure;
                sqlCommand.Parameters.Add(new SqlParameter("@v_Question", title));

                sqlConnection.Open();
                sqlCommand.ExecuteNonQuery();
                sqlConnection.Close();

                sqlCommand.Dispose();
            }
        }

        public void UpdateOptions(List<string> options)
        {
            using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                var sql = "SetPollOption";

                foreach (var item in options)
                {
                    SqlCommand sqlCommand = new SqlCommand(sql, sqlConnection);
                    sqlCommand.CommandType = CommandType.StoredProcedure;

                    sqlCommand.Parameters.Clear();
                    sqlCommand.Parameters.Add(new SqlParameter("@v_option", item));

                    sqlConnection.Open();
                    sqlCommand.ExecuteNonQuery();
                    sqlConnection.Close();

                    sqlCommand.Dispose();
                }
            }
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

        public DataSet GetVotes(int pollid)
        {
            using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {

                var sql = "up_GetVotes";

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

        public void UpdateActiveStatus(object sender, EventArgs e)
        {
            CheckBox chbActive = (CheckBox)sender;

            int pollid = Convert.ToInt32(chbActive.CssClass.ToString());

            using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                    var sql = "up_TogglePollActive";

                    SqlCommand sqlCommand = new SqlCommand(sql, sqlConnection);
                    sqlCommand.CommandType = CommandType.StoredProcedure;

                    sqlCommand.Parameters.Add(new SqlParameter("@pollid", pollid));

                    sqlConnection.Open();
                    sqlCommand.ExecuteNonQuery();
                    sqlConnection.Close();

                    sqlCommand.Dispose();
            }

                rpPollQuestions.DataSource = GetActivePoll().Tables[0];
                rpPollQuestions.DataBind();
        }

        public void DeletePoll(object sender, CommandEventArgs e)
        {
            int pollid = Convert.ToInt32(e.CommandArgument);

            using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                var sql = "DeletePoll";

                SqlCommand sqlCommand = new SqlCommand(sql, sqlConnection);
                sqlCommand.CommandType = CommandType.StoredProcedure;

                sqlCommand.Parameters.Add(new SqlParameter("@pollid", pollid));

                sqlConnection.Open();
                sqlCommand.ExecuteNonQuery();
                sqlConnection.Close();

                sqlCommand.Dispose();
            }

            rpPollQuestions.DataSource = GetActivePoll().Tables[0];
            rpPollQuestions.DataBind();
        }

        public void rpPollQuestions_OnItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                CheckBox chk = e.Item.FindControl("chkActive") as CheckBox;
                int pollid = Convert.ToInt32(chk.CssClass);

                Repeater rpVotes = e.Item.FindControl("rpVotes") as Repeater;

                rpVotes.DataSource = GetVotes(pollid).Tables[0];
                rpVotes.DataBind();
            }
        }

        public void rpUserVotes_OnItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                HiddenField hdnOption = e.Item.FindControl("hdnOptionID") as HiddenField;
                int optionID = Convert.ToInt32(hdnOption.Value);

                HiddenField hdnPoll = e.Item.FindControl("hdnPollID") as HiddenField;
                int pollid = Convert.ToInt32(hdnPoll.Value);



                Repeater rpUserVotes = e.Item.FindControl("rpUserVotes") as Repeater;

                var dt = GetVotes(pollid).Tables[1].Select("OptionID = " + optionID);

                rpUserVotes.DataSource = dt;
                rpUserVotes.DataBind();
            }
        }
    }
}