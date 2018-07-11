<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Scrape.aspx.cs" Inherits="UFF_wf.Scrape" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container" style="padding-top: 100px;">
        <div class="row">
            <asp:Label runat="server" ID="lblMessage"></asp:Label>
        </div>
        <div class="row">
            <div class="col-md-8">
                <asp:Repeater ID="rpStandings" ItemType="System.string" runat="server">
                    <ItemTemplate>
                        <h4><%# Item %></h4>                        
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <div class="col-md-4">
                <asp:Button runat="server" ID="btnScrapeStandings" OnClick="btnScrapeStandings_Click" Text="Update Standings" CssClass="btn btn-primary" />
            </div>
        </div>
    </div>
</asp:Content>
