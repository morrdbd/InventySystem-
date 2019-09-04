<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Inventory.Master" AutoEventWireup="true" CodeBehind="frmProductUnitOfMeasurement.aspx.cs" Inherits="Inventory_Manager_ALKC.IMIS_Pages.frmProductUnitOfMeasurement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="panel panel-success">
        <div class="panel-heading badge-success"><span style="color: white">د توکی د متحد ډول ثبتولو فورمه</span></div>
        <div class="panel-body">
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="form-group col-md-3 col-sm-3">
                        <label for="name">د توکی د متحد ډول نوم</label>
                        <input type="text" id="txtUOM" name="txtOrigin_Name" placeholder="د توکی د متحد ډول" class="form-control" />
                        <asp:HiddenField ID="hdUser" runat="server" />
                      
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
        <div class="panel-heading badge-primary"><span style="color: white">لړ لیست</span></div>
        <div class="panel-body">
            <div class="row">
                <div class="col-lg-12 ">
                    <div class="form-inline">
                        <label for="name">د توکی د متحد ډول نوم</label>
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
                    <h4 class="modal-title">د توکی د متحد ډول تغیرول</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="form-group col-md-6 col-sm-6">
                            <label for="name">د توکی د متحد ډول</label>
                            <input type="text" id="txtUOME" name="txtOrigin_Name" placeholder="د توکی د متحد ډول نوم" class="form-control" />
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
            $('#txtUOM').focus();
        });
        function Save() {
            debugger;
            if ($('#txtUOM').val() == '') {
                toastr.error('د توکی د متحد ډول حتمی دي', 'Error :');
                $('#txtUOM').focus();
                return;
            }
            var txtUOM = $('#txtUOM').val();
            var UserID = $('#<%=hdUser.ClientID%>').val();
         
            var Object = { UnitName: txtUOM, UserID: UserID };
            $.ajax({
                type: "POST",
                url: "frmProductUnitOfMeasurement.aspx/Insert",
                data: JSON.stringify({ 'Obj': Object }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data) {
                        toastr.success('Data Saved Successfully', 'Success :');
                        GetList();
                        $('#txtUOM').val('');
                        $('#txtUOM').focus();
                    }
                },
                failure: function (response) {
                    toastr.error('', 'Error');
                }
            });
        }
        function Update() {
            debugger;
            if ($('#txtUOME').val() == '') {
                toastr.error('UOM Name is Required', 'Error :');
                return;
            }
            var txtUOME = $('#txtUOME').val();
            var UserID = $('#<%=hdUser.ClientID%>').val();
            var UnitID = $('#<%=hdID.ClientID%>').val();
            var Object = { UnitID: UnitID, UnitName: txtUOME, LastUpdatedBy: UserID };
            $.ajax({
                type: "POST",
                url: "frmProductUnitOfMeasurement.aspx/Update",
                data: JSON.stringify({ 'Obj': Object }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data) {
                        toastr.success('Data Saved Successfully', 'Success :');
                        GetList();
                        $('#txtUOME').val('');
                        $('#EditDialog').modal('hide');
                        $('#txtUOM').focus();
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
                url: "frmProductUnitOfMeasurement.aspx/GetListByStoreID",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function (data) {
                    console.log(data);
                    var tbl = "<div><table class='table table-bordered table-condensed table-hover'><thead><th>شمیره</th><th> د توکی د متحد ډول</th><th>Entry نيټه</th><th> </th></thead><tbody>";
                    $.each(data.d, function (i, x) {
                        tbl += "<tr>";
                        tbl += "<td>" + x.UnitID + "</td>";
                        tbl += "<td>" + x.UnitName + "</td>";
                        tbl += "<td>" + x.SystemDate + "</td>";
                        tbl += "<td valign='top'><span id='ID' style='display:none'>" + x.UnitID + "</span><span class='btn btn-success' onclick='showEditModal(this)'>&nbsp;<i class='glyphicon glyphicon-pencil'></i></span></td>";
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
            var UnitID = $(ref).parent('td').find('#ID').html();
            var Object = { UnitID: UnitID };
            $.ajax({
                type: "post",
                dataType: "JSON",
                contentType: "application/json; charset=utf-8",
                url: 'frmProductUnitOfMeasurement.aspx/EditData',
                data: JSON.stringify({ 'Obj': Object }),
                success: function (data) {
                    $('#<%=hdID.ClientID%>').val(data.d[0].UnitID);
                    $('#txtUOME').val(data.d[0].UnitName);
                },
                failure: function (data) {
                    alert('error occured');
                }
            });
                $('#EditDialog').modal('show');
            }
    </script>
</asp:Content>
