<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucStandings.ascx.cs" Inherits="UFF_wf.Controls.ucStandings" %>

<style>
    #standings th, #standings td, #standings b {
        text-align: center;
        vertical-align: middle;
    }
</style>


<div class="row">
    <div class="col-xs-2"></div>
    <div class="col-xs-8">
        <h3 class="text-center">Current Season Standings</h3>
    </div>
    <div class="col-xs-2"></div>
</div>
<div class="row">
    <div class="col-sm-1"></div>
    <div class="col-sm-10" style="text-align: center; overflow-x: auto; overflow-y:auto">        
        <asp:Repeater ID="rpStandings" runat="server">
            <HeaderTemplate>
                <table id="standings" class="table table-striped table-bordered sortable table-condensed" style="overflow-x: scroll; overflow-y: scroll;">
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
    <div class="col-sm-1"></div>
</div>
