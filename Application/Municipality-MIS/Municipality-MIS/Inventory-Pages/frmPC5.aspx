<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmPC5.aspx.cs" Inherits="Municipality_MIS.Inventory_Pages.frmPC5" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../Content/MIS-Them/dist/css/base.css" rel="stylesheet" type="text/css" />
    <link href="../Content/MIS-Them/dist/css/component_ui.min.css" rel="stylesheet" type="text/css" />
    <link href="../Content/MIS-Them/dist/css/component_ui_rtl.css" rel="stylesheet" type="text/css" />
    <link href="../Content/MIS-Them/dist/css/custom.css" rel="stylesheet" type="text/css" />
    <title></title>

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" EnablePageMethods="true" runat="server">
            <Scripts>
                <asp:ScriptReference Path="~/Content/MIS-Them/plugins/jQuery/jquery-1.12.4.min.js" />
                <asp:ScriptReference Path="~/Content/MIS-Them/bootstrap/js/bootstrap.min.js" />
                <asp:ScriptReference Path="~/Content/MIS-Them/plugins/lobipanel/lobipanel.min.js" />
                <asp:ScriptReference Path="~/Content/MIS-Them/plugins/animsition/js/animsition.min.js" />
                <asp:ScriptReference Path="~/Content/MIS-Them/plugins/bootsnav/js/bootsnav.js" />
                <asp:ScriptReference Path="~/Content/MIS-Them/plugins/slimScroll/jquery.slimscroll.min.js" />
                <asp:ScriptReference Path="~/Content/MIS-Them/plugins/fastclick/fastclick.min.js" />
                <asp:ScriptReference Path="~/Content/MIS-Them/dist/js/dashboard.js" />
                <asp:ScriptReference Path="~/Scripts/treeview/bootstrap-treeview.js" />
                <asp:ScriptReference Path="~/Content/MIS-Them/plugins/jquery-ui-1.12.1/jquery-ui.min.js" />
                <asp:ScriptReference Path="~/Scripts/bootstrap-datepicker.js" />
                <asp:ScriptReference Path="~/Scripts/bootstrap-datepicker.fa.min.js" />
                <asp:ScriptReference Path="~/Scripts/treeview/BootstrapMenu.min.js" />
                <asp:ScriptReference Path="~/Scripts/select2.js" />
                <asp:ScriptReference Path="~/Scripts/toastr.min.js" />
            </Scripts>
        </asp:ScriptManager>
        <div style="direction: rtl">
            <table style="width: 100%; text-align: right; font-size: 15px" class="table table-bordered">
                <tr>
                    <td colspan="4"><b style="font-size: x-large">فورمه ف س&nbsp;&nbsp;&nbsp; (۵)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; تکت توزیع تحویلخانه&nbsp;&nbsp;&nbsp; </b></td>
                </tr>
                <tr>
                    <td>۱- نمبر تکت :</td>
                    <td>
                        <asp:Label ID="lblTikitNo" runat="server" Text=""></asp:Label></td>
                    <td>۴- نمبر درخواست: </td>
                    <td>
                        <asp:Label ID="lblRequestNo" runat="server" Text=""></asp:Label>
                        <asp:HiddenField ID="hdMainID" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>۲ - تاریخ : </td>
                    <td>
                        <asp:Label ID="lblDate" runat="server" Text=""></asp:Label></td>
                    <td>۵- تاریخ درخواست:</td>
                    <td>
                        <asp:Label ID="lblRequestDate" runat="server" Text=""></asp:Label></td>
                </tr>
                <tr>
                    <td>۳-&nbsp; تحویلخانه توزیع کننده:</td>
                    <td>
                        <asp:Label ID="lblAssgineSection" runat="server" Text=""></asp:Label></td>
                    <td>۶- شبعه درخواست کننده: </td>
                    <td>
                        <asp:Label ID="lblRequestDept" runat="server" Text=""></asp:Label></td>
                </tr>
            </table>

            <div id="ProductList">
            </div>
        </div>
        <script type="text/javascript">
            $(function () {
                GetAssetMain($('#<%=hdMainID.ClientID%>').val());
            });

            $(function () {
                window.print();
            });

            function GetAssetMain(ID) {
                debugger;
                $.ajax({
                    type: "post",
                    dataType: "JSON",
                    contentType: "application/json; charset=utf-8",
                    url: 'frmPC5.aspx/GetAssetMain',
                    data: "{MainID:'" + ID + "'}",
                    async: false,
                    cache: false,
                    success: function (data) {
                        $('#<%=lblRequestNo.ClientID%>').html(data.d[0].RequestNumber);
                        $('#<%=lblRequestDept.ClientID%>').html(data.d[0].RequestByDepartment);
                        $('#<%=lblRequestDate.ClientID%>').html(data.d[0].RequestDate);
                        $('#<%=lblTikitNo.ClientID%>').html(data.d[0].TicketNumber);
                        $('#<%=lblAssgineSection.ClientID%>').html(data.d[0].AssgineDepartment);
                        $('#<%=lblDate.ClientID%>').html(data.d[0].SystemDate);
                        GetAssetDetail(ID);

                    },
                    failure: function (data) {
                        alert('error occured');
                    }
                });
            }

            function GetAssetDetail(ID) {
                debugger;
                $.ajax({
                    type: "POST",
                    url: "frmPC5.aspx/GetAssetDetail",
                    data: "{MainID:'" + ID + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    cache: false,
                    success: function (data) {
                        console.log(data);
                        var tbl = "<div><table class='table table-bordered table-hover'><thead class='thead thead-default' ><th>مقدار</th><th>	تبصر ذخیره</th><th>	تفصیلات جنس</th><th>	قیمت واحد</th><td>	قیمت مجموعی</td><td>	معامله شد به حساب</td></thead><thead class='thead thead-default' >";
                        tbl += "<th>۷</th><th>۸</th><th>۹</th><th>۱۰</th><td>۱۱</td><td>۱۲</td></thead><tbody>";
                        $.each(data.d, function (i, x) {
                            tbl += "<tr class='table table-warning'>";
                            tbl += "<td>" + x.Quantity + "</td>";
                            tbl += "<td>" + x.UnitName + "</td>";
                            tbl += "<td>" + x.ProductName + "," + x.SerialNumber + "</td>";
                            tbl += "<td>" + x.Price + "</td>";
                            tbl += "<td>" + x.Total + "</td>";
                            tbl += "<td>" + x.EmpName + "</td>";
                            tbl += "</tr>";
                        });
                        tbl += "<tr>";
                        tbl += "<td></td>";
                        tbl += "<td></td>";
                        tbl += "<td>۱۳ - مجموع کل</td>";
                        tbl += "<td></td>";
                        tbl += "<td>" + data.d[0].SubTotal + "</td>";
                        tbl += "<td></td>";
                        tbl += "</tr>";
                        tbl += "</tbody></table></div>";
                        $('#ProductList').html(tbl);
                    },
                    failure: function (response) {
                        alert(response.d);
                    }
                });
            }
        </script>
    </form>
</body>
</html>
