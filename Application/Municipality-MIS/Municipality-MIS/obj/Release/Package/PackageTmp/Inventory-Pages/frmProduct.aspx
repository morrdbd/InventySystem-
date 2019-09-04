<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Inventory.Master" AutoEventWireup="true" CodeBehind="frmProduct.aspx.cs" Inherits="Inventory_Manager_ALKC.IMIS_Pages.frmProduct" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <link href="../Content/toastr.min.css" rel="stylesheet" />
    <script src="../Scripts/toastr.min.js"></script>
    <script>
        $(function () {
         
            $("#txtProduct_Name").focus();
        });
    </script>
    <script type="text/javascript">
        $(function () {
            $('#ProductImage').change(function (e) {
                ShowImagePreview(this);
            });
        });
    </script>
    <div class="row">
        <div class="col-lg-12 ">
            <div class="panel panel-primary">
                <div class="panel-heading blue-bg"><span style="color: white">د توکو د ثبتولو فورمه</span></div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-9">
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span class="input-group-addon badge-primary">د توکو د کارېدنه نوعه</span>
                                            <asp:DropDownList ID="ddlProductUsageType" CssClass="form-control" runat="server">
                                                <asp:ListItem>New</asp:ListItem>
                                                <asp:ListItem>Printed</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span  class="input-group-addon badge-primary"> د توکي د لیبل معلومات</span>
                                            <input type="text" id="txtProduct_BarCode" name="txtProduct_BarCode" placeholder="Product BarCode" class="form-control" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span  class="input-group-addon badge-primary">د توکي نوم</span>
                                            <input type="text" id="txtProduct_Name" name="txtProduct_Name" placeholder="Product Name" class="form-control" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span  class="input-group-addon badge-primary">د توکي اندازه</span>
                                            <asp:DropDownList ID="ddlSize" CssClass="form-control" runat="server"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span  class="input-group-addon badge-primary">د توکي رنګ</span>
                                            <asp:DropDownList ID="ddlColor" CssClass="form-control" runat="server"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span  class="input-group-addon badge-primary">د توکی د متحد ډول</span>
                                            <asp:DropDownList ID="ddlUnit" CssClass="form-control" runat="server"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span  class="input-group-addon badge-primary">د توکي بسته بندي</span>
                                            <asp:DropDownList ID="ddlPacking" CssClass="form-control" runat="server"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span  class="input-group-addon badge-primary">د توکي ګروپ</span>
                                            <asp:DropDownList ID="ddlProductGroup" CssClass="form-control" runat="server"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span  class="input-group-addon badge-primary">د توکي کټګورۍ</span>
                                            <select id="ddlProductCategory" name="ddlProductCategory" class="form-control"></select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span  class="input-group-addon badge-primary">د توکي اصلي</span>
                                            <asp:DropDownList ID="ddlProductOrigin" CssClass="form-control" runat="server"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span  class="input-group-addon badge-primary">د توکي سوداګریز</span>
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
                                            <span  class="input-group-addon badge-primary">د توکي تفصیل</span>
                                            <input type="text" id="txtProduct_Description" name="txtProduct_Description" placeholder="Product Description" class="form-control" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3">
                            د توکي انځور
                            <div class="form-group">
                                <asp:Image ID="imgPhoto" Width="240" Height="240" runat="server" ImageUrl="~/Images/NoImage.jpg" />
                                <input type="file" class="upload" tabindex="6" name="ProductImage" id="ProductImage" style="width: 150px" /><br />
                                <asp:HiddenField ID="HiddenField1" runat="server" Value="1001" />
                            </div>
                        </div>
                    </div>
                    <div class="row">

                        <div class="col-lg-4">
                            <button type="button" id="btnSave" onclick="Save();" class="btn btn-primary">ثبت</button>
                            <a class="btn btn-danger" id="btnClear" href="#"><i class="glyphicon glyphicon-new-window"></i>&nbsp;پاکول</a>
                            <a class="btn btn-success" id="A1" href="frmProductList.aspx"><i class="glyphicon glyphicon-list"></i>&nbsp;د توکو لیست</a>
                            <asp:HiddenField ID="hdUser" runat="server" />

                            <asp:HiddenField ID="hdStoreID" runat="server" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            // GetProductList();
            //$('#ProductImage').change(function () {
            //    sendFile();
            //});

            $('#<%=ddlProductGroup.ClientID%>').val('1');
            $('#<%=ddlProductGroup.ClientID%>').trigger('change');

            $('#<%=ddlProductGroup.ClientID%>').change(function () {
                $('#ddlProductCategory').empty();
                GetProductCategory();
            });
        });

        function Save() {
            
            var txtProduct_BarCode = $('#txtProduct_BarCode').val();
            var txtProduct_Name = $('#txtProduct_Name').val();
            var txtProduct_Description = $('#txtProduct_Description').val();
            var ddlPacking = $('#<%=ddlPacking.ClientID%>').val();
            var txtSalePrice = $('#txtSalePrice').val();
            var ddlProductCategory = $('#ddlProductCategory').val();
            var ddlProductOrigin = $('#<%=ddlProductOrigin.ClientID%>').val();
            var ddlProductBrand = $('#<%=ddlProductBrand.ClientID%>').val();
            var ddlSize = $('#<%=ddlSize.ClientID%>').val();
            var ddlColor = $('#<%=ddlColor.ClientID%>').val();
            var ddlUnit = $('#<%=ddlUnit.ClientID%>').val();
            var ddlProductUsageType = $('#<%=ddlProductUsageType.ClientID%>').val();
            
            var filename = $('#ProductImage').val();
            var UserID = $('#<%=hdUser.ClientID%>').val();
            var hdStoreID = $('#<%=hdStoreID.ClientID%>').val();
            debugger;
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
            if (filename == null || filename.length == 0) {
                toastr.error('Product Image is Required', 'Error :');
                return;
            }
            var ProductObj = {ProductUsageTypeID:ddlProductUsageType,
                ProductName: txtProduct_Name, ProductDescription: txtProduct_Description, ProductBarCode: txtProduct_BarCode,
                ProductCategoryID: ddlProductCategory,
                ProductBrandID: ddlProductBrand, ProductOriginID: ddlProductOrigin, UnitID: ddlUnit, PackingID: ddlPacking, ColorID: ddlColor, SizeID: ddlSize, ProductImagePath: filename,
                UserID: UserID
            };
            $.ajax({
                type: "POST",
                url: "frmProduct.aspx/Insert",
                data: JSON.stringify({ 'Obj': ProductObj }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data) {
                        sendFile(data.d);
                        toastr.success('Product No:' + data.d + ' Saved', 'Success :');
                        Clear();
                    }
                },
                failure: function (response) {
                    toastr.error('', 'Error');
                }
            });
        }

        function GetProductCategory() {
            debugger;
            var ProvinceID = $('#<%=ddlProductGroup.ClientID%>').val();

            $.ajax({
                type: "post",
                dataType: "JSON",
                contentType: "application/json; charset=utf-8",
                url: 'frmProduct.aspx/getProductCategory',
                data: "{Group_ID:'" + ProvinceID + "'}",
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
        function sendFile(ProductCode) {
            debugger;
            //var file = $('#ProductImage').prop('files');
            var formData = new FormData();
            var file = $('#ProductImage').get(0).files[0];
            //formData.append('file', $('#ProductImage')[0].files[0]);
            formData.append('file', file);
            formData.append('state', 'insert');
            formData.append('ProductCode', ProductCode);
            $.ajax({
                type: 'post',
                url: 'fileUploader.ashx',
                data: formData,
                async: true,
                success: function (status) {
                    if (status != 'error') {
                        //var my_path = "uploads/emp/" + status;
                        //$("#MyPhoto").attr("src", my_path);
                        // alert('File Uploaded');
                    }
                },
                processData: false,
                contentType: false,
                error: function () {
                    alert("Picture not saved");
                }
            });
        }
        function Clear() {

            $('#txtProductCode').val("");
            $('#txtProduct_BarCode').val("");
            $('#txtProduct_Name').val("");
            $('#txtProduct_Description').val("");
            $('#txtProductPacking').val("");
            $('#txtProduct_Name').focus();
            $('#txtSalePrice').val("");
            $('#txtLocation').val("");
            $('#<%=ddlProductGroup.ClientID%>').val('1');
            $('#<%=ddlProductGroup.ClientID%>').trigger('change');
            $('#<%=ddlProductGroup.ClientID%>').change(function () {
                $('#ddlProductCategory').empty();
                GetProductCategory();
            });
        }
        function ShowImagePreview(input) {
            debugger;
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#MainContent_imgPhoto').prop('src', e.target.result)
                        .width(240)
                        .height(240);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</asp:Content>
