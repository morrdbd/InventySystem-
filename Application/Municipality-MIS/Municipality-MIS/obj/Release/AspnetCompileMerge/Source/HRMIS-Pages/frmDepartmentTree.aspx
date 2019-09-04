<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/HRMIS.Master" AutoEventWireup="true" CodeBehind="frmDepartmentTree.aspx.cs" Inherits="Municipality_MIS.HRMIS_Pages.frmDepartmentTree" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../Scripts/treeview/bootstrap-treeview.css" rel="stylesheet" />
    <div class="row">
        <div class="col-lg-12 ">
            <div class="panel panel-primary">
                <div class="panel-heading blue-bg"><span style="color: white">د ادری شجری ترتیب کولو فورمه</span></div>
                <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-12 ">
                                    <div class="form-inline">
                                        <label class="control-label">دپلټنه توری واچوی/حرف جستجو</label>
                                        <input type="text" id="txtsearchTreeView" class="form-control" placeholder="د پلټنه توری/حروف ججستجو" />
                                        <button type="button" class="btn btn-danger" id="btn-collapse-all">Collapse All</button>
                                        <button type="button" class="btn btn-danger" id="btn-expand-all">Expand All</button>
                                    </div>
                                </div>
                            </div>
                    <hr />
                    <div class="row">
                        <div style="overflow:auto"  class="col-lg-12">
                            <div id="treeview2"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
   
    <div id="NewNodeModal" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">د نوی بخش اضافه کول</h4>
                </div>
                <div class="modal-body">
                    <div class="form-horizontal">
                        <div class="form-group">
                            <label class="col-md-3" id="lblNodeID"></label>
                            <div class="col-md-6">
                                <label id="lblNodeText" class="form-control"></label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3">د نوی بخش نوم</label>
                            <div class="col-md-6">
                                <input type="text" id="txtNewNodeText" class="form-control" />
                            </div>
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" onclick="AddNewNode()">اضافي کړی</button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal">بندول</button>

                </div>
            </div>
        </div>
    </div>

    <div id="EditNodeModal" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">د بخش تغیرول</h4>
                </div>
                <div class="modal-body">
                    <div class="form-horizontal">
                        <div class="form-group">
                            <label class="col-md-3">د انتخاب شوی بخش شمیره</label>
                            <div class="col-md-6">
                                <label id="lblEditNodeID" class="form-control"></label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3">د بخش نوم</label>
                            <div class="col-md-6">
                                <input type="text" id="txtEditNodeText" class="form-control" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" onclick="UpdateNode()">Update</button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button>

                </div>
            </div>
        </div>
    </div>





    <div style="min-height: 500px">
        &nbsp;
    </div>
    <%--  <style>
        .modal-backdrop
        {
            z-index: -1;
        }
    </style>--%>
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
            getData(1);
            $('#txtsearchTreeView').on('keyup', search);

        });

        function getData(level) {

            $.ajax({
                type: "post",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "frmDepartmentTree.aspx/GetAllNodes",
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
                    levels: level,
                    data: myarr
                });

                $('#treeview2').on('nodeSelected', function (event, node) {
                    // Your logic goes here                                 
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
        var menu = new BootstrapMenu('.node-treeview2', {
            fetchElementData: function ($rowElem) {
                $('#lblNodeID').html($($rowElem).attr('id'));
                $('#lblNodeText').html($rowElem[0].textContent);
                $('#lblEditNodeID').html($($rowElem).attr('id'));
                $('#txtEditNodeText').val($rowElem[0].textContent);

            },
            actions: [{
                name: "Add Child",
                iconClass: 'glyphicon glyphicon-plus-sign',
                classNames: function (row) {
                    // add the 'action-success' class only if the row is editable

                },
                onClick: function (objRef) {
                    $('#NewNodeModal').modal('show');
                }
            }, {
                // custom action name, with the name of the selected user
                name: "Rename Node",
                iconClass: 'glyphicon glyphicon-pencil',
                onClick: function (row) {
                    $('#EditNodeModal').modal('show');
                }
            }]
        });
        function AddNewNode() {
            var nodeid = $('#lblNodeID').html();
            var nodeText = $('#txtNewNodeText').val();
            if (nodeText.trim() != "") {
                $.ajax({
                    type: "post",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    url: "frmDepartmentTree.aspx/AddChildNode",
                    data: "{ParentNodeID:'" + nodeid + "',NodeText:'" + nodeText + "'}"

                }).done(function (data) {
                    getData(99);
                    $('#NewNodeModal').modal('hide');
                    $('#txtNewNodeText').val('');
                });
            }
        }


        function UpdateNode() {
            var nodeid = $('#lblEditNodeID').html();
            var nodeText = $('#txtEditNodeText').val();
            if (nodeText.trim() != "") {
                $.ajax({
                    type: "post",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    url: "frmDepartmentTree.aspx/UpdateNode",
                    data: "{NodeID:'" + nodeid + "',NodeText:'" + nodeText + "'}"

                }).done(function (data) {
                    getData(99);
                    $('#EditNodeModal').modal('hide');
                    $('#txtEditNodeText').val('');
                });
            }
        }
    </script>

</asp:Content>
