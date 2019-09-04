<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Inventory.Master" AutoEventWireup="true" CodeBehind="frmProductSize.aspx.cs" Inherits="Inventory_Manager_ALKC.IMIS_Pages.frmProductSize" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <div class="panel panel-success">
        <div class="panel-heading badge-success"><span style="color: white">د توکي د نوم ثبتولو فورمه</span></div>
        <div class="panel-body">
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="form-group col-md-3 col-sm-3">
                        <label for="name">د توکي اندازه</label>
                        <input type="text" id="txtSizeName" name="txtOrigin_Name" placeholder="د توکي اندازه" class="form-control" />
                        <asp:HiddenField ID="hdUser" runat="server" />
                        <asp:HiddenField ID="hdStoreID" runat="server" />
                    </div>
                    <div class="form-group col-md-3 col-sm-3">
                        <label for="name">د توکي اندازه مخفف</label>
                        <input type="text" id="txtSizeShortName" name="txtOrigin_Name" placeholder="د توکي اندازه مخفف" class="form-control" />
                    </div>
                    <div class="form-group col-md-3 col-sm-3">
                        <br />
                        <button type="button" id="btnSave" onclick="SaveSize();" class="btn btn-primary">ثبت</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading badge-primary"><span style="color: white">لړ لیست</span></div>
        <div class="panel-body">
            <div class="row">
                <div class="col-lg-12 ">
                    <div class="form-inline">
                        <label for="name">د توکي اندازه</label>
                        <input type="text" id="txtSearch" name="txtOrigin_Name" placeholder="د توکي اندازه" class="form-control" />
                        <button type="button" id="btnSerach" class="btn btn-primary">پلټنه</button>
                    </div>
                </div>
            </div>
            <br />
            <div class="row">
                <div class="col-lg-12">
                <div class="table table-responsive" style="overflow: auto">
                    <div id="DivStoreList">
                    </div>
                </div>
                </div>
            </div>
        </div>
    </div>
    <div id="SizeDialog" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">د توکي اندازه تغیرول</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="form-group col-md-6 col-sm-6">
                            <label for="name">د توکي اندازه</label>
                            <input type="text" id="txtSizeNameE" name="txtOrigin_Name" placeholder="د توکي اندازه" class="form-control" />
                            <asp:HiddenField ID="hdSizeID" runat="server" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-6 col-sm-6">
                            <label for="name">د توکي اندازه مخفف</label>
                            <input type="text" id="txtSizeShortNameE" name="txtOrigin_Name" placeholder="د توکي اندازه مخفف" class="form-control" />
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" onclick="UpdateSize();" class="btn btn-primary">Save changes</button>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            GetSizeList();
        });
        function SaveSize() {
            debugger;
            if ($('#txtSizeName').val() == '') {
                toastr.error('د توکي اندازه نوم حتمی دي', 'Error :');
                $('#txtSizeName').focus();
                return;
            }
            if ($('#txtSizeShortName').val() == '') {
                toastr.error('Size Short Name is Required', 'Error :');
                return;
            }
            var txtSizeName = $('#txtSizeName').val();
            var txtSizeShortName = $('#txtSizeShortName').val();
            var UserID = $('#<%=hdUser.ClientID%>').val();
            var StoreID = $('#<%=hdStoreID.ClientID%>').val();
            var Object = { SizeName: txtSizeName, SizeShortName: txtSizeShortName, UserID: UserID };
            $.ajax({
                type: "POST",
                url: "frmProductSize.aspx/InsertSize",
                data: JSON.stringify({ 'clsProductSize': Object }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data) {
                        toastr.success('Data Saved Successfully', 'Success :');
                        GetSizeList();
                    }
                },
                failure: function (response) {
                    toastr.error('', 'Error');
                }
            });
        }
        function UpdateSize() {
            debugger;
            if ($('#txtSizeNameE').val() == '') {
                toastr.error('Size Name is Required', 'Error :');
                return;
            }
            if ($('#txtSizeShortNameE').val() == '') {
                toastr.error('Size Short Name is Required', 'Error :');
                return;
            }
            var txtSizeName = $('#txtSizeNameE').val();
            var txtSizeShortName = $('#txtSizeShortNameE').val();
            var UserID = $('#<%=hdUser.ClientID%>').val();
            var SizeID = $('#<%=hdSizeID.ClientID%>').val();
            var Object = { SizeID: SizeID, SizeName: txtSizeName, SizeShortName: txtSizeShortName, LastUpdatedBy: UserID };
            $.ajax({
                type: "POST",
                url: "frmProductSize.aspx/UpdateSize",
                data: JSON.stringify({ 'clsProductSize': Object }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data) {
                        toastr.success('Data Saved Successfully', 'Success :');
                        GetSizeList();
                        $('#SizeDialog').modal('hide');
                    }
                },
                failure: function (response) {
                    toastr.error('', 'Error');
                }
            });
        }

        function GetSizeList() {
            debugger;
          
            $.ajax({
                type: "POST",
                url: "frmProductSize.aspx/GetSizeList",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function (data) {
                    console.log(data);
                    var tbl = "<div><table class='table table-bordered table-condensed table-hover'><thead><th>شمیره</th><th>د توکي اندازه</th><th>د توکي اندازه مخفف</th><th>نیټه</th><th> </th></thead><tbody>";
                    $.each(data.d, function (i, x) {
                        tbl += "<tr>";
                        tbl += "<td>" + x.SizeID + "</td>";
                        tbl += "<td>" + x.SizeName + "</td>";
                        tbl += "<td>" + x.SizeShortName + "</td>";
                        tbl += "<td>" + x.SystemDate + "</td>";
                        tbl += "<td valign='top'><span id='ID' style='display:none'>" + x.SizeID + "</span><span class='btn btn-success' onclick='showEditModal(this)'>&nbsp;<i class='glyphicon glyphicon-pencil'></i></span></td>";
                        tbl += "</tr>";
                    });
                    tbl += "</tbody></table></div>";
                    $('#DivStoreList').html(tbl);
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }
        function showEditModal(ref) {
            debugger;
            var StoreID = $(ref).parent('td').find('#ID').html();
            var Object = { SizeID: StoreID };
            $.ajax({
                type: "post",
                dataType: "JSON",
                contentType: "application/json; charset=utf-8",
                url: 'frmProductSize.aspx/EditData',
                data: JSON.stringify({ 'clsProductSize': Object }),
                success: function (data) {
                    $('#<%=hdSizeID.ClientID%>').val(data.d[0].SizeID);
                    $('#txtSizeNameE').val(data.d[0].SizeName);
                    $('#txtSizeShortNameE').val(data.d[0].SizeShortName);
                },
                failure: function (data) {
                    alert('error occured');
                }
            });
                $('#SizeDialog').modal('show');
            }
    </script>
</asp:Content>
