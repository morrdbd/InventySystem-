<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Inventory.Master" AutoEventWireup="true" CodeBehind="frmProductBrand.aspx.cs" Inherits="Inventory_Manager_ALKC.IMIS_Pages.frmProductBrand" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
          <br />
    <div class="panel panel-success">
        <div class="panel-heading badge-success"><span style="color: white">د توکي سوداګریز نوم ثبتول</span></div>
       
        <div class="panel-body">
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="form-group col-md-3 col-sm-3">
                        <label for="name">سوداګریز نوم</label>
                        <input type="text" id="txtBrandName" name="txtOrigin_Name" placeholder=" د توکي سوداګریز" class="form-control" />
                        <asp:HiddenField ID="hdUser" runat="server" />
                    </div>
                    <div class="form-group col-md-3 col-sm-3">
                        <br />
                        <button type="button" id="btnSave" onclick="Save();" class="btn btn-primary">Submite</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading badge-primary"><span style="color: white">د توکو سوداګریز لست لړ</span></div>
        <div class="panel-body">
            <div class="row">
                <div class="col-lg-12 ">
                    <div class="form-inline">
                        <label for="name">پلټنه په سوداګریز نوم</label>
                        <input type="text" id="txtSearch" name="txtOrigin_Name" placeholder=" د توکي سوداګریز" class="form-control" />
                        <button type="button" id="btnSerach" class="btn btn-primary">وی پلټی</button>
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
                    <h4 class="modal-title">د توکي سوداګریز نوم تغیرول</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="form-group col-md-6 col-sm-6">
                            <label for="name"> د توکي سوداګریز</label>
                            <input type="text" id="txtBrandNameE" name="txtOrigin_Name" placeholder=" د توکي سوداګریز" class="form-control" />
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
            $('#txtBrandName').focus();
        });
        function Save() {
            debugger;
            if ($('#txtBrandName').val() == '') {
                toastr.error('Brand Name is Required', 'Error :');
                return;
            }

            var txtBrandName = $('#txtBrandName').val();
            var UserID = $('#<%=hdUser.ClientID%>').val();
          
            var Object = { BrandName: txtBrandName, UserID: UserID };
            $.ajax({
                type: "POST",
                url: "frmProductBrand.aspx/Insert",
                data: JSON.stringify({ 'Obj': Object }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data) {
                        toastr.success('Data Saved Successfully', 'Success :');
                        GetList();
                        $('#txtBrandName').val('');
                        $('#txtBrandName').focus();
                    }
                },
                failure: function (response) {
                    toastr.error('', 'Error');
                }
            });
        }
        function Update() {
            debugger;
            if ($('#txtBrandNameE').val() == '') {
                toastr.error('Brand Name is Required', 'Error :');
                return;
            }
            var txtBrandNameE = $('#txtBrandNameE').val();
            var UserID = $('#<%=hdUser.ClientID%>').val();
            var BrandID = $('#<%=hdID.ClientID%>').val();
            var Object = { BrandID: BrandID, BrandName: txtBrandNameE, LastUpdatedBy: UserID };
            $.ajax({
                type: "POST",
                url: "frmProductBrand.aspx/Update",
                data: JSON.stringify({ 'Obj': Object }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data) {
                        toastr.success('Data Saved Successfully', 'Success :');
                        GetList();
                        $('#txtBrandNameE').val('');
                        $('#EditDialog').modal('hide');
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
                url: "frmProductBrand.aspx/GetListByStoreID",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function (data) {
                    console.log(data);
                    var tbl = "<div><table class='table table-bordered table-condensed table-hover'><thead><th>شمیره</th><th> د توکي سوداګریز</th><th>Entry نيټه</th><th> </th></thead><tbody>";
                    $.each(data.d, function (i, x) {
                        tbl += "<tr>";
                        tbl += "<td>" + x.BrandID + "</td>";
                        tbl += "<td>" + x.BrandName + "</td>";
                        tbl += "<td>" + x.SystemDate + "</td>";
                        tbl += "<td valign='top'><span id='ID' style='display:none'>" + x.BrandID + "</span><span class='btn btn-success' onclick='showEditModal(this)'>&nbsp;<i class='glyphicon glyphicon-pencil'></i></span></td>";
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
            var BrandID = $(ref).parent('td').find('#ID').html();
            var Object = { BrandID: BrandID };
            $.ajax({
                type: "post",
                dataType: "JSON",
                contentType: "application/json; charset=utf-8",
                url: 'frmProductBrand.aspx/EditData',
                data: JSON.stringify({ 'Obj': Object }),
                success: function (data) {
                    $('#<%=hdID.ClientID%>').val(data.d[0].BrandID);
                    $('#txtBrandNameE').val(data.d[0].BrandName);
                },
                failure: function (data) {
                    alert('error occured');
                }
            });
                $('#EditDialog').modal('show');
            }
    </script>
</asp:Content>
