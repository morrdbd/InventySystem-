<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Inventory_Manager_ALKC.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Municipality MIS</title>

    <!-- Favicon and touch icons -->
    <link rel="shortcut icon" href="../Content/MIS-Them/dist/img/ico/favicon.png" type="image/x-icon">
    <link rel="apple-touch-icon" type="image/x-icon" href="../Content/MIS-Them/dist/img/ico/apple-touch-icon-57-precomposed.png">
    <link rel="apple-touch-icon" type="image/x-icon" sizes="72x72" href="../Content/MIS-Them/dist/img/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon" type="image/x-icon" sizes="114x114" href="../Content/MIS-Them/dist/img/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon" type="image/x-icon" sizes="144x144" href="../Content/MIS-Them/dist/img/ico/apple-touch-icon-144-precomposed.png">

    <!-- Bootstrap -->
    <link href="../Content/MIS-Them/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Bootstrap rtl -->
    <link href="../Content/MIS-Them/bootstrap-rtl/bootstrap-rtl.min.css" rel="stylesheet" type="text/css" />
    <!-- Pe-icon-7-stroke -->
    <link href="../Content/MIS-Them/pe-icon-7-stroke/css/pe-icon-7-stroke.css" rel="stylesheet" type="text/css" />
    <link href="../Content/MIS-Them/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <!-- Theme style -->
    <link href="../Content/MIS-Them/dist/css/component_ui.min.css" rel="stylesheet" type="text/css" />
    <!-- Theme style rtl -->
    <link href="../Content/MIS-Them/dist/css/component_ui_rtl.css" rel="stylesheet" type="text/css" />
    <!-- Custom css -->
    <link href="../Content/MIS-Them/dist/css/custom.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-wrapper">
            <div class="container-center">
                <div class="panel panel-bd">
                    <div class="panel-heading">
                        <div class="view-header">
                            <div class="header-icon">
                                <i class="pe-7s-unlock"></i>
                            </div>
                            <div class="header-title">
                                <h3>د ننه کیدل:</h3>
                                <small><strong>لطفا د ننوتلو لپاره خپل اعتبار ولیکئ</strong></small>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <form action="http://thememinister.com/bootstrap-admin-template/theme/adminpage_rtl_v1.0/index.html" id="loginForm" novalidate>
                            <asp:Login ID="Login1" runat="server">
                                <LayoutTemplate>
                                    <div class="form-group">
                                        <label class="control-label">کارن نوم</label>
                                        <div class="input-group">
                                            <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                            <asp:TextBox ID="UserName" class="form-control" placeholder="د کارن نوم ولیکئ" ValidationGroup="Login1" runat="server"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label">رمز</label>
                                        <div class="input-group">
                                            <span class="input-group-addon"><i class="fa fa-key"></i></span>
                                            <asp:TextBox ID="Password" runat="server" class="form-control" TextMode="Password" placeholder="رمز ولیکئ" ValidationGroup="Login1"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div>
                                        <asp:Button ID="LoginButton" CssClass="btn btn-primary pull-left" runat="server" CommandName="Login" Text="د ننه شی" ValidationGroup="Login1" />
                                    </div>
                                    <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="Login1" ForeColor="#FF3300">User Name is Required</asp:RequiredFieldValidator>
                                    <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="Login1" ForeColor="#FF3300">! Password is Required</asp:RequiredFieldValidator>
                                </LayoutTemplate>
                            </asp:Login>
                        </form>
                    </div>
                </div>
            </div>
               <div id="bottom_text">
                      .Copyright 2013 - 2018 ACTS Company
                </div>
            </div>
    </form>
    <script src="../Content/MIS-Them/plugins/jQuery/jquery-1.12.4.min.js" type="text/javascript"></script>
    <script src="../Content/MIS-Them/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
</body>
</html>
