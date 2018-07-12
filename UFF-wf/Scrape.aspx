<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Scrape.aspx.cs" Inherits="UFF_wf.Scrape" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
      .table th, .table td {
        text-align: center;
    }
    </style>

    <div class="container" style="padding-top: 100px;">
        <div class="row">
            <div class="col-md-6 col-md-offset-3" style="text-align: center;">
                <h3>Scraping Tools</h3>
                <p>Use the buttons below to scrape the current statistics from the leagues ESPN web pages. Doing so will update the elements on the website with the most up-to-date standings, matchups, etc..</p>
            </div>
        </div>
        <div class="row justify-content-md-center">
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <table class="table table-bordered table-condensed table-hover">
                    <thead>
                        <th>Data</th>
                        <th>Last Update</th>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <asp:Button runat="server" ID="btnScrapeStandings" OnClick="btnScrapeStandings_Click" Text="Update Standings" CssClass="btn btn-primary" />
                            </td>
                            <td>
                                <asp:Label runat="server" ID="lblStandingsLastUpdated"></asp:Label>                                
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button runat="server" ID="btnScrapeHistory" OnClick="btnScrapeHistory_Click" Text="Update History" CssClass="btn btn-primary" />
                            </td>
                            <td>

                            </td>
                        </tr>
                    </tbody>                             
                </table>
            </div>
            <div class="col-md-4"></div>
        </div>

    </div>
</asp:Content>
