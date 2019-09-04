<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Inventory.Master" AutoEventWireup="true" CodeBehind="frmProductCategory.aspx.cs" Inherits="Inventory_Manager_ALKC.IMIS_Pages.frmProductCategory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

      <br />
    <div class="panel panel-success">
        <div class="panel-heading badge-success"><span style="color: white">د کټګوری د ثبتولو فورمه</span></div>
        <div class="panel-body">
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="form-group col-md-3 col-sm-3">
                        <label for="name">د توکي کټګورۍ</label>
                        <input type="text" id="txtCategoryName" name="txtOrigin_Name" placeholder="د توکي کټګورۍ" class="form-control" />
                        <asp:HiddenField ID="hdUser" runat="server" />
                        <asp:HiddenField ID="hdStoreID" runat="server" />
                    </div>
                     <div class="form-group col-md-3 col-sm-3">
                        <label for="name">د توکي ګروپ</label>
                         <asp:DropDownList ID="ddlProductGroup" CssClass="form-control" runat="server"></asp:DropDownList>
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
        <div class="panel-heading badge-primary"><span style="color: white">د توکی کټګوری لیس لړ</span></div>
        <div class="panel-body">
            <div class="row">
                <div class="col-lg-12 ">
                    <div class="form-inline">
                        <label for="name">پلټنه نوم په کټګوری</label>
                        <input type="text" id="txtSearch" name="txtOrigin_Name" placeholder="د توکي کټګورۍ" class="form-control" />
                        <button type="button" id="btnSerach" class="btn btn-primary">Search</button>
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
                    <h4 class="modal-title">د کټګوری تغیرول</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="form-group col-md-6 col-sm-6">
                            <label for="name">د کټګوری نوم</label>
                            <input type="text" id="txtCategoryNameE" name="txtOrigin_Name" placeholder="Category Name" class="form-control" />
                            <asp:HiddenField ID="hdID" runat="server" />
                        </div>
                          <div class="form-group col-md-6 col-sm-6">
                        <label for="name">د توکی ګروپ</label>
                         <asp:DropDownList ID="ddlProductGroupE" CssClass="form-control" runat="server"></asp:DropDownList>
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
            if ($('#txtCategoryName').val() == '') {
                toastr.error('د کټګوری نوم حتمی دی', 'Error :');
                $('#txtCategoryName').focus();
                return;
            }
            var txtCategoryName = $('#txtCategoryName').val();
            var ddlProductGroup = $('#<%=ddlProductGroup.ClientID%>').val();
            var UserID = $('#<%=hdUser.ClientID%>').val();
         
            var Object = { CategoryName: txtCategoryName, GroupID: ddlProductGroup, UserID: UserID };
            $.ajax({
                type: "POST",
                url: "frmProductCategory.aspx/Insert",
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
            if ($('#txtCategoryNameE').val() == '') {
                toastr.error('Category Name is Required', 'Error :');
                return;
            }
            var txtCategoryName = $('#txtCategoryNameE').val();
            var ddlProductGroup = $('#<%=ddlProductGroupE.ClientID%>').val();
            var UserID = $('#<%=hdUser.ClientID%>').val();
            var hdID = $('#<%=hdID.ClientID%>').val();
            var Object = { CategoryCode: hdID, CategoryName: txtCategoryName, GroupID: ddlProductGroup, LastUpdatedBy: UserID };
            $.ajax({
                type: "POST",
                url: "frmProductCategory.aspx/Update",
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
                url: "frmProductCategory.aspx/GetListByStoreID",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function (data) {
                    console.log(data);
                    var tbl = "<div><table class='table table-bordered table-condensed table-hover'><thead><th>شمیره</th><th>کټګوری</th><th>ګروپ</th><th>نيټه</th><th> </th></thead><tbody>";
                    $.each(data.d, function (i, x) {
                        tbl += "<tr>";
                        tbl += "<td>" + x.CategoryCode + "</td>";
                        tbl += "<td>" + x.CategoryName + "</td>";
                        tbl += "<td>" + x.GroupName + "</td>";
                        tbl += "<td>" + x.SystemDate + "</td>";
                        tbl += "<td valign='top'><span id='ID' style='display:none'>" + x.CategoryCode + "</span><span class='btn btn-success' onclick='showEditModal(this)'>&nbsp;<i class='glyphicon glyphicon-pencil'></i></span></td>";
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
            var GroupID = $(ref).parent('td').find('#ID').html();
            var Object = { CategoryCode: GroupID };
            $.ajax({
                type: "post",
                dataType: "JSON",
                contentType: "application/json; charset=utf-8",
                url: 'frmProductCategory.aspx/EditData',
                data: JSON.stringify({ 'Obj': Object }),
                success: function (data) {
                    $('#<%=hdID.ClientID%>').val(data.d[0].CategoryCode);
                    $('#<%=ddlProductGroupE.ClientID%>').val(data.d[0].GroupID);
                    $('#<%=ddlProductGroupE.ClientID%>').trigger('change');
                    $('#txtCategoryNameE').val(data.d[0].CategoryName);
                },
                failure: function (data) {
                    alert('error occured');
                }
            });
                $('#EditDialog').modal('show');
            }
    </script>
</asp:Content>
