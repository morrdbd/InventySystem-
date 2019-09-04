<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/HRMIS.Master" AutoEventWireup="true" CodeBehind="frmEmployeeView.aspx.cs" Inherits="Municipality_MIS.HRMIS_Pages.frmEmployeeView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-lg-12 ">
            <div class="panel panel-primary">
                <div class="panel-heading bg-warning"><span style="color: white">د کارمند لړ لیست/لسیت کارمند</span></div>
                <div class="panel-body">
                    <div class="row">
                        <div class="form-group">
                            <div class="col-sm-2">
                                <label class="control-label" for="email">پلټنه په نوم</label>
                            </div>
                            <div class="col-sm-4">
                                <input type="text" id="txtSearch" name="txtProduct_Code" placeholder="پلټنه توری/حرف جستجو" class="form-control" />
                            </div>
                            <div class="col-sm-4">
                                <button type="button" id="btnSearch" onclick="GetReportingToEmpByName();" class="btn btn-success">پلټنه</button>
                            </div>
                        </div>
                    </div>
                    <hr />
                    <div style="height:300px" class="row">
                        <div class="col-lg-12">
                            <div class="table-responsive" id="divatDepartmentList">
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
                    <h4 class="modal-title">د کارمند انځور/عکس کارمند</h4>
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
    <script type="text/javascript">
        $(function () {
            GetReportingToEmpAll();
        });

        function ShowImage(ref) {
            debugger;
            var employeeid = $(ref).parent('td').find('#PhotoPath').html();
            $('#ImgProduct').attr('src', employeeid);
            $('#ShowImage').modal('show');
        }

        function GetReportingToEmpAll() {

            debugger;
            $.ajax({
                type: "POST",
                url: "frmEmployeeView.aspx/EmpatDepartmentViewAll",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (data) {
                    console.log(data);
                    var tbl = "<div><table class='table table-bordered table-hover'><thead class='thead thead-default' ><th>شمیره/شماره</th><th>نوم/اسم</th><th>پلار نوم/اسم پدر</th><th>څانګه/بخش</th><th>دنده/وظیفه</th><th>مربوطه امیر/امیر مربوطه</th><th>حالت</th><th></th></thead><tbody>";
                    $.each(data.d, function (i, x) {
                        tbl += "<tr class='table table-warning'>";
                        tbl += "<td>" + x.Employee_ID + "</td>";
                        tbl += "<td>" + x.Name + "</td>";
                        tbl += "<td>" + x.FName + "</td>";
                        tbl += "<td>" + x.Department_Name + "</td>";
                        tbl += "<td>" + x.Position + "</td>";
                        tbl += "<td>" + x.Reporting_To + "</td>";
                        tbl += "<td>" + x.Status + "</td>";
                        tbl += "<td valign='top'><span id='empid' style='display:none'>" + x.Employee_ID + "</span><span class='btn btn-danger' onclick='ShowImage(this);'><i class='glyphicon glyphicon-eye-open' ></i></span>";
                        tbl += "<span id='PhotoPath' style='display:none'>" + x.Photo + "</span><span class='btn btn-success' onclick='showEditModalProduct(this)'><i class='glyphicon glyphicon-pencil'></i></span></td>";
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

        function GetReportingToEmpByName() {
            var SearchValue = $('#txtSearch').val();
            debugger;
            $.ajax({
                type: "POST",
                url: "frmEmployeeView.aspx/EmpatDepartmentViewByName",
                data: "{EmpName:'" + SearchValue + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (data) {
                    console.log(data);
                    var tbl = "<div><table class='table table-bordered table-hover'><thead class='thead thead-default' ><th>شمیره/شماره</th><th>نوم/اسم</th><th>پلار نوم/اسم پدر</th><th>څانګه/بخش</th><th>دنده/وظیفه</th><th>مربوطه امیر/امیر مربوطه</th><th>حالت</th><th></th></thead><tbody>";
                    $.each(data.d, function (i, x) {
                        tbl += "<tr class='table table-warning'>";
                        tbl += "<td>" + x.Employee_ID + "</td>";
                        tbl += "<td>" + x.Name + "</td>";
                        tbl += "<td>" + x.FName + "</td>";
                        tbl += "<td>" + x.Department_Name + "</td>";
                        tbl += "<td>" + x.Position + "</td>";
                        tbl += "<td>" + x.Reporting_To + "</td>";
                        tbl += "<td>" + x.Status + "</td>";
                        tbl += "<td valign='top'><span id='empid' style='display:none'>" + x.Employee_ID + "</span><span class='btn btn-danger' onclick='ShowImage(this);'><i class='glyphicon glyphicon-eye-open' ></i></span>";
                        tbl += "<span id='PhotoPath' style='display:none'>" + x.Photo + "</span><span class='btn btn-success' onclick='showEditModalProduct(this)'><i class='glyphicon glyphicon-pencil'></i></span></td>";
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
