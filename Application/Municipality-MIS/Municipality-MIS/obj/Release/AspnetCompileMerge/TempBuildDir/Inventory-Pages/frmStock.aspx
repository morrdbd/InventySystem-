<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Inventory.Master" AutoEventWireup="true" CodeBehind="frmStock.aspx.cs" Inherits="Municipality_MIS.Inventory_Pages.frmStock" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <br />
    <div class="row">
        <div class="col-lg-12 ">
            <div class="panel panel-primary">
                <div class="panel-heading blue-bg"><span style="color: white">په ګدام کی د توکو مقدار</span></div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-12 ">
                            <div class="row">
                                <div class="col-lg-12 ">
                                    <div class="form-inline">
                                        <label class="control-label">پلټنه په  دتوکی په نوم</label>
                                        <asp:TextBox ID="txtSearch" CssClass="form-control" placeholder="دتوکی په نوم"  runat="server"></asp:TextBox>
                                        <asp:Button ID="btnSearch" CssClass="btn btn-primary" runat="server" Text="پلټنه" OnClick="btnSearch_Click" />
                                          <asp:Button ID="btnExport" Visible="true" runat="server" CssClass="btn btn-success"  Text="راپور په اکسل پروګرام کی" OnClick="btnExport_Click" />
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
                                    <asp:GridView ID="grdProduct" CssClass="table table-bordered table-hover" runat="server"></asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
