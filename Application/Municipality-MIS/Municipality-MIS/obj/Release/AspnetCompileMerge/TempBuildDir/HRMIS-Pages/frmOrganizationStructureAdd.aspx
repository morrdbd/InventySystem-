<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/HRMIS.Master" AutoEventWireup="true" CodeBehind="frmOrganizationStructureAdd.aspx.cs" Inherits="Municipality_MIS.HRMIS_Pages.frmOrganizationStructureAdd" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <link href="../Scripts/treeview/bootstrap-treeview.css" rel="stylesheet" />
    <h2>Bootstrap Treeview</h2>
    <hr />
    <div class="row">
        <div class="col-lg-4">
            <div class="input-group">
                <span class="input-group-addon">Name</span>
                <asp:TextBox CssClass="form-control nothing" ID="txtTreeViewText" runat="server"></asp:TextBox>
                <span class="input-group-btn">
                    <button type="button" class="btn btn-success" data-toggle="modal" data-target="#treeModal">...</button>
                </span>
            </div>
            <!-- /input-group -->
        </div>
        <!-- /.col-lg-6 -->
    </div>
    <asp:HiddenField ID="hdTreeViewValue" runat="server" />
    <asp:Label ID="lblID" runat="server" Text="Label"></asp:Label>
    
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
            $('#<%=lblID.ClientID%>').val(_selectedID);
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
                url: "frmOrganizationStructureAdd.aspx/GetAllNodes",
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
                    $('#<%=lblID.ClientID%>').val(_selectedID);
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
</asp:Content>
