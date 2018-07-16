<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucManagePolls.ascx.cs" Inherits="UFF_wf.Controls.ucManagePolls" %>

<script type="text/javascript">

    function onExpandPoll(button) {
        $(button).hide();
        $(button).parent().find('#orderDownArrow').show();
        $(button).parent().parent().next('tr').find('table#Votes').show()
    }

    function onCollapsePoll(button) {
        $(button).hide();
        $(button).parent().find('#orderRightArrow').show();
        $(button).parent().parent().next('tr').find('table#Votes').hide()
    }

        function onExpandVote(button) {
        $(button).hide();
        $(button).parent().find('#voteDownArrow').show();
        $(button).parent().parent().next('tr').find('table#Users').show()
    }

    function onCollapseVote(button) {
        $(button).hide();
        $(button).parent().find('#voteRightArrow').show();
        $(button).parent().parent().next('tr').find('table#Users').hide()
    }
</script>

<div class="col-md-4">
    <div class="row">
        <div class="col-md-3">
            <h4>Question:</h4>
        </div>
        <div class="col-md-9">
            <asp:TextBox ID="txtPollTitle" runat="server" CssClass="form-control" placeholder="Week 6 Featured Match: Team1 vs Team2"></asp:TextBox>
        </div>
    </div>
    <div class="row">
        <div class="col-md-3">
            <h4>Options:</h4>
        </div>
        <div class="col-md-9">
            <asp:TextBox ID="txtPollOptions" runat="server" CssClass="form-control" TextMode="MultiLine" placeholder="Team 1~Team 2"></asp:TextBox>
        </div>
    </div>
    <div class="row" style="padding-top: 10px; padding-bottom: 15px;">
        <div class="col-md-12 .text-right" style="text-align: right">
            <asp:Button ID="btnCreatePoll" runat="server" Text="Create" CssClass="btn btn-primary" OnClick="btnCreatePoll_Click" />
        </div>
    </div>
</div>
<div class="col-md-8">
    <div class="col-md-12 table-responsive" style="text-align: center; vertical-align: middle; padding-left: 0px; padding-right: 0px;">
        <asp:Repeater ID="rpPollQuestions" runat="server" OnItemDataBound="rpPollQuestions_OnItemDataBound">
            <HeaderTemplate>
                <table id="Polls" class="table table-striped table-condensed sortable table-bordered" style="overflow-x: scroll; overflow-y: scroll; text-align: center; vertical-align: middle; margin-bottom: 0px;">
                    <thead>
                        <tr>
                            <th style="text-align: center; vertical-align: middle;">Poll #</th>
                            <th style="text-align: center; vertical-align: middle;">Votes</th>
                            <th style="text-align: center; vertical-align: middle;">Title</th>
                            <th style="text-align: center; vertical-align: middle;">Active</th>
                            <th style="text-align: center; vertical-align: middle;">Delete</th>
                        </tr>
                    </thead>
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr style="text-align: center; vertical-align: middle;">
                    <td><%# Eval("PK_PollId") %></td>
                    <td>
                        <button id="orderDownArrow" class="btn btn-default btn-xs" style="width: 20px; display: none;" onclick="onCollapsePoll(this); return false;" aria-label="Expand/Collapse">
                            <i class="fa fa-caret-down"></i>
                        </button>
                        <button id="orderRightArrow" class="btn btn-default btn-xs" style="width: 20px;" onclick="onExpandPoll(this); return false;" aria-label="Expand/Collapse">
                            <i class="fa fa-caret-right"></i>
                        </button>
                    </td>
                    <td><%# Eval("Question") %></td>
                    <td>
                        <asp:CheckBox ID="chkActive" runat="server" type="checkbox" CssClass='<%# Eval("PK_PollId") %>' Checked='<%# Eval("Active") %>' AutoPostBack="true" OnCheckedChanged="UpdateActiveStatus" />
                    </td>
                    <td>
                        <asp:LinkButton ID="btnDeletePoll" runat="server" CommandArgument='<%# Eval("PK_PollId") %>' OnCommand="DeletePoll">
                            <i class="fa fa-trash" aria-hidden="true"></i>
                        </asp:LinkButton>
                    </td>
                </tr>
                <tr style="background-color: #163e61; border-color: #2e6da4;">
                    <td colspan="5">
                        <asp:Repeater ID="rpVotes" runat="server" OnItemDataBound="rpUserVotes_OnItemDataBound">
                            <HeaderTemplate>
                                <table id="Votes" class="table table-striped table-inverse table-bordered sortable table-condensed" style="text-align: center; vertical-align: middle; display: none;">
                                    <thead>
                                        <tr>
                                            <th style="text-align: center; vertical-align: middle;">Users</th>
                                            <th style="text-align: center; vertical-align: middle;">Answer</th>
                                            <th style="text-align: center; vertical-align: middle;">Votes</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr style="text-align: center; vertical-align: middle;">
                                    <td>
                                        <button id="voteDownArrow" class="btn btn-default btn-xs" style="width: 20px; display: none;" onclick="onCollapseVote(this); return false;" aria-label="Expand/Collapse">
                                            <i class="fa fa-caret-down"></i>
                                        </button>
                                        <button id="voteRightArrow" class="btn btn-default btn-xs" style="width: 20px;" onclick="onExpandVote(this); return false;" aria-label="Expand/Collapse">
                                            <i class="fa fa-caret-right"></i>
                                        </button>
                                    </td>
                                    <td>
                                        <%# Eval("Answer") %>
                                        <asp:HiddenField runat="server" ID="hdnOptionID" Value='<%# Eval("PK_OptionId") %>' />
                                        <asp:HiddenField runat="server" ID="hdnPollID" Value='<%# Eval("FK_PollId") %>' />
                                    </td>
                                    <td><%# Eval("Vote") %></td>
                                </tr>
                                <tr>
                                    <td colspan="12">
                                        <asp:Repeater runat="server" ID="rpUserVotes">
                                            <HeaderTemplate>
                                                <table id="Users" class="table table-striped table-inverse table-bordered sortable table-condensed" style="text-align: center; vertical-align: middle; display: none;">
                                                    <thead>
                                                        <tr>
                                                            <th style="text-align: center; vertical-align: middle;">User</th>
                                                            <th style="text-align: center; vertical-align: middle;">Email</th>
                                                            <th style="text-align: center; vertical-align: middle;">Answer</th>
                                                            <th style="text-align: center; vertical-align: middle;">Voted On</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <tr style="text-align: center; vertical-align: middle;">
                                                    <td><%# Eval("UserName") %></td>
                                                    <td><%# Eval("Email") %></td>
                                                    <td><%# Eval("Answer") %></td>
                                                    <td><%# Eval("VotedOn") %></td>
                                                </tr>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                </tbody>
                                </table>
                                            </FooterTemplate>
                                        </asp:Repeater>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </tbody>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </tbody>
               </table> 
            </FooterTemplate>
        </asp:Repeater>
    </div>
</div>
