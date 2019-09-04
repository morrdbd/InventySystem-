<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/HRMIS.Master" AutoEventWireup="true" CodeBehind="frmEmployeeAtDepartment.aspx.cs" Inherits="Municipality_MIS.HRMIS_Pages.frmEmployeeAtDepartment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../Scripts/treeview/bootstrap-treeview.css" rel="stylesheet" />
    <script src="../Scripts/select2.js"></script>
    <link href="../Content/select2.css" rel="stylesheet" />
    <link href="../Content/toastr.min.css" rel="stylesheet" />
    <script src="../Scripts/toastr.min.js"></script>
    <link href="../Content/select2-bootstrap.css" rel="stylesheet" />
    <script>
        $(function () {
            GetEmployee($('#<%=hdEmployeeID.ClientID%>').val());

            $('#<%=ddlPosition.ClientID%>').select2({ placeholder: "Position", theme: "classic" });
            $('#<%=ddlPosition.ClientID%>').val('0');
            $('#<%=ddlPosition.ClientID%>').trigger('change');
            $('#<%=ddlSearchType.ClientID%>').change(function () {
                debugger;
                var PaymentMethod = $('#<%=ddlSearchType.ClientID%>').val();
                if (PaymentMethod == '1') {
                    $("#divEducationGrade").hide();
                    $("#DivPresentAddress").hide();
                    $("#DivSearchByName").show();
                    $('#txtSearchByName').val("");
                    $('#txtSearchByName').focus();
                }
                else if (PaymentMethod == '2') {
                    $("#divEducationGrade").show();
                    $("#DivPresentAddress").hide();
                    $("#DivSearchByName").hide();
                }
                else if (PaymentMethod == '3') {
                    $("#divEducationGrade").hide();
                    $("#DivPresentAddress").show();
                    $("#DivSearchByName").hide();
                }
            });
        });
        $(function () {
            $('#<%=ddlPresentProvince.ClientID%>').change(function () {
                GetPresentDistrict();
            });
        });
        $(document).ready(function () {
            $('#btnSearch').click(function () {
                var ID = $('#txtEmpID').val();
                GetEmployee(ID);
            });
        });
    </script>
    <div class="row">
        <div class="col-lg-12 ">
            <div class="panel panel-primary">
                <div class="panel-heading bg-warning"><span style="color: white">کارمند په یو بخش کی</span></div>
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
                            </div>
                        </div>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="col-lg-10">
                            <div class="row">
                                <div class="form-group col-md-4 col-sm-4">
                                    <label for="name">نیکه نوم/نام پدر کلان</label>
                                    <input type="text" id="txtName_Local" name="txtProduct_BarCode" placeholder="نیکه نوم/نام پدر کلان" class="form-control" disabled />
                                </div>
                                <div class="form-group col-md-4 col-sm-4">
                                    <label for="name">پلار نوم/نام پدر</label>
                                    <input type="text" id="txtFather_Name_Local" name="txtProduct_BarCode" placeholder="پلار نوم/نام پدر" class="form-control" disabled />
                                </div>
                                <div class="form-group col-md-4 col-sm-4">
                                    <label for="name">مکمل نوم/اسم مکمل</label>
                                    <input type="text" id="txtGrand_Father_Name_Local" name="txtProduct_BarCode" placeholder="مکمل نوم/اسم مکمل" class="form-control" disabled />
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-3 col-sm-3">
                                    <label for="name">جنس</label>
                                    <input type="text" id="txtGender" name="txtProduct_BarCode" placeholder="Gender" class="form-control" disabled />
                                </div>
                                <div class="form-group col-md-3 col-sm-3">
                                    <label for="name">مدني حالت/حالت مدنی</label>
                                    <input type="text" id="txtMaritalStatus" name="txtProduct_BarCode" placeholder="Marital Status" class="form-control" disabled />
                                </div>
                                <div class="form-group col-md-3 col-sm-3">
                                    <label for="name">د زیږیدني نيټه/تاریخ تولد</label>
                                    <input type="text" id="txtDateOfBirth" name="txtProduct_BarCode" placeholder="Date of Birth" class="form-control" disabled />
                                </div>
                                <div class="form-group col-md-3 col-sm-3">
                                    <label for="name">د تذکره شمیره</label>
                                    <input type="text" id="txtTazkiraNumber" name="txtProduct_BarCode" placeholder="Tazkira Number" class="form-control" disabled />
                                </div>
                            </div>

                            <div class="row">
                                <div class="form-group col-md-3 col-sm-3">
                                    <label for="name">بخشونه/بخشها</label>
                                    <asp:TextBox CssClass="form-control nothing" ID="txtTreeViewText" placeholder="Department" runat="server"></asp:TextBox>
                                    <asp:HiddenField ID="hdTreeViewValue" runat="server" />
                                </div>
                                <div class="form-group col-md-1 col-sm-1">
                                    <br />
                                    <button type="button" id="btnShowDepartment" data-toggle="modal" data-target="#treeModal" class="btn btn-primary glyphicon glyphicon-list"></button>
                                </div>
                                <div class="form-group col-md-4 col-sm-4">
                                    <label for="name">دنده/وظیفه</label>
                                    <asp:DropDownList ID="ddlPosition" runat="server" class="form-control"></asp:DropDownList>
                                    <asp:HiddenField ID="hdPositionID" runat="server" />
                                </div>

                                <div class="form-group col-md-3 col-sm-3">
                                    <label for="name">راپور ورکول</label>
                                    <input type="text" id="txtReportingTo" name="txtProduct_BarCode" placeholder="Reporting To" class="form-control" />
                                    <asp:HiddenField ID="hdReportingTo" runat="server" />
                                </div>
                                <div class="form-group col-md-1 col-sm-1">
                                    <br />
                                    <button type="button" id="btnReportingTo" data-toggle="modal" data-target="#DivReportingToDialog" class="btn btn-primary glyphicon glyphicon-list"></button>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-2">
                            <div class="form-group">
                                <br />
                                <img id="imgPhoto" style="width: 160px; height: 175px">
                                <asp:HiddenField ID="hdUser" runat="server" Value="1001" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6">
                            <button type="button" id="btnSave" onclick="SaveEmpAtDepartment();" class="btn btn-success">Save</button>
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="table-responsive" id="divatDepartmentList">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="treeModal" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">د توکو تعیرول</h4>
                </div>
                <div class="modal-body">
                    <table>
                        <tr>
                            <td>
                                <input type="text" id="txtsearchTreeView" class="form-control" placeholder="type to search" /></td>
                            <td>
                                <button type="button" class="btn btn-danger" id="btn-collapse-all">Collapse All</button></td>
                            <td>
                                <button type="button" class="btn btn-danger" id="btn-expand-all">Expand All</button></td>
                        </tr>
                    </table>
                    <div style="height: 300px; overflow: auto;">
                        <div id="treeview2"></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" onclick="SetValue()" data-dismiss="modal">Ok</button>
                    <button type="button" class="btn btn-danger" onclick="ClearValue()" data-dismiss="modal">Cancel</button>

                </div>
            </div>
        </div>
    </div>
    <div style="min-height: 500px">
        &nbsp;
    </div>
    <style>
        .modal-backdrop
        {
            z-index: -1;
        }
    </style>
    <script>
        var $searchableTree;
        var _selectedID;
        var _selectedText;
        $(function () {
            $('#<%=txtTreeViewText.ClientID%>').on("focus", function () {
                $('#treeModal').modal('show');
            });
            $('#txtReportingTo').on("focus", function () {
                $('#DivReportingToDialog').modal('show');
            });
            $('#btn-collapse-all').on('click', function (e) {
                $searchableTree.treeview('collapseAll', { silent: true });
            });
            $('#btn-expand-all').on('click', function (e) {
                var levels = 1000;
                $searchableTree.treeview('expandAll', { levels: levels, silent: true });
            });

            $(".nothing").focus(function () {
                $(this).keydown(function (event) {
                    if ((event.keyCode == 9) || (event.keyCode >= 37 && event.keyCode <= 40)) { return true; } else { return false; }
                });
            });
            getData();
            $('#txtsearchTreeView').on('keyup', search);

        });
        function SetValue() {
            $('#<%=txtTreeViewText.ClientID%>').val(_selectedText);
            $('#<%=hdTreeViewValue.ClientID%>').val(_selectedID);

        }
        function ClearValue() {
            $('#<%=txtTreeViewText.ClientID%>').val('');
            $('#<%=hdTreeViewValue.ClientID%>').val('');
        }
        function Disply() {

            alert($('#<%=hdTreeViewValue.ClientID%>').val());
        }
        function getData() {

            $.ajax({
                type: "post",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "frmEmployeeAtDepartment.aspx/GetAllNodes",
                data: "{}"

            }).done(function (data) {
                var myarr = [];
                console.log(data);
                $.each(data.d, function (i, x) {
                    var abc = { id: x.id, text: x.text, selectable: x.selectable, nodes: x.nodes, lazyLoad: true };
                    myarr.push(abc);
                });
                console.log(myarr);
                $searchableTree = $('#treeview2').treeview({
                    levels: 1,
                    data: myarr
                });

                $('#treeview2').on('nodeSelected', function (event, node) {
                    // Your logic goes here

                    console.log(node.id);
                    console.log(node.text);
                    $('#<%=txtTreeViewText.ClientID%>').val(node.text);
                    $('#<%=hdTreeViewValue.ClientID%>').val(node.id);
                    _selectedID = node.id;
                    _selectedText = node.text;

                });
                $('#treeview2').on('nodeExpanded ', function (event, node) {

                });

            }).fail(function (error) {
                console.log(error);
            });
        }


        var search = function (e) {
            var pattern = $('#txtsearchTreeView').val();
            var options = {
                ignoreCase: true,
                exactMatch: false,
                revealResults: true
            };
            var results = $searchableTree.treeview('search', [pattern, options]);
        }


    </script>
    <div id="DivReportingToDialog" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">د توکو تعیرول</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="form-group">
                            <div class="col-sm-2">
                                <label class="control-label" for="email">Search Value:</label>
                            </div>
                            <div class="col-sm-4">
                                <input type="text" id="txtSearchValue" name="txtProduct_Code" placeholder="Employee Name for Search" class="form-control" />
                            </div>
                            <div class="col-sm-4">
                                <button type="button" id="btnSearchReportingTo" onclick="GetReportingToEmp()" class="btn btn-success">Search</button>
                            </div>
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="table-responsive" id="divReportingToList">
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
    <div id="divAdvanceSearch" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Advance Search</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="form-group">
                            <div class="col-sm-2">
                                <label class="control-label">Search Type:</label>
                            </div>
                            <div class="col-sm-6">
                                <asp:DropDownList ID="ddlSearchType" CssClass="form-control" runat="server">
                                    <asp:ListItem Value="1">Search By Name</asp:ListItem>
                                    <asp:ListItem Value="2">Search By Education Grade and Course Type</asp:ListItem>
                                    <asp:ListItem Value="3">Search By Present Address</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <hr />
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
                    <div id="divEducationGrade" style="display: none">
                        <div class="row">
                            <div class="form-group col-md-3 col-sm-3">
                                <label for="name">Chose Education Grade</label>
                                <asp:DropDownList ID="ddlEducationGarde" CssClass="form-control" runat="server"></asp:DropDownList>
                            </div>
                            <div class="form-group col-md-3 col-sm-3">
                                <label for="name">Main Course of Study:</label>
                                <input type="text" id="txtCourseType" name="txtProduct_BarCode" placeholder="Main Course of Study" class="form-control" />
                            </div>
                            <div class="form-group col-md-3 col-sm-3">

                                <label for="name">Specialization</label>
                                <input type="text" id="txtSpecializationName" name="txtProduct_BarCode" placeholder="Specialization" class="form-control" />
                            </div>
                            <div class="form-group col-md-2 col-sm-2">
                                <br />
                                <button type="button" id="btnSearchByEducation" onclick="GetAdvanceSearchByEducation()" class="btn btn-success">Search</button>
                            </div>
                        </div>
                    </div>
                    <div id="DivPresentAddress" style="display: none">
                        <div class="row">
                            <div class="form-group col-md-3 col-sm-3">
                                <label for="name">Province</label>
                                <asp:DropDownList ID="ddlPresentProvince" CssClass="form-control" runat="server"></asp:DropDownList>
                            </div>
                            <div class="form-group col-md-3 col-sm-3">
                                <label for="name">District</label>
                                <select id="ddlPresentDistrict" name="ddlProductCategory" class="form-control"></select>
                            </div>
                            <div class="form-group col-md-3 col-sm-3">

                                <label for="name">City/village</label>
                                <input type="text" id="txtVillage" name="txtProduct_BarCode" placeholder="City/village" class="form-control" />
                            </div>
                            <div class="form-group col-md-2 col-sm-2">
                                <br />
                                <button type="button" id="btnSearchByAddress" onclick="GetAdvanceSearchByAddress()" class="btn btn-success">Search</button>
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
    <script>
        function GetEmployee(EmployeeID) {
            debugger;
            var employeeid = EmployeeID;
            $.ajax({
                type: "post",
                dataType: "JSON",
                contentType: "application/json; charset=utf-8",
                url: 'frmEmployeeAtDepartment.aspx/GetEmployeeInfo',
                data: "{EmpID:'" + employeeid + "'}",
                success: function (data) {
                    $('#<%=hdEmployeeID.ClientID%>').val(data.d[0].Employee_ID);
                    $('#txtName_Local').val(data.d[0].Name);
                    $('#txtFather_Name_Local').val(data.d[0].Father_Name);
                    $('#txtGrand_Father_Name_Local').val(data.d[0].Grand_Father_Name);
                    $('#txtGender').val(data.d[0].Gender);
                    $('#txtMaritalStatus').val(data.d[0].Marital_Status);
                    $('#txtDateOfBirth').val(data.d[0].Date_Of_Birth);
                    $('#txtTazkiraNumber').val(data.d[0].National_ID_Card_NO);
                    $('#imgPhoto').attr('src', data.d[0].Photo);
                    EmpAtDepartmentView(employeeid);
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
                    url: 'frmEmployeeAtDepartment.aspx/GetEmployeeInfo',
                    data: "{EmpID:'" + employeeid + "'}",
                    success: function (data) {
                        $('#<%=hdEmployeeID.ClientID%>').val(data.d[0].Employee_ID);
                        $('#txtName_Local').val(data.d[0].Name);
                        $('#txtFather_Name_Local').val(data.d[0].Father_Name);
                        $('#txtGrand_Father_Name_Local').val(data.d[0].Grand_Father_Name);
                        $('#txtGender').val(data.d[0].Gender);
                        $('#txtMaritalStatus').val(data.d[0].Marital_Status);
                        $('#txtDateOfBirth').val(data.d[0].Date_Of_Birth);
                        $('#txtTazkiraNumber').val(data.d[0].National_ID_Card_NO);
                        $('#imgPhoto').attr('src', data.d[0].Photo);

                        EmpAtDepartmentView(employeeid);
                        //$('#divAdvanceSearch').modal('hide');
                    },
                    failure: function (data) {
                        alert('error occured');
                    }
                });

                //$('#divAdvanceSearch').modal('hide');
                }
                function GetEmployeeBasic(ref) {
                    debugger;
                    var employeeid = $(ref).parent('td').find('#empid').html();
                    $.ajax({
                        type: "post",
                        dataType: "JSON",
                        contentType: "application/json; charset=utf-8",
                        url: 'frmEmployeeAtDepartment.aspx/GetReportingToEmployeeByID',
                        data: "{Employee_ID:'" + employeeid + "'}",
                        success: function (data) {
                            $('#<%=hdReportingTo.ClientID%>').val(data.d[0].Employee_ID);
                            $('#txtReportingTo').val(data.d[0].Name);
                        },
                        failure: function (data) {
                            alert('error occured');
                        }
                    });


                    }
                    function GetReportingToEmp() {
                        var SearchValue = $('#txtSearchValue').val();
                        debugger;
                        $.ajax({
                            type: "POST",
                            url: "frmEmployeeAtDepartment.aspx/GetReportingToEmployee",
                            data: '{EmployeeName:"' + SearchValue + '"}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            async: false,
                            success: function (data) {
                                console.log(data);
                                var tbl = "<div><table class='table table-bordered table-hover'><thead class='thead thead-default' ><th>Employee ID</th><th>Emp Name</th><th>Father Name</th><th>Grand Father Name</th><th>Gender</th><th></th></thead><tbody>";
                                $.each(data.d, function (i, x) {
                                    tbl += "<tr class='table table-warning'>";
                                    tbl += "<td>" + x.Employee_ID + "</td>";
                                    tbl += "<td>" + x.Name + "</td>";
                                    tbl += "<td>" + x.Father_Name + "</td>";
                                    tbl += "<td>" + x.Grand_Father_Name + "</td>";
                                    tbl += "<td>" + x.Gender + "</td>";
                                    tbl += "<td valign='top'><span id='empid' style='display:none'>" + x.Employee_ID + "</span><button type='button' class='btn btn-sm btn-success' onclick='GetEmployeeBasic(this)' data-dismiss='modal'>&nbsp;<i class='glyphicon glyphicon-pencil'></i></button></td>";
                                    tbl += "</tr>";
                                });
                                tbl += "</tbody></table></div>";
                                $('#divReportingToList').html(tbl);

                            },
                            failure: function (response) {
                                alert(response.d);
                            }
                        });
                    }
                    function SaveEmpAtDepartment() {
                        debugger;
                        if ($('#<%=hdEmployeeID.ClientID%>').val() == '') {
                        toastr.error('Chose Employee First', 'Error :');
                        return;
                    }
                    if ($('#<%=ddlPosition.ClientID%>').val() == '') {
                        toastr.error('Position is Required', 'Error :');
                        return;
                    }

                    if ($('#<%=hdTreeViewValue.ClientID%>').val() == '') {
                        toastr.error('Chose Department', 'Error :');
                        return;
                    }


                    var EmployeeID = $('#<%=hdEmployeeID.ClientID%>').val();
                    var Department_ID = $('#<%=hdTreeViewValue.ClientID%>').val();
                    var Position_ID = $('#<%=ddlPosition.ClientID%>').val();
                    var Reporting_To = $('#<%=hdReportingTo.ClientID%>').val();
                    var Status = "Active";
                    var UserID = $('#<%=hdUser.ClientID%>').val();
                    var GroupObj = { Employee_ID: EmployeeID, Department_ID: Department_ID, Position_ID: Position_ID, ReportingTo: Reporting_To, Status: Status, User_ID: UserID };

                    $.ajax({
                        type: "POST",
                        url: "frmEmployeeAtDepartment.aspx/SaveEmpAtDepartment",
                        data: JSON.stringify({ 'Employee': GroupObj }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            if (data) {
                                toastr.success('Data Saved Successfully', 'Success :');
                                EmpAtDepartmentView(EmployeeID);

                            }
                        },
                        failure: function (response) {
                            toastr.error('', 'Error');
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

                function GetAdvanceSearchByName() {
                    var Name = $('#txtSearchByName').val();
                    debugger;
                    var objSO = {
                        Name: Name
                    };
                    $.ajax({
                        type: "POST",
                        url: "frmEmployeeAtDepartment.aspx/EmpAdvanceSearchByName",
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

                function GetAdvanceSearchByEducation() {
                    var Education_Grade_ID = $('#<%=ddlEducationGarde.ClientID%>').val();
                    var Main_Course_of_Study = $('#txtCourseType').val();
                    var Specialization = $('#txtSpecializationName').val();
                    debugger;
                    var objSO = {
                        Education_Grade_ID: Education_Grade_ID, Main_Course_of_Study: Main_Course_of_Study, Specialization: Specialization
                    };
                    $.ajax({
                        type: "POST",
                        url: "frmEmployeeAtDepartment.aspx/EmpAdvanceSearchByEducation",
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


                function GetAdvanceSearchByAddress() {
                    var Present_Province_ID = $('#<%=ddlPresentProvince.ClientID%>').val();
            var Present_District_ID = $('#ddlPresentDistrict').val();
            var Present_Village = $('#txtVillage').val();
            debugger;
            var objSO = {
                Present_Province_ID: Present_Province_ID, Present_District_ID: Present_District_ID, Present_Village: Present_Village
            };
            $.ajax({
                type: "POST",
                url: "frmEmployeeAtDepartment.aspx/EmpAdvanceSearchByAddress",
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

        function EmpAtDepartmentView(EmpNO) {
            $.ajax({
                type: "POST",
                url: "frmEmployeeAtDepartment.aspx/EmpatDepartmentView",
                data: '{EmpNO:"' + EmpNO + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (data) {
                    console.log(data);
                    var tbl = "<div><table class='table table-bordered table-hover'><thead class='thead thead-default'><th>ID</th><th>Department Name</th><th>Department Location</th><th>Position</th><th>Reporting To</th><th>Status</th></thead><tbody>";
                    $.each(data.d, function (i, x) {
                        tbl += "<tr class='table table-warning'>";
                        tbl += "<td>" + x.ID + "</td>";
                        tbl += "<td>" + x.Department_Name + "</td>";
                        tbl += "<td>" + x.Department_Location + "</td>";
                        tbl += "<td>" + x.Position + "</td>";
                        tbl += "<td>" + x.Reporting_To + "</td>";
                        tbl += "<td>" + x.Status + "</td>";
                        tbl += "</tr>";
                    });
                    tbl += "</tbody></table></div>";
                    $('#divatDepartmentList').html(tbl);

                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }
    </script>
</asp:Content>
