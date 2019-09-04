<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/HRMIS.Master" AutoEventWireup="true" CodeBehind="FrmOrganizationStructure.aspx.cs" Inherits="Municipality_MIS.HRMIS_Pages.FrmOrganizationStructure" %>

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
    <hr />
    <div class="row">
        <div class="col-lg-12">
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
            <div style="height: 300px; overflow: scroll;">
                <div id="treeview2"></div>
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
        function getData() {
            $.ajax({
                type: "post",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "FrmOrganizationStructure.aspx/GetAllNodes",
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
</asp:Content>
