<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="OpenAuthProviders.ascx.cs" Inherits="UFF_wf.Account.OpenAuthProviders" %>

<div id="socialLoginList">
    <asp:ListView runat="server" ID="providerDetails" ItemType="System.String"
        SelectMethod="GetProviderNames" ViewStateMode="Disabled">
        <ItemTemplate>
            <p>
                <button type="submit" class="btn btn-default" name="provider" value="<%#: Item %>"
                    title="Log in using your <%#: Item %> account.">
                    <img src="../images/btn_google_signin_dark_normal_web.png" />
                </button>
            </p>
        </ItemTemplate>
        <EmptyDataTemplate>
            <div>
                <p>There are no external authentication services configured. See <a href="https://go.microsoft.com/fwlink/?LinkId=252803">this article</a> for details on setting up this Ultimate Fantasy Franchise to support logging in via external services.</p>
            </div>
        </EmptyDataTemplate>
    </asp:ListView>
</div>
