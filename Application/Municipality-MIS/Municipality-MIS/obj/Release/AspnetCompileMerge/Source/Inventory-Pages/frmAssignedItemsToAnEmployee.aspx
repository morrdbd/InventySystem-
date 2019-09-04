<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Inventory.Master" AutoEventWireup="true" CodeBehind="frmAssignedItemsToAnEmployee.aspx.cs" Inherits="Municipality_MIS.Inventory_Pages.frmAssignedItemsToAnEmployee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../Content/bootstrap-datepicker.min.css" rel="stylesheet" />
    <link href="../Content/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <script src="../Scripts/select2.js"></script>
    <link href="../Content/select2.css" rel="stylesheet" />
    <link href="../Content/toastr.min.css" rel="stylesheet" />
    <script src="../Scripts/toastr.min.js"></script>
    <link href="../Content/select2-bootstrap.css" rel="stylesheet" />
    <script>
        $(function () {
            $('#txtDate').datepicker({
                isRTL: true, changeMonth: true, changeYear: true, showOtherMonths: true,
                selectOtherMonths: true
            });
            $('#txtRequestDate').datepicker({
                isRTL: true, changeMonth: true, changeYear: true, showOtherMonths: true,
                selectOtherMonths: true
            });
        });
        $(function () {

            $('#<%=ddlProductUsageType.ClientID%>').change(function () {
                GetProducts();
            });

            $('#ddlProduct').select2({ placeholder: "Product", theme: "classic" });
            $('#ddlProduct').val('0');
            $('#ddlProduct').trigger('change');
            $('#ddlProduct').change(function () {
                GetProductDetail();
            });
        });
    </script>
    <script>
        $(document).ready(function () {
            debugger;
            $('#btnSearch').click(function () {
                var ID = $('#txtEmpID').val();
                GetEmployee(ID);
            });
        });
    </script>
    <div class="row">
        <div class="col-lg-12 ">
            <div class="panel panel-primary">
                <div class="panel-heading bg-warning"><span style="color: white">د کارمند پلټنه</span></div>
                <div class="panel-body">
                    <div class="row">
                        <div class="form-group">
                            <div class="col-sm-2">
                                <label class="control-label" for="email">پلټنه په شمیره</label>
                            </div>
                            <div class="col-sm-4">
                                <input type="text" id="txtEmpID" name="txtProduct_Code" placeholder="Employee ID For Search" class="form-control" />
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
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab1" data-toggle="tab">عمومی معلومات</a></li>
                        <li><a href="#tab2" data-toggle="tab">اجناس ورکول</a></li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane fade in active" id="tab1">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="form-group col-md-4 col-sm-4">
                                        <label for="name">مکمل نوم/اسم مکمل</label>
                                        <input type="text" id="txtName_Local" name="txtProduct_BarCode" placeholder="مکمل نوم/اسم مکمل" class="form-control" disabled />
                                        <asp:HiddenField ID="hdMainID" runat="server" />
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
                                <div class="row">
                                    <div class="form-group col-md-4 col-sm-4">
                                        <label for="name">نمبر تکت</label>
                                        <input type="text" id="txtTikitNo" name="txtProduct_BarCode" placeholder="نمبر تکت" class="form-control" />
                                    </div>
                                    <div class="form-group col-md-4 col-sm-4">
                                        <label for="name">تاریخ</label>
                                        <input type="text" id="txtDate" name="txtProduct_BarCode" placeholder="تاریخ" class="form-control" />
                                    </div>
                                    <div class="form-group col-md-4 col-sm-4">
                                        <label for="name">تحویلخانه توزیع کننده</label>
                                        <input type="text" id="txtDistributionUnit" name="txtProduct_BarCode" placeholder="تحویلخانه توزیع کننده" class="form-control" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group col-md-4 col-sm-4">
                                        <label for="name">نمبر درخواست</label>
                                        <input type="text" id="txtRequetNumber" name="txtProduct_BarCode" placeholder="نمبر درخواست" class="form-control" />
                                    </div>
                                    <div class="form-group col-md-4 col-sm-4">
                                        <label for="name">تاریخ درخواست </label>
                                        <input type="text" id="txtRequestDate" name="txtProduct_BarCode" placeholder="تاریخ درخواست" class="form-control" />
                                    </div>
                                    <div class="form-group col-md-4 col-sm-4">
                                        <label for="name">شبعه درخواست کننده</label>
                                        <input type="text" id="txtRequestDepartment" name="txtProduct_BarCode" placeholder="شبعه درخواست کننده" class="form-control" />
                                    </div>
                                </div>


                            </div>
                        </div>
                        <div class="tab-pane fade" id="tab2">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="form-inline">
                                        <div class="form-group">
                                            <asp:DropDownList ID="ddlProductUsageType" CssClass="form-control" Width="150px" runat="server" OnDataBound="ddlProductUsageType_DataBound"></asp:DropDownList>
                                            <select id="ddlProduct" name="ddlProduct" style="width: 200px" class="form-control"></select>
                                            <input type="text" id="GroupName" style="width: 150px" class="form-control" placeholder="د جنس اصل" disabled />
                                            <input type="text" id="ProductOriginName" style="width: 150px" class="form-control" placeholder="د توکي سوداګریز" disabled />
                                              <input type="text" id="txtSNO" style="width:100px" class="form-control" placeholder="سریل نمبر" />
                                            <input type="number" id="txtPurchasePrice" style="width:80px" class="form-control" placeholder="خریداری نرخ" />
                                            <input type="number" id="txtQuantity" style="width: 130px" class="form-control" placeholder="مقدار" />
                                           
                                            <asp:HiddenField ID="hdProductCode" runat="server" />
                                            <a href="#" class="btn btn-primary btn-xs" onclick="AddProduct();"><span class="glyphicon glyphicon-plus-sign" style="font-size: 1.5em"></span></a>
                                        </div>
                                    </div>
                                </div>
                                <hr />
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="table-responsive">
                                            <table class="table table-bordered table-condensed" id="tblorder">
                                                <thead>
                                                    <tr>
                                                        <th>دجنس کوډ
                                                        </th>
                                                        <th>د جنس نوم
                                                        </th>
                                                        <th>د توکي ګروپ 
                                                        </th>
                                                        <th>د توکي سوداګریز
                                                        </th>
                                                          <th>سریل نمبر
                                                        </th>
                                                        <th>مقدار
                                                        </th>
                                                        <th>د خریداری قیمت
                                                        </th>
                                                        <th>ټول ټال
                                                        </th>
                                                        <th>پاک يي کړي
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                </tbody>
                                                <tfoot>
                                                    <tr>
                                                        <td colspan="6" rowspan="2">
                                                          
                                                        </td>
                                                        <td>
                                                            <span class="input-group-addon bg-teal">مجلل ټول ټال</span>
                                                        </td>
                                                        <td colspan="3">
                                                            <label id="lblgdTotal">0</label>
                                                        </td>
                                                    </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <hr />
                    <div class="row">
                        <div class="form-group">
                            <div class="col-sm-4">
                                <button type="button" id="Button1" onclick="SaveOrder()" class="btn btn-success">Save</button>
                                <button type="button" id="Button2" onclick="popupCenter('frmPC5.aspx?ID=' + $('#<%=hdMainID.ClientID%>').val(), 'print', 800, 700);"  class="btn btn-primary">Print </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
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
                                <label id="lblSearchByName" class="control-label" for="email">Search By Name:</label>
                            </div>
                            <div class="col-sm-6">
                                <input type="text" id="txtSearchByName" name="txtSearchByName" placeholder="Search By Name" class="form-control" />
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
    <script type="text/javascript">

        function GetAdvanceSearchByName() {
            var Name = $('#txtSearchByName').val();
            debugger;
            var objSO = {
                Name: Name
            };
            $.ajax({
                type: "POST",
                url: "frmAssignedItemsToAnEmployee.aspx/EmpAdvanceSearchByName",
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
            var employeeid = EmployeeID;
            $.ajax({
                type: "post",
                dataType: "JSON",
                contentType: "application/json; charset=utf-8",
                url: 'frmAssignedItemsToAnEmployee.aspx/GetEmployeeInfo',
                data: "{EmpID:'" + employeeid + "'}",
                success: function (data) {
                    $('#<%=hdEmployeeID.ClientID%>').val(data.d[0].Employee_ID);
                    $('#txtName_Local').val(data.d[0].Name);
                    $('#txtFather_Name_Local').val(data.d[0].Father_Name);
                    $('#txtGrand_Father_Name_Local').val(data.d[0].Grand_Father_Name);
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
                    url: 'frmAssignedItemsToAnEmployee.aspx/GetEmployeeInfo',
                    data: "{EmpID:'" + employeeid + "'}",
                    success: function (data) {
                        $('#<%=hdEmployeeID.ClientID%>').val(data.d[0].Employee_ID);
                        $('#txtName_Local').val(data.d[0].Name);
                        $('#txtFather_Name_Local').val(data.d[0].Father_Name);
                        $('#txtGrand_Father_Name_Local').val(data.d[0].Grand_Father_Name);
                    },
                    failure: function (data) {
                        alert('error occured');
                    }
                });

                //$('#divAdvanceSearch').modal('hide');
                }
    </script>
    <script type="text/javascript">
        function GetProducts() {
            debugger;
            var ProductUsageTypeID = $('#<%=ddlProductUsageType.ClientID%>').val();
            if (ProductUsageTypeID == "--د کارېدنه نوعه--") {
                toastr.error("د توکو د کارېدنه نوعه انتخاب کړي", "Error");
                return;
            }
            $.ajax({
                type: "post",
                dataType: "JSON",
                contentType: "application/json; charset=utf-8",
                url: 'frmAssignedItemsToAnEmployee.aspx/GetProducts',
                data: "{ProductUsageTypeID:'" + ProductUsageTypeID + "'}",
                success: function (data) {
                    console.log(data);
                    $('#ddlProduct').empty();
                    $.each(data.d, function (i, x) {
                        $('#ddlProduct').append($("<option></option>").val(x.ProductCode).html(x.ProductName));
                    });
                    $('#ddlProduct').focus();
                },
                failure: function (data) {
                    alert('error occured');
                }
            });
        }

        function AddProduct() {
            debugger;
            if (isProductExists()) {
                toastr.error("توکی موجود دی په لیست کی", "Error");
                return;
            }
            var productcode = $('#ddlProduct').val();
            var productname = $('#ddlProduct').select2('data')[0]['text'];
            var priceperunit = parseFloat($('#txtPurchasePrice').val());
            var quantity = parseFloat($('#txtQuantity').val());
            var GroupName = $('#GroupName').val();
            var ProductOriginName = $('#ProductOriginName').val();
            var SNO = $('#txtSNO').val();

            if ($('#txtQuantity').val() == "") {
                toastr.error('مقدار ضروری دی', 'Error :');
                $('#txtQuantity').focus();
                return;
            }
            if ($('#txtPurchasePrice').val() == "") {
                toastr.error('خریداری نرخ ضروری دی', 'Error :');
                $('#txtPurchasePrice').focus();
                return;
            }
            var total = parseFloat(priceperunit) * parseFloat(quantity);
            var GrandTotal = 0
            var soid = $('#txtOrderNo').html();
            $('#txtPurchasePrice').val('');
            $('#txtQuantity').val('');
            $('#GroupName').val('');
            $('#ProductOriginName').val('');
            $('#txtSNO').val('');
            GrandTotal = parseFloat($('#lblgdTotal').html());
            GrandTotal = parseFloat(total) + GrandTotal;
            var tr = "<tr><td><span id='procode'>" + productcode + "</span><span id='soid' style='display:none'>" + soid + "</span></td>";
            tr += "<td>" + productname + "</td>";
            tr += "<td>" + GroupName + "</td>";
            tr += "<td>" + ProductOriginName + "</td>";
            tr += "<td><span id='SNO'>" + SNO + "</span></td>";
            tr += "<td><span id='qty'>" + quantity + "</span></td>";
            tr += "<td><span id='ppu'>" + priceperunit + "</span></td>";
            tr += " <td><span id='totalprice'>" + total + "</span></td>";
            tr += "<td><a href='#' class='btn btn-danger btn-xs' onclick='RemoveProduct(this);' ><i class='glyphicon glyphicon-remove' style='font-size:1.2em;'></a></td></tr>";
            $('#tblorder').append(tr);
            $('#lblgdTotal').html(GrandTotal);
            toastr.success('Product added successfully', 'Success :');

        }
        function RemoveProduct(ref) {
            var tr = $(ref).parent('td').parent('tr');
            var totalprice = parseFloat($(tr).find('#totalprice').html());
            var GrandTotal = 0;
            GrandTotal = parseFloat($('#lblgdTotal').html());
            GrandTotal = GrandTotal - totalprice;
            $(tr).fadeOut(700);
            $('#lblgdTotal').html(GrandTotal);
            toastr.warning('Product Removed successfull', 'Warning :');
            CalculateBalance($('#txtPaidAmount'));
        }
        function isProductExists() {
            debugger;
            var productcode = $('#ddlProduct').val();
            var added = false;
            $('#tblorder tbody tr').each(function () {
                var code = $(this).find('#procode').html();
                if (productcode == code)
                    added = true;
            });
            return added;
        }
        function GetProductDetail() {
            debugger;
            var ProductCode = $('#ddlProduct').val();
            $.ajax({
                type: "post",
                dataType: "JSON",
                contentType: "application/json; charset=utf-8",
                url: 'frmAssignedItemsToAnEmployee.aspx/GetProductDetail',
                data: "{ProductCode:'" + ProductCode + "'}",
                success: function (data) {

                    $('#GroupName').val(data.d[0].GroupName);
                    $('#ProductOriginName').val(data.d[0].ProductOriginName);
                    $('#<%=hdProductCode.ClientID%>').val(data.d[0].ProductCode);
                    $('#txtPurchasePrice').val(data.d[0].AveragePrice);
                    $('#txtSNO').focus();
                },
                failure: function (data) {
                    alert('error occured');
                }
            });
        }

        //--------------------Save Data---------
        function SaveOrder() {
            debugger;
            var UserID = $('#<%=hdUser.ClientID%>').val();
            var EmpID = $('#<%=hdEmployeeID.ClientID%>').val();
            var txtTikitNo = $('#txtTikitNo').val();
            var txtDate = $('#txtDate').val();
            var txtDistributionUnit = $('#txtDistributionUnit').val();
            var txtRequetNumber = $('#txtRequetNumber').val();
            var txtRequestDate = $('#txtRequestDate').val();
            var txtRequestDepartment = $('#txtRequestDepartment').val();
            if ($('#tblorder tbody tr').length <= 0) {
                toastr.error('Please Add Products!', "Error");
                return;
            }
            var objSO = {
                EmpID:EmpID, RequestNumber:txtRequetNumber, RequestByDepartment:txtRequestDepartment, RequestDate:txtRequestDate, TicketNumber:txtTikitNo, AssgineDepartment:txtDistributionUnit, SystemDate:txtDate, UserID:UserID
            };
            var objSOD = [];
            $('#tblorder tbody tr').each(function () {
                var procode = $(this).find('#procode').html();
                var ppu = $(this).find('#ppu').html();
                var qty = $(this).find('#qty').html();
                var totalprice = $(this).find('#totalprice').html();
                var SNO = $(this).find('#SNO').html();
                debugger;
                var SOD = {
                    ProductCode:procode, SerialNumber:SNO, Quantity:qty, AveragePrice:ppu, Total:totalprice
                };
                objSOD.push(SOD);
               $(this).fadeOut(700);
            });
            $.ajax({
                type: "POST",
                url: "frmAssignedItemsToAnEmployee.aspx/InsertPurchaseOrder",
                data: JSON.stringify({ 'Main': objSO, 'Detail': objSOD }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#<%=hdMainID.ClientID%>').val(data.d)
                    toastr.success('Saved successfully', 'Success :');
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }

        function popupCenter(url, title, w, h) {
            var left = (screen.width / 2) - (w / 2);
            var top = (screen.height / 2) - (h / 2);
            return window.open(url, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
        }
    </script>
</asp:Content>
