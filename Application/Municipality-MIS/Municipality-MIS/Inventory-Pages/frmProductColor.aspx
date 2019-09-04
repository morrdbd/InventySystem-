<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Inventory.Master" AutoEventWireup="true" CodeBehind="frmProductColor.aspx.cs" Inherits="Inventory_Manager_ALKC.IMIS_Pages.frmProductColor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


 <%--   <link href="../Content/bootstrap-datepicker.min.css" rel="stylesheet" />
    <script src="../Scripts/bootstrap-datepicker.min.js"></script>
     <link href="../Content/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <script src="../Scripts/bootstrap-datepicker.fa.min.js"></script>--%>


     <script src="../Scripts/bootstrap-datepicker.min.js"></script>
    <script src="../Scripts/bootstrap-datepicker.fa.min.js"></script>
    <link href="../Content/bootstrap-datepicker.min.css" rel="stylesheet" />
    <link href="../Content/bootstrap-datetimepicker.min.css" rel="stylesheet" />






    <script type="text/javascript">
        $(function () {
            $('#txtDateOfBirth').datepicker({
                isRTL: true,
                changeMonth: true,
                changeYear: true
            });
        });
    </script>

     <br />
    <div class="panel panel-success">
        <div class="panel-heading badge-success"><span style="color: white">د توکي د رنګ ثبتولو فورمه</span></div>
        <div class="panel-body">
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="form-group col-md-3 col-sm-3">
                        <label for="name">د توکي رنګ</label>
                        <input type="text" id="txtColorName" name="txtOrigin_Name" placeholder="د توکي رنګ" class="form-control" />
                        <asp:HiddenField ID="hdUser" runat="server" />
                    </div>
                    <div class="form-group col-md-3 col-sm-3">
                        <label for="name">د توکي رنګ مخفف</label>
                        <input type="text" id="txtColorShortName" name="txtOrigin_Name" placeholder="د توکي رنګ" class="form-control" />
                    </div>

                      <div class="form-group col-md-3 col-sm-3">
                                    <label for="name">Date of Birth</label>
                                    <input type="text" id="txtDateOfBirth" tabindex="9" name="txtProduct_BarCode" placeholder="Date of Birth" class="form-control" />
                                </div>


                    <div class="form-group col-md-3 col-sm-3">
                        <br />
                        <button type="button" id="btnSave" onclick="Save();" class="btn btn-primary">ثبتول</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading badge-primary"><span style="color: white">د رنګونو لیست لړ</span></div>
        <div class="panel-body">
            <div class="row">
                <div class="col-lg-12 ">
                    <div class="form-inline">
                        <label for="name">د توکي رنګ</label>
                        <input type="text" id="txtSearch" name="txtOrigin_Name" placeholder="د توکي رنګ" class="form-control" />
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
                    <h4 class="modal-title">د توکی رنګ تغیرول</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="form-group col-md-6 col-sm-6">
                            <label for="name">د توکي رنګ</label>
                            <input type="text" id="txtColorNameE" name="txtOrigin_Name" placeholder="د توکي رنګ" class="form-control" />
                            <asp:HiddenField ID="hdID" runat="server" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-6 col-sm-6">
                            <label for="name">د توکي رنګ مخفف</label>
                            <input type="text" id="txtColorShortNameE" name="txtOrigin_Name" placeholder="د توکي رنګ مخفف" class="form-control" />
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
        });
        function Save() {
            debugger;
            if ($('#txtColorName').val() == '') {
                toastr.error('د توکي د رنګ نوم حتمی دی', 'Error :');
                $('#txtColorName').focus();
                return;
            }
            if ($('#txtColorShortName').val() == '') {
                toastr.error('Color Short Name is Required', 'Error :');
                return;
            }
            var txtColorName = $('#txtColorName').val();
            var txtColorShortName = $('#txtColorShortName').val();
            var UserID = $('#<%=hdUser.ClientID%>').val();
           
            var Object = { ColorName: txtColorName, ColorShortName: txtColorShortName, UserID: UserID };
            $.ajax({
                type: "POST",
                url: "frmProductColor.aspx/Insert",
                data: JSON.stringify({ 'Obj': Object }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data) {
                        toastr.success('Data Saved Successfully', 'Success :');
                        GetList();
                    }
                },
                failure: function (response) {
                    toastr.error('', 'Error');
                }
            });
        }
        function Update() {
            debugger;
            if ($('#txtColorNameE').val() == '') {
                toastr.error('Color Name is Required', 'Error :');
                return;
            }
            if ($('#txtColorShortNameE').val() == '') {
                toastr.error('Color Short Name is Required', 'Error :');
                return;
            }
            var txtColorName = $('#txtColorNameE').val();
            var txtColorShortName = $('#txtColorShortNameE').val();
            var UserID = $('#<%=hdUser.ClientID%>').val();
            var ColorID = $('#<%=hdID.ClientID%>').val();
            var Object = { ColorID: ColorID, ColorName: txtColorName, ColorShortName: txtColorShortName, LastUpdatedBy: UserID };
            $.ajax({
                type: "POST",
                url: "frmProductColor.aspx/Update",
                data: JSON.stringify({ 'Obj': Object }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data) {
                        toastr.success('Data Saved Successfully', 'Success :');
                        GetList();
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
                url: "frmProductColor.aspx/GetListByStoreID",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function (data) {
                    console.log(data);
                    var tbl = "<div><table class='table table-bordered table-condensed table-hover'><thead><th>شمیره</th><th>د توکي رنګ</th><th>د توکي رنګ مخفف</th><th>نیټه</th><th> </th></thead><tbody>";
                    $.each(data.d, function (i, x) {
                        tbl += "<tr>";
                        tbl += "<td>" + x.ColorID + "</td>";
                        tbl += "<td>" + x.ColorName + "</td>";
                        tbl += "<td>" + x.ColorShortName + "</td>";
                        tbl += "<td>" + x.SystemDate + "</td>";
                        tbl += "<td valign='top'><span id='ID' style='display:none'>" + x.ColorID + "</span><span class='btn btn-success' onclick='showEditModal(this)'>&nbsp;<i class='glyphicon glyphicon-pencil'></i></span></td>";
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
            var StoreID = $(ref).parent('td').find('#ID').html();
            var Object = { ColorID: StoreID };
            $.ajax({
                type: "post",
                dataType: "JSON",
                contentType: "application/json; charset=utf-8",
                url: 'frmProductColor.aspx/EditData',
                data: JSON.stringify({ 'Obj': Object }),
                success: function (data) {
                    $('#<%=hdID.ClientID%>').val(data.d[0].ColorID);
                    $('#txtColorNameE').val(data.d[0].ColorName);
                    $('#txtColorShortNameE').val(data.d[0].ColorShortName);
                },
                failure: function (data) {
                    alert('error occured');
                }
            });
            $('#EditDialog').modal('show');
            }
    </script>
</asp:Content>
