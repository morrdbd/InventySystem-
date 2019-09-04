<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MainDashBord.Master" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="Inventory_Manager_ALKC.Account.ManageUsers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
      <br />
    <div class="panel panel-primary">
        <div class="panel-heading blue-bg"><span style="color: white">User Management</span></div>
        <div class="panel-body">
            <div class="row">
                <div class="col-lg-12">
                    <ul class="nav nav-tabs">
                        <li class="active"><a data-toggle="tab" href="#UserManagement">User Management</a></li>
                        <li><a data-toggle="tab" href="#CreateUser">Create User</a></li>
                    </ul>
                    <div class="tab-content">
                        <div id="UserManagement" class="tab-pane fade in active">
                            <br />
                            <div class="row">
                                <div class="col-lg-12 ">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="form-group">
                                                <label class="col-md-2 control-label">Full Name</label>
                                                <div class="col-md-5">
                                                    <input type="text" id="txtSearch" name="txtSearch" class="form-control" />
                                                </div>
                                                <div class="col-md-2">
                                                    <button type="button" class="btn btn-success" onclick="SearchUser(this);" value="Search"><i class="glyphicon glyphicon-search"></i>Search</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <hr />
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div id="userslist">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="CreateUser" class="tab-pane fade">
                            <asp:CreateUserWizard ID="CreateUserWizard1" Width="100%" runat="server" OnCreatedUser="CreateUserWizard1_CreatedUser" LoginCreatedUser="False" OnCreatingUser="CreateUserWizard1_CreatingUser">
                                <WizardSteps>
                                    <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server">
                                        <ContentTemplate>
                                            </script>
                                            <br />
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
                                                    <div class="form-group">
                                                        <label class="col-md-3 control-label">Employee ID For Search</label>
                                                        <div class="col-md-6">
                                                            <asp:TextBox ID="txtEmployeeIDSearch" runat="server" class="form-control"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <asp:Button ID="btnSearch" CssClass="btn btn-success" runat="server" Text="Search" OnClick="btnSearch_Click" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <hr />
                                            <br />
                                            <div class="row">
                                                <div class="col-lg-6">
                                                    <div class="form-group">
                                                        <div class="input-group">
                                                            <span class="input-group-addon bg-blue-gradient">Registration No</span>
                                                            <asp:TextBox ID="txtEmployeeID" runat="server" ReadOnly="true" class="form-control"></asp:TextBox>
                                                            <span class="input-group-addon bg-gray">
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtEmployeeID" ErrorMessage="**" ToolTip="Search Employee Frist" ValidationGroup="CreateUserWizard1" ForeColor="Red"></asp:RequiredFieldValidator>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-6">
                                                    <div class="form-group">
                                                        <div class="input-group">
                                                            <span class="input-group-addon bg-blue-gradient">Employee Name</span>
                                                            <asp:TextBox ID="txtEmployeeName" ReadOnly="true" runat="server" class="form-control"></asp:TextBox>
                                                            <span class="input-group-addon bg-gray">
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtEmployeeName" ErrorMessage="**" ToolTip="Search Employee Frist" ValidationGroup="CreateUserWizard1" ForeColor="Red"></asp:RequiredFieldValidator>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-lg-6">
                                                    <div class="form-group">
                                                        <div class="input-group">
                                                            <span class="input-group-addon bg-blue-gradient">User Name</span>
                                                            <asp:TextBox ID="UserName" CssClass="form-control" runat="server"></asp:TextBox>
                                                            <span class="input-group-addon bg-gray">
                                                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="CreateUserWizard1" ForeColor="#FF3300">*</asp:RequiredFieldValidator>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-6">
                                                    <div class="form-group">
                                                        <div class="input-group">
                                                            <span class="input-group-addon bg-blue-gradient">Email Address</span>
                                                            <asp:TextBox ID="Email" runat="server" CssClass="form-control"></asp:TextBox>
                                                            <span class="input-group-addon bg-gray">
                                                                <asp:RequiredFieldValidator ID="EmailRequired" runat="server"
                                                                    ControlToValidate="Email" ErrorMessage="E-mail is required."
                                                                    ToolTip="E-mail is required." ValidationGroup="CreateUserWizard1" ForeColor="Red">*</asp:RequiredFieldValidator>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-lg-6">
                                                    <div class="form-group">
                                                        <div class="input-group">
                                                            <span class="input-group-addon bg-blue-gradient">Password</span>
                                                            <asp:TextBox ID="Password" runat="server" class="form-control" TextMode="Password"></asp:TextBox>
                                                            <span class="input-group-addon bg-gray">
                                                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server"
                                                                    ControlToValidate="Password" ErrorMessage="Password is required."
                                                                    ToolTip="Password is required." ValidationGroup="CreateUserWizard1" ForeColor="Red">*</asp:RequiredFieldValidator>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-6">
                                                    <div class="form-group">
                                                        <div class="input-group">
                                                            <span class="input-group-addon bg-blue-gradient">Confirm Password</span>
                                                            <asp:TextBox ID="ConfirmPassword" runat="server" class="form-control" TextMode="Password"></asp:TextBox>
                                                            <span class="input-group-addon bg-gray">
                                                                <asp:CompareValidator ID="PasswordCompare" runat="server"
                                                                    ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                                                                    Display="Dynamic"
                                                                    ErrorMessage="The Password and Confirmation Password must match."
                                                                    ValidationGroup="CreateUserWizard1" ForeColor="Red"></asp:CompareValidator>
                                                                <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server"
                                                                    ControlToValidate="ConfirmPassword"
                                                                    ErrorMessage="Confirm Password is required."
                                                                    ToolTip="Confirm Password is required." ValidationGroup="CreateUserWizard1" ForeColor="Red">*</asp:RequiredFieldValidator>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-lg-6">
                                                    <div class="form-group">
                                                        <div class="input-group">
                                                            <span class="input-group-addon bg-blue-gradient">Secuirty Question</span>
                                                            <asp:TextBox ID="Question" runat="server" CssClass="form-control"></asp:TextBox>
                                                            <span class="input-group-addon bg-gray">
                                                                <asp:RequiredFieldValidator ID="QuestionRequired" runat="server"
                                                                    ControlToValidate="Question" ErrorMessage="Security question is required."
                                                                    ToolTip="Security question is required." ValidationGroup="CreateUserWizard1" ForeColor="#FF3300">*</asp:RequiredFieldValidator>
                                                            </span>

                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-6">
                                                    <div class="form-group">
                                                        <div class="input-group">
                                                            <span class="input-group-addon bg-blue-gradient">Question Answer</span>
                                                            <asp:TextBox ID="Answer" runat="server" CssClass="form-control"></asp:TextBox>
                                                            <span class="input-group-addon bg-gray">
                                                                <asp:RequiredFieldValidator ID="AnswerRequired" runat="server"
                                                                    ControlToValidate="Answer" ErrorMessage="Security answer is required."
                                                                    ToolTip="Security answer is required." ValidationGroup="CreateUserWizard1" ForeColor="#FF3300">*</asp:RequiredFieldValidator>
                                                            </span>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:CreateUserWizardStep>
                                    <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server">
                                        <ContentTemplate>
                                            <table>
                                                <tr>
                                                    <td align="center" colspan="2">Complete</td>
                                                </tr>
                                                <tr>
                                                    <td>Your account has been successfully created.</td>
                                                </tr>
                                                <tr>
                                                    <td align="right" colspan="2">
                                                        <asp:Button ID="ContinueButton" CssClass="ui-state-default ui-corner-all" runat="server" CausesValidation="False"
                                                            CommandName="Continue" Text="Continue" ValidationGroup="CreateUserWizard1" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </ContentTemplate>
                                    </asp:CompleteWizardStep>
                                </WizardSteps>
                            </asp:CreateUserWizard>
                         
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="AddUserInRole" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button role="button" type="button" data-dismiss="modal" aria-hidden="true" class="close">&times;</button><h4 class="modal-title">Asign Roles</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-lg-12" id="rolesList">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button role="button" type="button"  data-dismiss="modal" class="btn btn-sm btn-warning">Cancel</button>
                    <button role="button" type="button" class="btn btn-sm btn-primary" onclick="AsignRoles(this);">Asign Roles</button>

                 
                </div>
            </div>
        </div>
    </div>

    <script>
        function SearchUser(ref) {
            var usr = $('#txtSearch').val();
            getUsers(usr);
        }
        $(function () {
            getUsers("");
        });
    </script>
    <script type="text/javascript">


        function getUsers(username) {
            debugger;
            $.ajax({
                type: "POST",
                url: "ManageUsers.aspx/SearchUser",
                data: '{username:"' + username + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    debugger;
                    console.log(data);
                    var tbl = "<table class='table table-bordered table-hover'><thead><tr><th>UserID</th><th>User Name</th><th>Email</th><th>Last Login Date</th><th>Action</th></tr></thead><tbody>";
                    $.each(data.d, function (i, x) {
                        tbl += "<tr><td><span id='userid'>" + x.UserId + "</span></td><td>" + x.UserName + "</td><td>" + x.Email + "</td><td>" + x.LastLoginDate + "</td>";
                        tbl += "<td valign='top'><span id='UserIDShow' style='display:none'>" + x.UserId + "</span><button type='button' class='btn btn-sm btn-success' onclick='ShowRoleModal(this)' data-dismiss='modal'>&nbsp;<i class='glyphicon glyphicon-check'></i></button>";
                        tbl += "<span id='UserIDShow1' style='display:none'>" + x.UserId + "</span>  <button type='button' class='btn btn-sm btn-warning' onclick='GetEmployeeByRef(this)' data-dismiss='modal'>&nbsp;<i class='glyphicon glyphicon-lock'></i></button>";
                        tbl += "<span id='UserIDShow2' style='display:none'>" + x.UserId + "</span><button type='button' class='btn btn-sm btn-default' onclick='ResetPassword(this)' data-dismiss='modal'>&nbsp;<i class='glyphicon glyphicon-ok'></i></button>";
                           tbl+="</td>";
                        tbl+="</tr>";
                    });
                    tbl += "</tbody></table>"
                    $('#userslist').html(tbl);
                },
                failure: function (data) {
                    alert('error occured');
                }
            });
        }
        function ShowRoleModal(ref) {
            debugger;
            var userid = $(ref).parent('td').find('#UserIDShow').html();
            $.ajax({
                type: "POST",
                url: "ManageUsers.aspx/GetUserRoles",
                data: '{UserID:"' + userid + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    console.log(data);
                    var tbl = "<table class='table table-bordered table-hover' id='tblroles'><thead><tr><th>Role ID</th><th>Role Name</th><th>is Asigned</th></tr></thead><tbody>";
                    $.each(data.d, function (i, x) {
                        tbl += "<tr>";
                        tbl += "<td><span id='roleid'>" + x.ID + "</span><span id='userid' style='display:none'>" + userid + "</span></td>";
                        tbl += "<td><span id='rolename'>" + x.Name + "</span></td>";
                        if (x.IsInRole)
                            tbl += "<td><input type='checkbox' id='chkIsInRole' checked='checked' /></td>";
                        else
                            tbl += "<td><input type='checkbox' id='chkIsInRole' /></td>";
                        tbl += "</tr>";
                    });
                    tbl += "</tbody></table>"
                    $('#rolesList').html(tbl);
                },
                failure: function (data) {
                    alert('error occured');
                }
            });
            $('#AddUserInRole').modal('show');
        }
        function AsignRoles(ref) {
            debugger;
            var userid;
            var roles = [];
            $('#tblroles tbody tr').each(function () {
                var chk = $(this).find('#chkIsInRole');
                var roleid = $(this).find('#roleid').html();
                userid = $(this).find('#userid').html();
                if ($(chk).is(':checked')) {
                    roles.push(roleid);
                }


            });
            $.ajax({
                type: "POST",
                url: "ManageUsers.aspx/AsignRoles",
                data: JSON.stringify({ "UserID": userid, "roles": roles }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                },
                failure: function (data) {
                    alert('error occured');
                }

            });

            $('#AddUserInRole').modal('hide');
            toastr.success("Roles Asigned Successfully", "Roles Asigned");
        }

        function ResetPassword(ref) {
            debugger;
            var userid = $(ref).parent('td').find('#UserIDShow2').html();
            $.ajax({
                url: "ManageUsers.aspx/ResetPassword",
                type: "POST",
                data: JSON.stringify({ 'UserID': userid }),
                contentType: 'application/json; charset=utf-8',
                success: function (result) {
                    console.log(result);
                    if (result)
                        toastr.success("Password Reset successfull.", 'Success')
                    else
                        toastr.error("Password not reset Error occured", 'Error')
                },
                error: function (request) {
                    // ...
                }
            });
        }
        function LockUnlock(ref) {
            debugger;
            var btn = $(ref).html();
            var _message = "";
            var _action = "";
            if (btn == "Unlock") {
                _message = "Do you want to Unlock this User ?";
                _action = "Unlock";
            }
            else {
                _message = "Do you want to lock this User ?";
                _action = "lock";
            }
            var userid = $(ref).parent('td').find('#UserIDShow1').html();
            bootbox.dialog({
                message: _message,
                title: "Reset Password",
                buttons: {
                    success: {
                        label: "Yes",
                        className: "btn-danger",
                        callback: function () {

                            $.ajax({
                                url: "ManageUsers.aspx/LockUnlock",
                                type: "POST",
                                data: JSON.stringify({ 'UserID': userid, 'Action': _action }),
                                contentType: 'application/json; charset=utf-8',
                                success: function (result) {
                                    console.log(result);
                                    if (result) {
                                        if (btn == "Unlock") {
                                            toastr.success("User unlocked successfully.", 'Success');
                                        }
                                        else
                                            toastr.success("User locked successfully.", 'Success');
                                    }
                                    else {
                                        toastr.error("Error occured in locking/unlocking", 'Error');
                                    }
                                    getUsers("");

                                },
                                error: function (request) {
                                    // ...
                                }
                            });
                        }
                    },
                    danger: {
                        label: "No",
                        className: "btn-success",
                        callback: function () {

                        }
                    }
                }
            });
        }
    </script>
</asp:Content>
