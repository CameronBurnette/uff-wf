<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Scrape.aspx.cs" Inherits="UFF_wf.Scrape" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container" style="padding-top: 100px;">
        <div class="row">
            <asp:Label runat="server" ID="lblMessage"></asp:Label>
            <div class="col-md-4">
                <asp:Button runat="server" ID="btnScrapeStandings" OnClick="btnScrapeStandings_Click" Text="Update Standings" CssClass="btn btn-primary" />
                <asp:Button runat="server" ID="btnScrapeHistory" OnClick="btnScrapeHistory_Click" Text="Update History" CssClass="btn btn-primary" />
            </div>
        </div>
    </div>
</asp:Content>
