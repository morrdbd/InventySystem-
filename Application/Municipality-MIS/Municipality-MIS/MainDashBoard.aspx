<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MainDashBord.Master" AutoEventWireup="true" CodeBehind="MainDashBoard.aspx.cs" Inherits="Municipality_MIS.MainDashBoard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <br />
    <br />

    <div class="row">
        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4" onclick="location.href='Inventory-Pages/frmProduct.aspx';" style="cursor: pointer;">
            <!-- statistic box -->
            <div class="statistic-box statistic-filled-6">
                <h3><span class="count-number">د زیرمو/ګدام</span></h3>
                <div class="small">برخه</div>
                <i class="ti-shopping-cart statistic_icon"></i>
              
            </div>
            <!-- /.statistic box -->
        </div>

        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4" onclick="location.href='HRMIS-Pages/frmEmployeeInformation.aspx';" style="cursor: pointer;">
            <!-- statistic box -->
            <div class="statistic-box statistic-filled-3">
                <h3><span class="count-number">دبشري سرچینې</span></h3>
                <div class="small">برخه</div>

                <i class="ti-user statistic_icon"></i>

            </div>
            <!-- /.statistic box -->
        </div>

        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4" onclick="location.href='IMIS-Pages/frmProductList.aspx';" style="cursor: pointer;">
            <!-- statistic box -->
            <div class="statistic-box statistic-filled-1">
                <h3><span class="count-number">د سند د سمبالولو </span></h3>
                <div class="small">برخه</div>

                <i class="ti-bag statistic_icon"></i>

            </div>
            <!-- /.statistic box -->
        </div>
    </div>

    <div class="row">
        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4" onclick="location.href='IMIS-Pages/frmProductList.aspx';" style="cursor: pointer;">
            <!-- statistic box -->
            <div class="statistic-box statistic-filled-4">
                <h3><span class="count-number">د راپورونو</span></h3>
                <div class="small">برخه</div>
                <i class="ti-clipboard statistic_icon"></i>
            </div>
            <!-- /.statistic box -->
        </div>
        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4" onclick="location.href='IMIS-Pages/frmProductList.aspx';" style="cursor: pointer;">
            <!-- statistic box -->
            <div class="statistic-box statistic-filled-1">
                <h3><span class="count-number">د ډشبورډ راپور ورکولو</span></h3>
                <div class="small">برخه</div>
                <i class="ti-dashboard statistic_icon"></i>

            </div>
            <!-- /.statistic box -->
        </div>

        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4" onclick="location.href='Account/ManageUsers.aspx';" style="cursor: pointer;">
            <!-- statistic box -->
            <div class="statistic-box statistic-filled-2">
                <h3><span class="count-number">د کارن مدیریت کولو</span></h3>
                <div class="small">برخه</div>


                <i class="ti-user statistic_icon"></i>
                <i class="ti-settings statistic_icon"></i>
            </div>
            <!-- /.statistic box -->
        </div>

    </div>


</asp:Content>
