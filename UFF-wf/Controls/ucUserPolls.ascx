<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucUserPolls.ascx.cs" Inherits="UFF_wf.Controls.ucUserPolls" %>


<style>
    body {
        margin-top: 20px;
    }

    .panel-body:not(.two-col) {
        padding: 0px;
    }

    .glyphicon {
        margin-right: 5px;
    }

    .glyphicon-new-window {
        margin-left: 5px;
    }

    .panel-body .radio, .panel-body .checkbox {
        margin-top: 0px;
        margin-bottom: 0px;
    }

    .panel-body .list-group {
        margin-bottom: 0;
    }

    .margin-bottom-none {
        margin-bottom: 0;
    }

    .panel-body .radio label, .panel-body .checkbox label {
        display: block;
    }
</style>

<script type="text/javascript">
    $(document).ready(function () {
        $("input .btnVote[type='button']").click(function () {
            debugger;
            var radioValue = $("input[name='gender']:checked").val();
            if (radioValue) {
                return radioValue;
            }
        });

        $('.chkVote').click(function (event) {
            var chkChanged = $(this);
            var chkBelow = $(this).parent().parent().parent().next('li').find('.chkVote');

            var listItems = chkChanged.parent().parent().parent().parent().find('li');

            listItems.each(function (index) {
                if ($(this).find('.chkVote')["0"].childNodes["0"].id != chkChanged["0"].childNodes["0"].id) {
                    var chkFlip = $(this).find('.chkVote');

                    chkFlip.children().prop('checked', false);
                }
            });
        });

    });
</script>

<div class="col-md-12">
    <h3 style="text-align: center;">Active Polls</h3>
    <hr />
</div>
<asp:Repeater ID="rpPolls" runat="server" OnItemDataBound="rpPolls_ItemDataBound">
    <ItemTemplate>
        <div class="col-md-4" style="padding: 15px;">
            <div class="panel panel-primary">
                <div class="panel-heading" style="text-align: center; padding: 10px 25px">
                    <h3 class="panel-title" runat="server"><span class="fa fa-line-chart" style="float: left;"></span><%# Eval("Question") %></h3>
                </div>
                <asp:HiddenField ID="hdnpollid" runat="server" Value='<%# Eval("PK_PollId") %>' />
                <div class="panel-body">
                    <ul class="list-group">
                        <asp:Repeater ID="rpOptions" runat="server" OnItemCommand="rpOptions_ItemCommand">
                            <ItemTemplate>
                                <li class="list-group-item">
                                    <div class="checkbox">
                                        <label style="display: inline-block;">
                                            <asp:CheckBox runat="server" ID="cbVote" ClientIDMode="AutoID" CssClass="chkVote" Style="vertical-align: middle;" value='<%# Eval("PK_OptionId") %>' />&nbsp&nbsp&nbsp<%# Eval("Answer") %>
                                        </label>
                                    </div>
                                </li>
                            </ItemTemplate>
                            <FooterTemplate>
                                <div class="panel-footer text-center">
                                    <asp:Button ID="lbSubmitVote" CommandName="Vote" runat="server" CssClass="btn btn-primary btn-block btn-sm btnVote" Text="Vote" />
                                    <a href="#" class="small">View Result</a>
                                </div>
                            </FooterTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
        </div>
    </ItemTemplate>
</asp:Repeater>
