<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Scrape.aspx.cs" Inherits="UFF_wf.Scrape" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container" style="padding-top: 100px;">
        <div class="row">
            <asp:Label runat="server" ID="lblMessage"></asp:Label>
        </div>
        <div class="row">
            <div class="col-md-8">
                <asp:Repeater ID="rpStandings" runat="server">
                    <HeaderTemplate>
                        <table class="table table-striped table-bordered">
                            <tr>
                                <td><b>Pos.</b></td>
                                <td><b>Manager</b></td>
                                <td><b>Division</b></td>
                                <td><b>Team</b></td>
                                <td><b>Wins</b></td>
                                <td><b>Losses</b></td>
                                <td><b>Ties</b></td>
                                <td><b>Points Scored</b></td>
                                <td><b>Points Allowed</b></td>
                            </tr>
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
                        </table> 
                    </FooterTemplate>
                </asp:Repeater>
            </div>
            <div class="col-md-4">
                <asp:Button runat="server" ID="btnScrapeStandings" OnClick="btnScrapeStandings_Click" Text="Update Standings" CssClass="btn btn-primary" />
            </div>
        </div>
    </div>
</asp:Content>
