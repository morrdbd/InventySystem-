<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Inventory.Master" AutoEventWireup="true" CodeBehind="frmProductPaking.aspx.cs" Inherits="Inventory_Manager_ALKC.IMIS_Pages.frmProductPaking" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
         <br />
    <div class="panel panel-success">
        <div class="panel-heading badge-success"><span style="color: white"> د توکي بسته بندي ثبتولو فورمه</span></div>
        <div class="panel-body">
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="form-group col-md-3 col-sm-3">
                        <label for="name">د توکي بسته بندي نوم</label>
                        <input type="text" id="txtPakingName" name="txtOrigin_Name" placeholder="د توکي بسته بندي" class="form-control" />
                        <asp:HiddenField ID="hdUser" runat="server" />
                        <asp:HiddenField ID="hdStoreID" runat="server" />
                    </div>
                    <div class="form-group col-md-3 col-sm-3">
                        <br />
                        <button type="button" id="btnSave" onclick="Save();" class="btn btn-primary">ثبت</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading badge-primary"><span style="color: white">لیست لړ</span></div>
        <div class="panel-body">
            <div class="row">
                <div class="col-lg-12 ">
                    <div class="form-inline">
                        <label for="name">پلټنه د توکي په بسته ندي</label>
                        <input type="text" id="txtSearch" name="txtOrigin_Name" placeholder="Group Name for Search" class="form-control" />
                        <button type="button" id="btnSerach" class="btn btn-primary">پلټنه</button>
                    </div>
                </div>
            </div>
            <br />
            <div class="row">
                <div class="col-lg-12">
                <div class="table table-responsive" style="overflow: auto">
                    <div id="DivList">
                    </div>
                </div>
                </div>
            </div>
        </div>
    </div>
    <div id="EditDialog" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">د توکو بسته بندی تعیرول</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="form-group col-md-6 col-sm-6">
                            <label for="name">د توکي بسته بندي</label>
                            <input type="text" id="txtPakingNameE" name="txtOrigin_Name" placeholder="د توکي بسته بندي" class="form-control" />
                            <asp:HiddenField ID="hdID" runat="server" />
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" onclick="Update();" class="btn btn-primary">Save changes</button>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            GetList();
            $('#txtPakingName').focus();
        });
        function Save() {
            debugger;
            if ($('#txtPakingName').val() == '') {
                toastr.error('د توکي بسته بندي حتمی دی', 'Error :');
                $('#txtPakingName').focus();
                return;
            }
            var txtPakingName = $('#txtPakingName').val();
            var UserID = $('#<%=hdUser.ClientID%>').val();
           
            var Object = { PackingName: txtPakingName, UserID: UserID };
            $.ajax({
                type: "POST",
                url: "frmProductPaking.aspx/Insert",
                data: JSON.stringify({ 'Obj': Object }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data) {
                        toastr.success('Data Saved Successfully', 'Success :');
                        GetList();
                        $('#txtPakingName').val('');
                        $('#txtPakingName').focus();
                    }
                },
                failure: function (response) {
                    toastr.error('', 'Error');
                }
            });
        }
        function Update() {
            debugger;
            if ($('#txtPakingNameE').val() == '') {
                toastr.error('Paking Name is Required', 'Error :');
                return;
            }
            var txtPakingNameE = $('#txtPakingNameE').val();
            var UserID = $('#<%=hdUser.ClientID%>').val();
            var PackingID = $('#<%=hdID.ClientID%>').val();
            var Object = { PackingID: PackingID, PackingName: txtPakingNameE, LastUpdatedBy: UserID };
            $.ajax({
                type: "POST",
                url: "frmProductPaking.aspx/Update",
                data: JSON.stringify({ 'Obj': Object }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data) {
                        toastr.success('Data Saved Successfully', 'Success :');
                        GetList();
                        $('#txtPakingNameE').val('');
                        $('#EditDialog').modal('hide');
                        $('#txtPakingName').focus();
                    }
                },
                failure: function (response) {
                    toastr.error('', 'Error');
                }
            });
        }
        function GetList() {
            debugger;
          
            $.ajax({
                type: "POST",
                url: "frmProductPaking.aspx/GetListByStoreID",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function (data) {
                    console.log(data);
                    var tbl = "<div><table class='table table-bordered table-condensed table-hover'><thead><th>شمیره</th><th>د توکي بسته بندي</th><th>نیټه</th><th> </th></thead><tbody>";
                    $.each(data.d, function (i, x) {
                        tbl += "<tr>";
                        tbl += "<td>" + x.PackingID + "</td>";
                        tbl += "<td>" + x.PackingName + "</td>";
                        tbl += "<td>" + x.SystemDate + "</td>";
                        tbl += "<td valign='top'><span id='ID' style='display:none'>" + x.PackingID + "</span><span class='btn btn-success' onclick='showEditModal(this)'>&nbsp;<i class='glyphicon glyphicon-pencil'></i></span></td>";
                        tbl += "</tr>";
                    });
                    tbl += "</tbody></table></div>";
                    $('#DivList').html(tbl);
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }
        function showEditModal(ref) {
            debugger;
            var PackingID = $(ref).parent('td').find('#ID').html();
            var Object = { PackingID: PackingID };
            $.ajax({
                type: "post",
                dataType: "JSON",
                contentType: "application/json; charset=utf-8",
                url: 'frmProductPaking.aspx/EditData',
                data: JSON.stringify({ 'Obj': Object }),
                success: function (data) {
                    $('#<%=hdID.ClientID%>').val(data.d[0].PackingID);
                    $('#txtPakingNameE').val(data.d[0].PackingName);
                },
                failure: function (data) {
                    alert('error occured');
                }
            });
                $('#EditDialog').modal('show');
            }
    </script>
</asp:Content>
