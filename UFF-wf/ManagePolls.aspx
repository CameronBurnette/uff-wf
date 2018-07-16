<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManagePolls.aspx.cs" Inherits="UFF_wf.ManagePolls" EnableViewState="true" %>

<%@ Register Src="~/Controls/ucManagePolls.ascx" TagPrefix="uc1" TagName="ucManagePolls" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="container">
<%--                <div class="row">
                    <div class="col-md-6">
                        <h3>Add Poll Questions:</h3>
                        <hr />
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <uc1:ucManageQuestions runat="server" ID="ucManageQuestions" />
                    </div>
                </div>--%>
                <div class="row">
                    <div class="col-md-6">
                        <h3>Create New Poll:</h3>
                        <hr />
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <uc1:ucManagePolls runat="server" ID="ucManagePolls" />
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

