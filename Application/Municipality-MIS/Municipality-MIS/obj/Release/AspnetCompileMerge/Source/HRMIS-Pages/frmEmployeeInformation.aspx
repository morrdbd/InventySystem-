<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/HRMIS.Master" AutoEventWireup="true" CodeBehind="frmEmployeeInformation.aspx.cs" Inherits="Municipality_MIS.HRMIS_Pages.frmEmployeeInformation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <link href="../Content/bootstrap-datepicker.min.css" rel="stylesheet" />
    <link href="../Content/bootstrap-datetimepicker.min.css" rel="stylesheet" />
  
    <link href="../Content/toastr.min.css" rel="stylesheet" />
    <script src="../Scripts/select2.js"></script>
    <script src="../Scripts/toastr.min.js"></script>
    <link href="../Content/select2.css" rel="stylesheet" />
    <link href="../Content/select2-bootstrap.css" rel="stylesheet" />
    
   
    <script type="text/javascript">
        $(function () {
            $('#txtName_Local').focus();
        $('#<%=ddlPermanentProvince.ClientID%>').select2({ placeholder: "Permanent Province", theme: "classic" });
            $('#<%=ddlPermanentProvince.ClientID%>').val('0');
            $('#<%=ddlPermanentProvince.ClientID%>').trigger('change');
            $('#<%=ddlPresentProvince.ClientID%>').select2({ placeholder: "Present Province", theme: "classic" });
            $('#<%=ddlPresentProvince.ClientID%>').val('0');
            $('#<%=ddlPresentProvince.ClientID%>').trigger('change');
            $('#ddlPermanentDistrict').select2({ placeholder: "Permanent District", theme: "classic" });
            $('#ddlPermanentDistrict').val('0');
            $('#ddlPermanentDistrict').trigger('change');
            $('#ddlPresentDistrict').select2({ placeholder: "Present District", theme: "classic" });
            $('#ddlPresentDistrict').val('0');
            $('#ddlPresentDistrict').trigger('change');
            $('#<%=ddlGender.ClientID%>').select2({ placeholder: "Gender", theme: "classic" });
            $('#<%=ddlGender.ClientID%>').val('0');
            $('#<%=ddlGender.ClientID%>').trigger('change');
            $('#<%=ddlMaritalStatus.ClientID%>').select2({ placeholder: "Marital Status", theme: "classic" });
            $('#<%=ddlMaritalStatus.ClientID%>').val('0');
            $('#<%=ddlMaritalStatus.ClientID%>').trigger('change');
        
        })

        $(function () {
          
            $('#<%=ddlPermanentProvince.ClientID%>').change(function () {
                GetPermanentDistrict();
            });
            $('#<%=ddlPresentProvince.ClientID%>').change(function () {
                GetPresentDistrict();
            });
            $('#<%=ddlEmergencyContactRelationship.ClientID%>').change(function () {
                $('#txtEmergencyContactName').focus();
            });
            $('#txtDateOfBirth').datepicker({
                isRTL: true, changeMonth: true, changeYear: true, showOtherMonths: true,
                selectOtherMonths: true
            });
         
            
        });
    </script>
    <div class="row">
        <div class="col-lg-12 ">
            <div class="panel panel-primary">
                <div class="panel-heading bg-warning"><span style="color: white">د کارکونکی د ثبت فورمه</span></div>
                <div class="panel-body">
                    <br />
                    <div class="row">
                        <div class="col-lg-10">
                          
                            <div  class="row">
                                  <div class="form-group col-md-4 col-sm-4">
                                    <label for="name">مکمل نوم/اسم مکمل</label>
                                    <input type="text" id="txtName_Local" tabindex="3" name="txtProduct_BarCode" placeholder="مکمل نوم/اسم مکمل" class="form-control" />
                                </div>
                                 <div class="form-group col-md-4 col-sm-4">
                                    <label for="name">پلار نوم/نام پدر</label>
                                    <input type="text" id="txtFather_Name_Local" name="txtProduct_BarCode" tabindex="4" placeholder="پلار نوم/نام پدر" class="form-control" />
                                </div>
                                <div class="form-group col-md-4 col-sm-4">
                                    <label for="name">نیکه نوم/نام پدر کلان</label>
                                    <input type="text" id="txtGrand_Father_Name_Local" name="txtProduct_BarCode" tabindex="5" placeholder="نیکه نوم/نام پدر کلان" class="form-control" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-3 col-sm-3">
                                    <label for="name">جنس</label>
                                    <asp:DropDownList ID="ddlGender" TabIndex="6" CssClass="form-control" runat="server">
                                        <asp:ListItem>نارینه/مذکر</asp:ListItem>
                                        <asp:ListItem>ښځینه/مونث</asp:ListItem>
                                    </asp:DropDownList>
                                </div>

                                <div class="form-group col-md-3 col-sm-3">
                                    <label for="name">مدني حالت/حالت مدنی</label>
                                    <asp:DropDownList ID="ddlMaritalStatus" TabIndex="7" CssClass="form-control" runat="server">
                                        <asp:ListItem>مجرد</asp:ListItem>
                                        <asp:ListItem>متاحل</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="form-group col-md-3 col-sm-3">
                                    <label for="name">د زیږیدني نيټه/تاریخ تولد</label>
                                    <input type="text" id="txtDateOfBirth" tabindex="8" name="txtProduct_BarCode" placeholder="Date of Birth" class="form-control" />
                                  
                                </div>
                                <div class="form-group col-md-3 col-sm-3">
                                    <label for="name">د تذکره شمیره</label>
                                    <input type="text" id="txtTazkiraNumber" tabindex="9" name="txtProduct_BarCode" placeholder="Tazkira Number" class="form-control" />
                                </div>
                            </div>
                            <div class="row">
                                    <div class="form-group col-md-4 col-sm-4">
                                        <label for="name">په بیړنی حالت کی له ارتبات کونکی </label>
                                        <asp:DropDownList ID="ddlEmergencyContactRelationship" TabIndex="10" CssClass="form-control" runat="server">
                                            <asp:ListItem>Brother</asp:ListItem>
                                            <asp:ListItem>Father</asp:ListItem>
                                            <asp:ListItem>Uncle</asp:ListItem>
                                            <asp:ListItem>Mother</asp:ListItem>
                                            <asp:ListItem>Sisters</asp:ListItem>
                                            <asp:ListItem>Son</asp:ListItem>
                                            <asp:ListItem>Wife</asp:ListItem>
                                            <asp:ListItem>Daughter</asp:ListItem>
                                        </asp:DropDownList>

                                    </div>
                                    <div class="form-group col-md-4 col-sm-4">
                                        <label for="name">د ارتبات کونکی نوم</label>
                                        <input type="text" id="txtEmergencyContactName" tabindex="11" name="txtEmergencyContactName" placeholder="Emergency Contact Name" class="form-control" />
                                    </div>
                                    <div class="form-group col-md-4 col-sm-4">
                                        <label for="name">د ارتبات کونکی شمیره</label>
                                        <input type="text" id="txtEmergencyMobile" tabindex="12" name="txtEmergencyMobile" placeholder="Emergency Mobile" class="form-control" />
                                    </div>
                                </div>
                        </div>
                        <div class="col-lg-2">
                            <div class="form-group">
                                <asp:Image ID="imgPhoto" Width="160px" Height="175px" runat="server" ImageUrl="~/Images/NoImage.jpg" />
                                <input type="file" class="upload" tabindex="13" name="ProductImage" id="ProductImage" style="width: 150px" /><br />
                                <asp:HiddenField ID="hdUser" runat="server" Value="1001" />
                                <asp:HiddenField ID="hdEmpNo" runat="server" />
                            </div>
                        </div>
                    </div>
                    
                    <div class="row">
                                <div class="col-lg-12">
                                    <fieldset>
                                        <legend style="color: green; font-size: 15px">اصلی استوګنځی/سکونت اصلی </legend>
                                        <div class="row">
                                            <div class="col-lg-4">
                                                <div class="form-group">
                                                    <div class="input-group">
                                                          <span class="input-group-addon">ولایت</span>
                                                        <asp:DropDownList ID="ddlPermanentProvince" TabIndex="16" CssClass="form-control" runat="server"></asp:DropDownList>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-4">
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <span class="input-group-addon">ولسوالی</span>
                                                        <select id="ddlPermanentDistrict" tabindex="17" name="ddlProductCategory" class="form-control"></select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-4">
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <span class="input-group-addon">کلی/ګذر</span>
                                                        <input type="text" id="txtPermanentVillage" tabindex="18" name="txtProduct_BarCode" placeholder="City/village" class="form-control" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </fieldset>
                                    <fieldset>
                                        <legend style="color: green; font-size: 15px">اوسنی استوګنڅی/سکونت فعلی</legend>
                                        <div class="row">
                                            <div class="col-lg-4">
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <span class="input-group-addon">ولایت</span>
                                                        <asp:DropDownList ID="ddlPresentProvince" tabindex="20" CssClass="form-control" runat="server"></asp:DropDownList>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-4">
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <span  class="input-group-addon">ولسوالی</span>
                                                        <select id="ddlPresentDistrict" tabindex="21" name="ddlProductCategory" class="form-control"></select>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-lg-4">
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <span class="input-group-addon">کلی/ګذر</span>
                                                        <input type="text" id="txtPresentVillage" tabindex="22" name="txtProduct_BarCode" placeholder="City/village" class="form-control" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>



                    <div class="row">
                        <div class="form-group col-md-4 col-sm-4">
                            <label for="name">د تحصیل کچه / سطح تحصیل</label>
                            <asp:DropDownList ID="ddlEducationGrade" TabIndex="23" CssClass="form-control" runat="server">
                            </asp:DropDownList>
                        </div>
                        <div class="form-group col-md-4 col-sm-4">
                            <label for="name">رشته</label>
                         
                              <input type="text" id="txtMainCourseofStudy" tabindex="24" name="txtProduct_BarCode" placeholder="Main Course of Study" class="form-control" />
                        </div>
                        <div class="form-group col-md-4 col-sm-4">
                            <label for="name">تخصص</label>
                            <input type="text" id="txtSpecialization" tabindex="25" name="txtProduct_BarCode" placeholder="Specialization" class="form-control" />
                        </div>

                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <fieldset>
                                <legend style="color: green; font-size: 15px">داړیکو برخه / بخش ارتبات </legend>
                                <div class="row">
                                    <div class="form-group col-md-3 col-sm-3">
                                        <label for="name">شخصی شمیره</label>
                                        <input type="text" id="txtPersonal_Mobile_Number" tabindex="26" name="txtProduct_BarCode" placeholder="Personal Mobile Number" class="form-control" />
                                    </div>
                                    <div class="form-group col-md-3 col-sm-3">
                                        <label for="name">شخصی برښنالیک</label>
                                        <input type="text" id="txtPersonal_Email_Address" tabindex="27" name="txtProduct_BarCode" placeholder="Personal Email Address" class="form-control" />
                                    </div>
                                    <div class="form-group col-md-3 col-sm-3">
                                        <label for="name">د دفتر شمیره</label>
                                        <input type="text" id="txtOfficialContactNumber" tabindex="28" name="txtProduct_BarCode" placeholder="Official Contact Number" class="form-control" />
                                    </div>
                                    <div class="form-group col-md-3 col-sm-3">
                                        <label for="name">د دفتر برښنالیک</label>
                                        <input type="text" id="txtOfficialEmailAddress" tabindex="29" name="txtProduct_BarCode" placeholder="Official Email Address" class="form-control" />
                                    </div>

                                </div>
                                
                            </fieldset>
                            
                            <div class="row">
                                <div class="col-lg-6">
                                    <button type="button" id="btnSave" tabindex="30" class="btn btn-success">Save</button>
                                   
                                    <asp:Button ID="btnNext" CssClass="btn btn-success" tabindex="31" runat="server" Text="Next" OnClick="btnNext_Click" />

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        $('#btnSave').click(function () {
            SaveEmployee();
        });
        
        
        $(function () {
            $('#ProductImage').change(function (e) {
                ShowImagePreview(this);
            });
        });
    </script>
    <script>
        function SaveEmployee() {
            debugger;
            var Name_Local = $('#txtName_Local').val();
            var Father_Name_Local = $('#txtFather_Name_Local').val();
            var Grand_Father_Name_Local = $('#txtGrand_Father_Name_Local').val();
            var Gender = $('#<%=ddlGender.ClientID%>').val();
            var Marital_Status = $('#<%=ddlMaritalStatus.ClientID%>').val();
            var Date_Of_Birth = $('#txtDateOfBirth').val();
            var National_ID_Card_NO = $('#txtTazkiraNumber').val();
            var filename = $('#ProductImage').val();
            var Personal_Mobile_Number = $('#txtPersonal_Mobile_Number').val();
            var Personal_Email_Address = $('#txtPersonal_Email_Address').val();
            var Official_Contact_Number = $('#txtOfficialContactNumber').val();
            var Official_Email_Address = $('#txtOfficialEmailAddress').val();
            var Emergency_Contact_Relationship = $('#<%=ddlEmergencyContactRelationship.ClientID%>').val();
            var Emergency_Contact_Name = $('#txtEmergencyContactName').val();
            var Emergency_Contact_Mobile = $('#txtEmergencyMobile').val();
            var Education_Grade_ID = $('#<%=ddlEducationGrade.ClientID%>').val();
            var Main_Course_of_Study = $('#txtMainCourseofStudy').val();
            var Specialization = $('#txtSpecialization').val();
            var Permanent_Province_ID = $('#<%=ddlPermanentProvince.ClientID%>').val();
            var Permanent_District_ID = $('#ddlPermanentDistrict').val();
            var Permanent_Village = $('#txtPermanentVillage').val();
            var Present_Province_ID = $('#<%=ddlPresentProvince.ClientID%>').val();
            var Present_District_ID = $('#ddlPresentDistrict').val();
            var Present_Village = $('#txtPresentVillage').val();
            var UserID = $('#<%=hdUser.ClientID%>').val();
          
            
            var objSO = {
                Name_Local: Name_Local, Father_Name_Local: Father_Name_Local, Grand_Father_Name_Local: Grand_Father_Name_Local,
                Gender: Gender, Marital_Status: Marital_Status, Date_Of_Birth: Date_Of_Birth, Photo: filename, National_ID_Card_NO: National_ID_Card_NO,
                Personal_Mobile_Number: Personal_Mobile_Number, Personal_Email_Address: Personal_Email_Address, Official_Contact_Number: Official_Contact_Number,
                Official_Email_Address: Official_Email_Address, Emergency_Contact_Relationship: Emergency_Contact_Relationship,
                Emergency_Contact_Name: Emergency_Contact_Name, Emergency_Contact_Mobile: Emergency_Contact_Mobile,
                Education_Grade_ID: Education_Grade_ID, Main_Course_of_Study: Main_Course_of_Study, Specialization: Specialization,
                Permanent_Province_ID: Permanent_Province_ID, Permanent_District_ID: Permanent_District_ID, Permanent_Village: Permanent_Village,
                Present_Province_ID: Present_Province_ID, Present_District_ID: Present_District_ID, Present_Village: Present_Village,
                User_ID: UserID
            };
            $.ajax({
                type: "POST",
                url: "frmEmployeeInformation.aspx/SaveEmployee",
                data: JSON.stringify({ 'Employee': objSO }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data) {
                        $('#<%=hdEmpNo.ClientID%>').val(data.d);
                        sendFile(data.d);
                        Clear();
                        toastr.success('Employee ' + data.d + ' Saved Successfully', 'Success :');
                    }
                },
                failure: function (response) {
                    toastr.error('', 'Error');
                }
            });
        }

        


        function GetPermanentDistrict() {
            debugger;
            var ProvinceID = $('#<%=ddlPermanentProvince.ClientID%>').val();
            $.ajax({
                type: "post",
                dataType: "JSON",
                contentType: "application/json; charset=utf-8",
                url: 'frmEmployeeInformation.aspx/getDistricts',
                data: "{Province_ID:'" + ProvinceID + "'}",
                success: function (data) {
                    console.log(data);
                    $('#ddlPermanentDistrict').empty();
                    $.each(data.d, function (i, x) {
                        $('#ddlPermanentDistrict').append("<option value='" + x.District_Id + "'>" + x.District_Name + "</option>'");
                    });
                },
                failure: function (data) {
                    alert('error occured');
                }
            });
        }
        function GetPresentDistrict() {
            debugger;
            var ProvinceID = $('#<%=ddlPresentProvince.ClientID%>').val();
            $.ajax({
                type: "post",
                dataType: "JSON",
                contentType: "application/json; charset=utf-8",
                url: 'frmEmployeeInformation.aspx/getDistricts',
                data: "{Province_ID:'" + ProvinceID + "'}",
                success: function (data) {
                    console.log(data);
                    $('#ddlPresentDistrict').empty();
                    $.each(data.d, function (i, x) {
                        $('#ddlPresentDistrict').append("<option value='" + x.District_Id + "'>" + x.District_Name + "</option>'");
                    });
                },
                failure: function (data) {
                    alert('error occured');
                }
            });
        }

       
        function sendFile(EmployeeID) {
            debugger;
            //var file = $('#ProductImage').prop('files');
            var formData = new FormData();
            var file = $('#ProductImage').get(0).files[0];
            //formData.append('file', $('#ProductImage')[0].files[0]);
            formData.append('file', file);
            formData.append('state', 'insert');
            formData.append('EmpID', EmployeeID);
            $.ajax({
                type: 'post',
                url: 'fileUploaderEmp.ashx',
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
        function ShowImagePreview(input) {
            debugger;
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#MainContent_imgPhoto').prop('src', e.target.result)
                        .width(160)
                        .height(175);
                };
                //$('#removepicture').css('visibility', 'visible');
                reader.readAsDataURL(input.files[0]);
            }
        }
        function Clear() {
            $('#txtEmployeeName').val("");
            $('#txtFatherName').val("");
            $('#txtGrandFatherName').val("");
            $('#txtName_Local').val("");
            $('#txtFather_Name_Local').val("");
            $('#txtGrand_Father_Name_Local').val("");
            $('#txtDateOfBirth').val("");
            $('#txtTazkiraNumber').val("");
            $('#ProductImage').val("");
            $('#Personal_Mobile_Number').val("");
            $('#Personal_Email_Address').val("");
            $('#Official_Contact_Number').val("");
            $('#Official_Email_Address').val("");
            $('#txtPermanentVillage').val("");
            $('#txtEmergencyContactName').val("");
            $('#txtEmergencyMobile').val("");
            $('#txtMainCourseofStudy').val("");
            $('#txtSpecialization').val("");
            $('#txtPermanent_Village').val("");
            $('#txtPresentVillage').val("");
            $('#imgPhoto').val("");
            $('#MainContent_imgPhoto').prop('src', "~/Images/NoImage.jpg")
            $('#<%=ddlPermanentProvince.ClientID%>').select2({ placeholder: "Permanent Province", theme: "classic" });
            $('#<%=ddlPermanentProvince.ClientID%>').val('0');
            $('#<%=ddlPermanentProvince.ClientID%>').trigger('change');
            $('#<%=ddlPresentProvince.ClientID%>').select2({ placeholder: "Present Province", theme: "classic" });
            $('#<%=ddlPresentProvince.ClientID%>').val('0');
            $('#<%=ddlPresentProvince.ClientID%>').trigger('change');
            $('#ddlPermanentDistrict').select2({ placeholder: "Permanent District", theme: "classic" });
            $('#ddlPermanentDistrict').val('0');
            $('#ddlPermanentDistrict').trigger('change');
            $('#ddlPresentDistrict').select2({ placeholder: "Present District", theme: "classic" });
            $('#ddlPresentDistrict').val('0');
            $('#ddlPresentDistrict').trigger('change');
            $('#<%=ddlGender.ClientID%>').select2({ placeholder: "Gender", theme: "classic" });
            $('#<%=ddlGender.ClientID%>').val('0');
            $('#<%=ddlGender.ClientID%>').trigger('change');
            $('#<%=ddlMaritalStatus.ClientID%>').select2({ placeholder: "Marital Status", theme: "classic" });
            $('#<%=ddlMaritalStatus.ClientID%>').val('0');
            $('#<%=ddlMaritalStatus.ClientID%>').trigger('change');
        }
    </script>
</asp:Content>
