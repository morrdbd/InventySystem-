<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Inventory.Master" AutoEventWireup="true" CodeBehind="frmAssetsListOfEmployee.aspx.cs" Inherits="Municipality_MIS.Inventory_Pages.frmAssetsListOfEmployee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

   <link href="../Content/toastr.min.css" rel="stylesheet" />
    <script src="../Scripts/toastr.min.js"></script>


    <div class="row">
        <div class="col-lg-12 ">
            <div class="panel panel-primary">
                <div class="panel-heading bg-warning"><span style="color: white">د کارمند پلټنه</span></div>
                <div class="panel-body">
                    <div class="row">
                        <div class="form-group">
                            <div class="col-sm-2">
                                <label class="control-label" for="email">پلټنه د کارمند په شمیره</label>
                            </div>
                            <div class="col-sm-4">
                                <input type="text" id="txtEmpID" name="txtProduct_Code" placeholder="شمیره" class="form-control" />
                            </div>
                            <div class="col-sm-4">
                                <button type="button" id="btnSearch" class="btn btn-success">پلټنه</button>
                                <button type="button" id="btnAdvanceSearch" data-toggle="modal" data-target="#divAdvanceSearch" class="btn btn-primary">پلټنه په نوم</button>
                                <asp:HiddenField ID="hdEmployeeID" runat="server"></asp:HiddenField>
                                <asp:HiddenField ID="hdUser" runat="server" />
                            </div>
                        </div>
                    </div>
                    <hr />
                    <div class="panel-body">
                        <div class="row">
                            <div class="form-group col-md-4 col-sm-4">
                                <label for="name">مکمل نوم/اسم مکمل</label>
                                <input type="text" id="txtName_Local" name="txtProduct_BarCode" placeholder="مکمل نوم/اسم مکمل" class="form-control" disabled />
                            </div>
                            <div class="form-group col-md-4 col-sm-4">
                                <label for="name">پلار نوم/نام پدر</label>
                                <input type="text" id="txtFather_Name_Local" name="txtProduct_BarCode" placeholder="پلار نوم/نام پدر" class="form-control" disabled />
                            </div>
                            <div class="form-group col-md-4 col-sm-4">
                                <label for="name">نیکه نوم/نام پدر کلان</label>
                                <input type="text" id="txtGrand_Father_Name_Local" name="txtProduct_BarCode" placeholder="نیکه نوم/نام پدر کلان" class="form-control" disabled />
                            </div>
                        </div>
                        <hr />
                        <div id="ProductList" class="row">
                        </div>
                        <div class="row">
                            <div class="col-sm-4">
                                <button type="button" id="Button4" data-toggle="modal" data-target="" class="btn btn-primary">Print </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="divAdvanceSearch" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Advance Search</h4>
                </div>
                <div class="modal-body">
                    <div id="DivSearchByName">
                        <div class="row">
                            <div class="col-sm-2">
                                <label id="lblSearchByName" class="control-label" for="email">پلټنه په نوم</label>
                            </div>
                            <div class="col-sm-6">
                                <input type="text" id="txtSearchByName" name="txtSearchByName" placeholder="نوم/اسم" class="form-control" />
                            </div>
                            <div class="col-sm-4">
                                <button type="button" id="btnSearchByName" onclick="GetAdvanceSearchByName()" class="btn btn-success">Search</button>
                            </div>
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="table-responsive" id="divAdvanceSearchList">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" onclick="" data-dismiss="modal">Ok</button>
                    <button type="button" class="btn btn-danger" onclick="" data-dismiss="modal">Cancel</button>

                </div>
            </div>
        </div>
    </div>

    <div id="AssetReturnModal" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">توکي بیرته اخستل</h4>
                </div>
                <div class="modal-body">
                    <div id="Div2">
                        <div class="row">
                            <div class="form-group col-md-6 col-sm-6">
                                <label for="name">توکي</label>
                                <input type="text" id="txtProductName" name="txtProduct_BarCode" placeholder="توکي" class="form-control" disabled />
                                <asp:HiddenField ID="hdID" runat="server" />
                                <asp:HiddenField ID="hdProductCode" runat="server" />
                            </div>
                            <div class="form-group col-md-6 col-sm-6">
                                <label for="name">مقدار</label>
                                <input type="text" id="txtQuantity" name="txtProduct_BarCode" placeholder="پلار نوم/نام پدر" class="form-control" disabled />
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-6 col-sm-6">
                                <label for="name">ملاحضات</label>
                                <input type="text" id="txtReturnRemarks" name="txtProduct_BarCode" placeholder="نیکه نوم/نام پدر کلان" class="form-control" />
                            </div>
                            <div class="col-sm-4">
                                <br />
                                <button type="button" id="btnReturn" onclick="ReturnAsset();" class="btn btn-success">Return</button>
                            </div>
                        </div>
                    </div>
                    <br />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" onclick="" data-dismiss="modal">Ok</button>
                    <button type="button" class="btn btn-danger" onclick="" data-dismiss="modal">Cancel</button>

                </div>
            </div>
        </div>
    </div>


    <script>
        $(document).ready(function () {
            debugger;
            $('#btnSearch').click(function () {
                var ID = $('#txtEmpID').val();
                GetEmployee(ID);
            });
        });
    </script>
    <script type="text/javascript">
        function GetAdvanceSearchByName() {
            var Name = $('#txtSearchByName').val();
            debugger;
            var objSO = {
                Name: Name
            };
            $.ajax({
                type: "POST",
                url: "frmAssetsListOfEmployee.aspx/EmpAdvanceSearchByName",
                data: JSON.stringify({ 'Employee': objSO }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (data) {
                    console.log(data);
                    var tbl = "<div><table class='table table-bordered table-hover'><thead class='thead thead-default' ><th>Emp No</th><th>Name</th><th>Father Name</th><th>Gender</th><td>Mobile Number</td><td>Education Grade</td><td>Main Course of Study</td><td>Specialization</td><td>Present Address</td><th></th></thead><tbody>";
                    $.each(data.d, function (i, x) {
                        tbl += "<tr class='table table-warning'>";
                        tbl += "<td>" + x.Employee_ID + "</td>";
                        tbl += "<td>" + x.Name + "</td>";
                        tbl += "<td>" + x.Father_Name + "</td>";
                        tbl += "<td>" + x.Gender + "</td>";
                        tbl += "<td>" + x.Personal_Mobile_Number + "</td>";
                        tbl += "<td>" + x.E_Grade_Name + "</td>";
                        tbl += "<td>" + x.Main_Course_of_Study + "</td>";
                        tbl += "<td>" + x.Specialization + "</td>";
                        tbl += "<td>" + x.Present_Province_Name + "," + x.Present_District_Name + "," + x.Present_Village + "</td>";
                        tbl += "<td valign='top'><span id='empid' style='display:none'>" + x.Employee_ID + "</span><button type='button' class='btn btn-sm btn-success' onclick='GetEmployeeByRef(this)' data-dismiss='modal'>&nbsp;<i class='glyphicon glyphicon-pencil'></i></button></td>";
                        tbl += "</tr>";
                    });
                    tbl += "</tbody></table></div>";
                    $('#divAdvanceSearchList').html(tbl);
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }
        function GetEmployee(EmployeeID) {
            debugger;

            $.ajax({
                type: "post",
                dataType: "JSON",
                contentType: "application/json; charset=utf-8",
                url: 'frmAssetsListOfEmployee.aspx/GetEmployeeInfo',
                data: "{EmpID:'" + EmployeeID + "'}",
                success: function (data) {
                    $('#<%=hdEmployeeID.ClientID%>').val(data.d[0].Employee_ID);
                    $('#txtName_Local').val(data.d[0].Name);
                    $('#txtFather_Name_Local').val(data.d[0].Father_Name);
                    $('#txtGrand_Father_Name_Local').val(data.d[0].Grand_Father_Name);
                    GetProductList(EmployeeID);

                },
                failure: function (data) {
                    alert('error occured');
                }
            });
            }
            function GetEmployeeByRef(ref) {
                debugger;
                var employeeid = $(ref).parent('td').find('#empid').html();
                $.ajax({
                    type: "post",
                    dataType: "JSON",
                    contentType: "application/json; charset=utf-8",
                    url: 'frmAssetsListOfEmployee.aspx/GetEmployeeInfo',
                    data: "{EmpID:'" + employeeid + "'}",
                    success: function (data) {
                        $('#<%=hdEmployeeID.ClientID%>').val(data.d[0].Employee_ID);
                        $('#txtName_Local').val(data.d[0].Name);
                        $('#txtFather_Name_Local').val(data.d[0].Father_Name);
                        $('#txtGrand_Father_Name_Local').val(data.d[0].Grand_Father_Name);
                        GetProductList(employeeid);
                    },
                    failure: function (data) {
                        alert('error occured');
                    }
                });
                }
                function GetProductList(EmpID) {
                    debugger;
                    var SearchValue = EmpID;
                    $.ajax({
                        type: "POST",
                        url: "frmAssetsListOfEmployee.aspx/AssetsListOfEmployee",
                        data: "{EmpID:'" + SearchValue + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        cache: false,
                        success: function (data) {
                            console.log(data);
                            var tbl = "<div><table class='table table-bordered table-hover'><thead class='thead thead-default' ><th>د توکي شمیره</th><th>د توکي نوم</th><th>سریال نمبر</th><th>د توکي مقدار</th><th>قیمت</th><th>مجموعه</th><th></th></thead><tbody>";
                            $.each(data.d, function (i, x) {
                                tbl += "<tr class='table table-warning'>";
                                tbl += "<td>" + x.ProductCode + "</td>";
                                tbl += "<td>" + x.ProductName + "</td>";
                                tbl += "<td>" + x.SerialNumber + "</td>";
                                tbl += "<td>" + x.Quantity + "</td>";
                                tbl += "<td>" + x.AveragePrice + "</td>";
                                tbl += "<td>" + x.Total + "</td>";
                                tbl += "<td valign='top'><span id='ID' style='display:none'>" + x.ID + "</span><span class='btn btn-success' onclick='ShowReturnWindow(this)'>&nbsp;<i class='ti-pencil-alt'></i></span>";
                                tbl += "</tr>";
                            });
                            tbl += "</tbody></table></div>";
                            $('#ProductList').html(tbl);
                        },
                        failure: function (response) {
                            alert(response.d);
                        }
                    });
                }
                function ShowReturnWindow(ref) {
                    debugger;
                    var ID = $(ref).parent('td').find('#ID').html();
                    $.ajax({
                        type: "post",
                        dataType: "JSON",
                        async: false,
                        contentType: "application/json; charset=utf-8",
                        url: 'frmAssetsListOfEmployee.aspx/AssetEdit',
                        data: "{ID:'" + ID + "'}",
                        success: function (data) {
                            $('#<%=hdID.ClientID%>').val(data.d[0].ID);
                            $('#<%=hdProductCode.ClientID%>').val(data.d[0].ProductCode);
                            $('#txtProductName').val(data.d[0].ProductName);
                            $('#txtQuantity').val(data.d[0].Quantity);
                            $('#txtReturnRemarks').val('');
                        },
                        failure: function (data) {
                            alert('error occured');
                        }
                    });
                        $('#AssetReturnModal').modal('show');
                    }


                    //Return Asset

        function ReturnAsset() {

            var txtQuantity = $('#txtQuantity').val();
            var txtReturnRemarks = $('#txtReturnRemarks').val();
            var UserID = $('#<%=hdUser.ClientID%>').val();
            var hdID = $('#<%=hdID.ClientID%>').val();
            var hdProductCode = $('#<%=hdProductCode.ClientID%>').val();
            if ($('#txtReturnRemarks').val() == '') {
                toastr.error('Remarks are Required', 'Error :');
                $('#txtReturnRemarks').focus();
                return;
            }
            var ProductObj = {
                ID: hdID,
                ReturnBy: UserID, ReturnRemarks: txtReturnRemarks, ProductCode: hdProductCode, Quantity: txtQuantity
            };
            $.ajax({
                type: "POST",
                url: "frmAssetsListOfEmployee.aspx/ReturnAsset",
                data: JSON.stringify({ 'Asset': ProductObj }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data) {
                      
                        toastr.success('Product Returned Successfully..', 'Success :');
                        GetProductList($('#<%=hdEmployeeID.ClientID%>').val());
                        $('#AssetReturnModal').modal('hide');
                    }
                },
                failure: function (response) {
                    toastr.error('', 'Error');
                }
            });
        }
    </script>
</asp:Content>
