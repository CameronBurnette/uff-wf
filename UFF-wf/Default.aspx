<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="UFF_wf._Default" %>

<%@ Register Src="~/Controls/ucStandings.ascx" TagPrefix="uc1" TagName="ucStandings" %>
<%@ Register Src="~/Controls/ucUserPolls.ascx" TagPrefix="uc1" TagName="ucUserPolls" %>



<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">        
        <uc1:ucStandings runat="server" id="ucStandings" />
        <uc1:ucUserPolls runat="server" ID="ucUserPolls" />
    </div>
</asp:Content>
