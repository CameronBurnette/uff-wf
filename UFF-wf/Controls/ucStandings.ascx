<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucStandings.ascx.cs" Inherits="UFF_wf.Controls.ucStandings" %>

<style>
    .table-striped th, .table-striped td, .table-striped b {
        text-align: center;
    }
</style>

<div class="row">
    <div class="col-md-12">
        <asp:Repeater ID="rpStandings" runat="server">
            <HeaderTemplate>
                <table class="table table-striped table-bordered .table-text-center sortable">
                    <thead>
                        <tr>
                            <th>Pos.</th>
                            <th>Manager</th>
                            <th>Division</th>
                            <th>Team</th>
                            <th>Wins</th>
                            <th>Losses</th>
                            <th>Ties</th>
                            <th>Points Scored</th>
                            <th>Points Allowed</th>
                        </tr>
                    </thead>
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <%# DataBinder.Eval(Container.DataItem, "tempRanking") %> 
                    </td>
                    <td>
                        <%# DataBinder.Eval(Container.DataItem, "TeamOwner") %> 
                    </td>
                    <td>
                        <%# DataBinder.Eval(Container.DataItem, "Division") %> 
                    </td>
                    <td>
                        <%# DataBinder.Eval(Container.DataItem, "TeamName") %> 
                    </td>
                    <td>
                        <%# DataBinder.Eval(Container.DataItem, "Wins") %> 
                    </td>
                    <td>
                        <%# DataBinder.Eval(Container.DataItem, "Losses") %> 
                    </td>
                    <td>
                        <%# DataBinder.Eval(Container.DataItem, "Ties") %> 
                    </td>
                    <td>
                        <%# DataBinder.Eval(Container.DataItem, "PointsAllowed") %> 
                    </td>
                    <td>
                        <%# DataBinder.Eval(Container.DataItem, "PointsFor") %> 
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </tbody>
            </table> 
            </FooterTemplate>
        </asp:Repeater>
    </div>
