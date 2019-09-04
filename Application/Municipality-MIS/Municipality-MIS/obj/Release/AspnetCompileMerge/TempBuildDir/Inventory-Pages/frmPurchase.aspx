<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Inventory.Master" AutoEventWireup="true" CodeBehind="frmPurchase.aspx.cs" Inherits="Municipality_MIS.Inventory_Pages.frmPurchase" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <link href="../Content/bootstrap-datepicker.min.css" rel="stylesheet" />
    <link href="../Content/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <link href="../Content/toastr.min.css" rel="stylesheet" />
    <link href="../Content/select2.css" rel="stylesheet" />
    <link href="../Content/select2-bootstrap.css" rel="stylesheet" />
    <script>


        $(function () {
            $('#txtReceivedDate').datepicker({
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



            //$('#ddlProduct').change(function () {
            //    // alert('Hi it is called');
            //    GetProductUnit();
            //});
            //$('#ddlProduct').change(function () {

            //    $('#txtPurchasePrice').focus();
            //});
            //$('#txtPaidAmount').change(function () {
            //    CalculateBalance($(this));
            //});
        });
    </script>
    
            <div class="panel panel-primary">
                <div class="panel-heading blue-bg"><span style="color: white">د توکو د ثبتولو فورمه</span></div>
                <div class="panel-body">
                    <asp:HiddenField ID="hdUser" runat="server" />
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="row">
                                <div class="col-lg-3">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span class="input-group-addon bg-teal">دحکم ګڼه</span>
                                            <input type="text" id="txtOrderNumber" name="txtOrderNo" placeholder="Order No" class="form-control" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span class="input-group-addon bg-teal">واريده نيټه</span>
                                            <input type="text" id="txtReceivedDate" name="txtReceivedDate" placeholder="Order Received Date" class="form-control" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span class="input-group-addon bg-teal">م-۷ شمیره</span>
                                            <input type="text" id="txtM7Number" name="txtInvoiceNo" placeholder="Invoice No" class="form-control" />
                                        </div>
                                    </div>
                                </div>
                             
                                  <div class="col-lg-3">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span class="input-group-addon bg-teal">د حکم عکس</span>
                                             <input type="file" class="upload" name="ProductImage" id="fuScanCopy" style="width: 150px" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                 
                    <hr />
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-inline">
                                <div class="form-group">
                                    <asp:DropDownList ID="ddlProductUsageType" CssClass="form-control" Width="150px" runat="server" OnDataBound="ddlProductUsageType_DataBound"></asp:DropDownList>
                                    <select id="ddlProduct" name="ddlProduct" style="width: 300px" class="form-control"></select>
                                      <input type="text" id="GroupName" style="width: 150px" class="form-control" placeholder="د جنس اصل" disabled />
                                      <input type="text" id="ProductOriginName" style="width: 150px" class="form-control" placeholder="د توکي سوداګریز" disabled />
                                    <input type="number" id="txtPurchasePrice" style="width: 130px" class="form-control" placeholder="خریداری نرخ"  />
                                    <input type="number" id="txtQuantity" style="width: 130px" class="form-control" placeholder="مقدار" />
                                    <asp:HiddenField ID="hdProductCode" runat="server" />
                                    <a href="#" class="btn btn-primary btn-xs" onclick="AddProduct();"><span class="glyphicon glyphicon-plus-sign" style="font-size: 1.5em"></span></a>
                                </div>
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
                                            <td colspan="5" rowspan="2">
                                                <input type="button" onclick="Clear();" class="btn btn-info btn-sm" value="New" id="btnNew" />
                                                <input type="button" class="btn btn-danger btn-sm" onclick="SaveOrder()" value="Save" id="btnSave" />
                                                <button type="button" onclick="showEditModal();" class="btn btn-primary">Print Order</button>
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
    <div id="empedit" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Print Purchase Order</h4>
                </div>
                <div class="modal-body">
                    <div class="form-horizontal">
                        <div class="form-horizontal">
                            <input type="hidden" id="hdBrandIDE" name="hdBrandIDE" />
                            <div class="form-group">
                                <label class="control-label col-md-4">
                                    Purchase Order Number
                                </label>
                                <div class="col-md-4">
                                    <input type="text" id="txtPurchaseOrderNoE" name="txtPurchaseOrderNoE" class="form-control" />
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <a class="btn btn-success" id="btnSearch" href="#" onclick="popupCenter('frmPrintPurchase.aspx?OrderNo=' + $('#txtPurchaseOrderNoE').val(), 'print', 800, 700);"><i class="glyphicon glyphicon-print"></i>Print</a>

                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function GetProducts() {
            debugger;


            var ProductUsageTypeID = $('#<%=ddlProductUsageType.ClientID%>').val();
            if (ProductUsageTypeID == "--د کارېدنه نوعه--")
            {
                toastr.error("د توکو د کارېدنه نوعه انتخاب کړي", "Error");
                return;
            }


            $.ajax({
                type: "post",
                dataType: "JSON",
                contentType: "application/json; charset=utf-8",
                url: 'frmPurchase.aspx/GetProducts',
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

            GrandTotal = parseFloat($('#lblgdTotal').html());
            GrandTotal = parseFloat(total) + GrandTotal;
            var tr = "<tr><td><span id='procode'>" + productcode + "</span><span id='soid' style='display:none'>" + soid + "</span></td>";
            tr += "<td>" + productname + "</td>";
            tr += "<td>" + GroupName + "</td>";
            tr += "<td>" + ProductOriginName + "</td>";
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
        function SaveOrder() {
            debugger;
            var UserID = $('#<%=hdUser.ClientID%>').val();
            var ReceivedDate = $('#txtReceivedDate').val();
            var txtOrderNumber = $('#txtOrderNumber').val();
            var txtM7Number = $('#txtM7Number').val();
            var filename = $('#fuScanCopy').val();
            var grandtotalAmount = parseFloat($('#lblgdTotal').html());
            if (ReceivedDate == '') {
                toastr.error('Please provide all information', "Error");
                return;
            }
            if ($('#tblorder tbody tr').length <= 0) {
                toastr.error('Please Add Products!', "Error");
                return;
            }
            var objSO = {
                OrderNumber: txtOrderNumber, M7Number: txtM7Number, Date: ReceivedDate, ScanPath: filename, GrandTotal: grandtotalAmount, User_ID: UserID
            };
            var objSOD = [];
            $('#tblorder tbody tr').each(function () {
                var procode = $(this).find('#procode').html();
                var ppu = $(this).find('#ppu').html();
                var qty = $(this).find('#qty').html();
                var totalprice = $(this).find('#totalprice').html();
                debugger;
                var SOD = {
                     ProductCode: procode, Quantity: qty, Price: ppu, Total: totalprice
                };
                objSOD.push(SOD);
                $(this).fadeOut(700);
            });
            $.ajax({
                type: "POST",
                url: "frmPurchase.aspx/InsertPurchaseOrder",
                data: JSON.stringify({ 'PurchaseOrder_Save': objSO, 'PurchaseOrderDetail_Save': objSOD }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    sendFile(data.d);
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

        function showEditModal() {

            $('#empedit').modal('show');
        }

        function GetProductDetail() {
            debugger;
            var ProductCode = $('#ddlProduct').val();
            $.ajax({
                type: "post",
                dataType: "JSON",
                contentType: "application/json; charset=utf-8",
                url: 'frmPurchase.aspx/GetProductDetail',
                data: "{ProductCode:'" + ProductCode + "'}",
                success: function (data) {
                  
                    $('#GroupName').val(data.d[0].GroupName);
                    $('#ProductOriginName').val(data.d[0].ProductOriginName);
                    $('#<%=hdProductCode.ClientID%>').val(data.d[0].ProductCode);
                    $('#txtPurchasePrice').focus();
                },
                failure: function (data) {
                    alert('error occured');
                }
            });
        }

        function sendFile(EmployeeID) {
            debugger;
            var formData = new FormData();
            var file = $('#fuScanCopy').get(0).files[0];
            formData.append('file', file);
            formData.append('state', 'insert');
            formData.append('Main_ID', EmployeeID);
            $.ajax({
                type: 'post',
                url: 'PurchaseUploder.ashx',
                data: formData,
                async: true,
                success: function (status) {
                    if (status != 'error') {
                    }
                },
                processData: false,
                contentType: false,
                error: function () {
                    alert("Picture not saved");
                }
            });
        }
    </script>
</asp:Content>
