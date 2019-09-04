<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Inventory.Master" AutoEventWireup="true" CodeBehind="frmProductList.aspx.cs" Inherits="Inventory_Manager_ALKC.IMIS_Pages.frmProductList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
       .modal-lg {
    max-width: 80% !important;
}
    </style>

    <div class="row">
        <div class="col-lg-12 ">
            <div class="panel panel-primary">
                <div class="panel-heading blue-bg"><span style="color: white">د توکو لیست لړ</span></div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-12 ">
                            <div class="row">
                                <div class="col-lg-12 ">
                                    <div class="form-inline">
                                        <label class="control-label">پلټنه د توکي په نوم</label>
                                        <input type="text" id="txtSearch" name="txtBrandDescription" placeholder="د توکي نوم ولیکیٌ" class="form-control" />
                                        <button type="button" onclick="GetProductListByName();" class="btn btn-success">وی پلټي</button>
                                        <asp:HiddenField ID="hdUser" runat="server" />
                                        <asp:HiddenField ID="hdStoreID" runat="server" />
                                    </div>
                                </div>
                            </div>
                            <hr />
                            <div class="row">
                                <div class="col-lg-12 ">
                                    <div class="table-responsive" id="ProductList">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="ShowImage" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Product Image</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-lg-2">
                        </div>
                        <div class="col-lg-6">
                            <img width="400" height="250" id="ImgProduct" src="" />
                        </div>
                        <div class="col-lg-2">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <asp:HiddenField ID="HiddenField1" runat="server" />
                </div>
            </div>
        </div>
    </div>
    <div id="ProductEdit" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">د توکو تعیرول</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-lg-9">
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span class="input-group-addon badge-primary">د توکو د کارېدنه نوعه</span>
                                            <asp:DropDownList ID="ddlProductUsageType" CssClass="form-control" runat="server">
                                            </asp:DropDownList>
                                            <asp:HiddenField ID="hdSO" runat="server" />
                                            <asp:HiddenField ID="hdPath" runat="server" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span class="input-group-addon badge-primary">د توکي د لیبل معلومات</span>
                                            <input type="text" id="txtProduct_BarCode" name="txtProduct_BarCode" placeholder="Product BarCode" class="form-control" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span class="input-group-addon badge-primary">د توکي نوم</span>
                                            <input type="text" id="txtProduct_Name" name="txtProduct_Name" placeholder="Product Name" class="form-control" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span class="input-group-addon badge-primary">د توکي اندازه</span>
                                            <asp:DropDownList ID="ddlSize" CssClass="form-control" runat="server"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span class="input-group-addon badge-primary">د توکي رنګ</span>
                                            <asp:DropDownList ID="ddlColor" CssClass="form-control" runat="server"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span class="input-group-addon badge-primary">د توکی د متحد ډول</span>
                                            <asp:DropDownList ID="ddlUnit" CssClass="form-control" runat="server"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span class="input-group-addon badge-primary">د توکي بسته بندي</span>
                                            <asp:DropDownList ID="ddlPacking" CssClass="form-control" runat="server"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span class="input-group-addon badge-primary">د توکي ګروپ</span>
                                            <asp:DropDownList ID="ddlProductGroup" CssClass="form-control" runat="server"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span class="input-group-addon badge-primary">د توکي کټګورۍ</span>
                                            <select id="ddlProductCategory" name="ddlProductCategory" class="form-control"></select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span class="input-group-addon badge-primary">د توکي اصلي</span>
                                            <asp:DropDownList ID="ddlProductOrigin" CssClass="form-control" runat="server"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span class="input-group-addon badge-primary">د توکي سوداګریز</span>
                                            <asp:DropDownList ID="ddlProductBrand" CssClass="form-control" runat="server"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span class="input-group-addon badge-primary">د توکي د ایښودلو ځای</span>
                                            <input type="text" id="txtLocation" name="txtSalePrice" placeholder="Location" class="form-control" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span class="input-group-addon badge-primary">د توکي تفصیل</span>
                                            <input type="text" id="txtProduct_Description" name="txtProduct_Description" placeholder="Product Description" class="form-control" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-2">
                            د توکي انځور
                            <div class="form-group">
                                <asp:Image ID="imgPhoto" Width="200" Height="200" runat="server" ImageUrl="~/Images/NoImage.jpg" />
                                <input type="file" class="upload" tabindex="6" name="ProductImage" id="ProductImage" style="width: 150px" /><br />
                                <asp:HiddenField ID="HiddenField2" runat="server" Value="1001" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <a class="btn btn-success" id="btnUpdate" onclick="Save();" href="#"><i class="glyphicon glyphicon-save"></i>&nbsp;Save</a>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>

                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            GetProductList();
        });

        $(function () {
            $('#ProductImage').change(function (e) {
                ShowImagePreview(this);
            });
        });

        $('#<%=ddlProductGroup.ClientID%>').change(function () {
            GetProductCategory($('#<%=ddlProductGroup.ClientID%>').val());
        });

        function GetProductList() {
            debugger;

            $.ajax({
                type: "POST",
                url: "frmProductList.aspx/GetProductList",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    console.log(data);
                    var tbl = "<div><table class='table table-bordered table-hover'><thead class='thead thead-default' ><th>د توکي شمیره</th><th>د توکي نوم</th><th>د توکو د کارېدنه نوعه</th><th>د توکي ګروپ</th><th>د توکي کټګورۍ</th><th>د توکي اصلي</th><th>د توکي سوداګریز</th><th>د توکي اندازه</th><th>د توکي رنګ</th><th></th></thead><tbody>";
                    $.each(data.d, function (i, x) {
                        tbl += "<tr class='table table-warning'>";
                        tbl += "<td>" + x.ProductCode + "</td>";
                        tbl += "<td>" + x.ProductName + "</td>";
                        tbl += "<td>" + x.UsageName + "</td>";
                        tbl += "<td>" + x.GroupName + "</td>";
                        tbl += "<td>" + x.CategoryName + "</td>";
                        tbl += "<td>" + x.ProductOriginName + "</td>";
                        tbl += "<td>" + x.BrandName + "</td>";
                        tbl += "<td>" + x.SizeName + "</td>";
                        tbl += "<td>" + x.ColorName + "</td>";
                        tbl += "<td valign='top'><span id='empid' style='display:none'>" + x.ProductCode + "</span><span class='btn btn-success' onclick='showEditModalProduct(this)'>&nbsp;<i class='glyphicon glyphicon-pencil'></i></span>";
                        tbl += "<span id='PhotoPath' style='display:none'>" + x.ProductImagePath + "</span><span class='btn btn-danger' onclick='ShowImage(this);'><i class='glyphicon glyphicon-eye-open' ></i></span></td>";
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
        function GetProductListByName() {
            debugger;
            var SearchValue = $('#txtSearch').val();

            $.ajax({
                type: "POST",
                url: "frmProductList.aspx/GetProductListByName",
                data: "{ProductName:'" + SearchValue + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    console.log(data);
                    var tbl = "<div><table class='table table-bordered table-hover'><thead class='thead thead-default' ><th>Product Code</th><th>Product Name</th><th>Group</th><th>Category</th><th>Origin</th><th>Brand</th><th>Size</th><th>Color</th><th></th></thead><tbody>";
                    $.each(data.d, function (i, x) {
                        tbl += "<tr class='table table-warning'>";
                        tbl += "<td>" + x.ProductCode + "</td>";
                        tbl += "<td>" + x.ProductName + "</td>";
                        tbl += "<td>" + x.GroupName + "</td>";
                        tbl += "<td>" + x.CategoryName + "</td>";
                        tbl += "<td>" + x.ProductOriginName + "</td>";
                        tbl += "<td>" + x.BrandName + "</td>";
                        tbl += "<td>" + x.SizeName + "</td>";
                        tbl += "<td>" + x.ColorName + "</td>";
                        tbl += "<td valign='top'><span id='empid' style='display:none'>" + x.ProductCode + "</span><span class='btn btn-success' onclick='showEditModalProduct(this)'>&nbsp;<i class='glyphicon glyphicon-pencil'></i></span>";
                        tbl += "<span id='PhotoPath' style='display:none'>" + x.ProductImagePath + "</span><span class='btn btn-danger' onclick='ShowImage(this);'><i class='glyphicon glyphicon-eye-open' ></i></span></td>";
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
        function ShowImage(ref) {
            debugger;
            var employeeid = $(ref).parent('td').find('#PhotoPath').html();
            $('#ImgProduct').attr('src', employeeid);
            $('#ShowImage').modal('show');
        }

        function showEditModalProduct(ref) {
            var VSNO = $(ref).parent('td').find('#empid').html();
            $.ajax({
                type: "post",
                dataType: "JSON",
                async: false,
                contentType: "application/json; charset=utf-8",
                url: 'frmProductList.aspx/ProductEdit',
                data: "{ProductCode:'" + VSNO + "'}",
                success: function (data) {
                    $('#txtProduct_Name').val(data.d[0].ProductName);
                    $('#txtProduct_Description').val(data.d[0].ProductDescription);

                    $('#txtProduct_BarCode').val(data.d[0].ProductBarCode);

                    $('#<%=hdSO.ClientID%>').val(data.d[0].ProductCode);

                    $('#<%=ddlProductUsageType.ClientID%>').val(data.d[0].ProductUsageTypeID);
                    $('#<%=ddlProductUsageType.ClientID%>').trigger('change');

                    $('#<%=ddlProductGroup.ClientID%>').val(data.d[0].GroupID);
                    $('#<%=ddlProductGroup.ClientID%>').trigger('change');

                    GetProductCategory(data.d[0].GroupID);

                    $('#ddlProductCategory').val(data.d[0].ProductCategoryID);
                    $('#ddlProductCategory').trigger('change');


                    $('#<%=ddlProductBrand.ClientID%>').val(data.d[0].ProductBrandID);
                    $('#<%=ddlProductBrand.ClientID%>').trigger('change');

                    $('#<%=ddlProductOrigin.ClientID%>').val(data.d[0].ProductOriginID);
                    $('#<%=ddlProductOrigin.ClientID%>').trigger('change');

                    $('#<%=ddlUnit.ClientID%>').val(data.d[0].UnitID);
                    $('#<%=ddlUnit.ClientID%>').trigger('change');

                    $('#<%=ddlPacking.ClientID%>').val(data.d[0].PackingID);
                    $('#<%=ddlPacking.ClientID%>').trigger('change');

                    $('#<%=ddlSize.ClientID%>').val(data.d[0].SizeID);
                    $('#<%=ddlSize.ClientID%>').trigger('change');

                    $('#<%=ddlColor.ClientID%>').val(data.d[0].ColorID);
                    $('#<%=ddlColor.ClientID%>').trigger('change');

                    $('#<%=imgPhoto.ClientID%>').attr('src', data.d[0].ProductImagePath);
                    $('#<%=hdPath.ClientID%>').val(data.d[0].ProductImagePath);

                },
                failure: function (data) {
                    alert('error occured');
                }

            });

            $('#ProductEdit').modal('show');
        }
        function GetProductCategory(GroupID) {
            debugger;
            $.ajax({
                type: "post",
                dataType: "JSON",
                contentType: "application/json; charset=utf-8",
                url: 'frmProductList.aspx/getProductCategory',
                data: "{Group_ID:'" + GroupID + "'}",
                async: false,
                success: function (data) {
                    console.log(data);

                    $('#ddlProductCategory').empty();
                    $.each(data.d, function (i, x) {
                        $('#ddlProductCategory').append("<option value='" + x.CategoryCode + "'>" + x.CategoryName + "</option>'");
                    });
                },
                failure: function (data) {
                    alert('error occured');
                }
            });
        }
        function ShowImagePreview(input) {
            debugger;
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#MainContent_imgPhoto').prop('src', e.target.result)
                        .width(200)
                        .height(200);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }


        function Save() {

            var txtProduct_BarCode = $('#txtProduct_BarCode').val();
            var txtProduct_Name = $('#txtProduct_Name').val();
            var txtProduct_Description = $('#txtProduct_Description').val();
            var ddlPacking = $('#<%=ddlPacking.ClientID%>').val();
           
            var ddlProductCategory = $('#ddlProductCategory').val();
            var ddlProductOrigin = $('#<%=ddlProductOrigin.ClientID%>').val();
            var ddlProductBrand = $('#<%=ddlProductBrand.ClientID%>').val();
            var ddlSize = $('#<%=ddlSize.ClientID%>').val();
            var ddlColor = $('#<%=ddlColor.ClientID%>').val();
            var ddlUnit = $('#<%=ddlUnit.ClientID%>').val();

            var UserID = $('#<%=hdUser.ClientID%>').val();
            var hdStoreID = $('#<%=hdStoreID.ClientID%>').val();
            var hdSO = $('#<%=hdSO.ClientID%>').val();

            var ddlProductUsageType = $('#<%=ddlProductUsageType.ClientID%>').val();

            if ($('#txtProduct_Name').val() == '') {
                toastr.error('Product Name is Required', 'Error :');
                $('#txtProduct_Name').focus();
                return;
            }
            if (ddlSize == null || ddlSize.length == 0) {
                toastr.error('Product Size is Required', 'Error :');
                $('#<%=ddlSize.ClientID%>').focus();
                return;
            }
            if (ddlColor == null || ddlColor.length == 0) {
                toastr.error('Product Color is Required', 'Error :');
                $('#<%=ddlColor.ClientID%>').focus();
                return;
            }
            if (ddlUnit == null || ddlUnit.length == 0) {
                toastr.error('Product Unit is Required', 'Error :');
                $('#<%=ddlUnit.ClientID%>').focus();
                    return;
                }
                var ProductGroup = $('#<%=ddlProductGroup.ClientID%>').val();
            if (ProductGroup == null || ProductGroup.length == 0) {
                toastr.error('Product Group is Required', 'Error :');
                $('#<%=ddlProductGroup.ClientID%>').focus();
                return;
            }
            if (ddlProductCategory == null || ddlProductCategory.length == 0) {
                toastr.error('Product Category is Required', 'Error :');
                $('#ddlProductCategory').focus();
                return;
            }
            if (ddlProductOrigin == null || ddlProductOrigin.length == 0) {
                toastr.error('Product Origin is Required', 'Error :');
                $('#<%=ddlProductOrigin.ClientID%>').focus();
                return;
            }
            if (ddlProductBrand == null || ddlProductBrand.length == 0) {
                toastr.error('Product Brand is Required', 'Error :');
                $('#<%=ddlProductBrand.ClientID%>').focus();
                    return;
                }
                if ($('#txtSalePrice').val() == '') {
                    toastr.error('Product Sale Price is Required', 'Error :');
                    $('#txtSalePrice').focus();
                    return;
                }
                debugger;
                var filename = $('#ProductImage').val();
                var ProductImageChange = "";
                if (filename != null && filename != "" || filename.length != 0) {
                    sendFile(hdSO);
                    filename = $('#ProductImage').val();
                    ProductImageChange = "Yes";
                }
                else {
                    filename = $('#<%=hdPath.ClientID%>').val();
                ProductImageChange = "No";
            }
            var ProductObj = {
                ProductCode: hdSO,
                ProductName: txtProduct_Name, ProductDescription: txtProduct_Description, ProductBarCode: txtProduct_BarCode, ProductUsageTypeID:ddlProductUsageType,
                ProductCategoryID: ddlProductCategory,
                ProductBrandID: ddlProductBrand, ProductOriginID: ddlProductOrigin, UnitID: ddlUnit, PackingID: ddlPacking, ColorID: ddlColor, SizeID: ddlSize, ProductImagePath: filename,
                LastUpdateBy: UserID, ProductImageChange: ProductImageChange
            };
            $.ajax({
                type: "POST",
                url: "frmProductList.aspx/Update",
                data: JSON.stringify({ 'Obj': ProductObj }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data) {
                        toastr.success('Datat Saved', 'Success :');
                        GetProductList();
                        $('#ProductEdit').modal('hide');
                        Clear();
                    }
                },
                failure: function (response) {
                    toastr.error('', 'Error');
                }
            });
        }


        function sendFile(ProductCode) {
            debugger;
            var formData = new FormData();
            var file = $('#ProductImage').get(0).files[0];
            formData.append('file', file);
            formData.append('state', 'edit');
            formData.append('ProductCode', ProductCode);
            $.ajax({
                type: 'post',
                url: 'fileUploader.ashx',
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
