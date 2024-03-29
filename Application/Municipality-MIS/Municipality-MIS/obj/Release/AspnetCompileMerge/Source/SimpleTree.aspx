﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SimpleTree.aspx.cs" Inherits="Municipality_MIS.SimpleTree" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Scripts/SimpleTree/bootstrap-treeview.min.css" rel="stylesheet" />
    <link href="Scripts/SimpleTree/bootstrap.css" rel="stylesheet" />
    <script src="Scripts/SimpleTree/jquery.js"></script>
    <script src="Scripts/SimpleTree/bootstrap-treeview.min.js"></script>

 <script type="text/javascript">

     $(function () {
         var defaultData = [
           {
               text: 'Parent 1',
               href: '#parent1',
               tags: ['4'],
               nodes: [
                 {
                     text: 'Child 1',
                     href: '#child1',
                     tags: ['2'],
                     nodes: [
                       {
                           text: 'Grandchild 1',
                           href: '#grandchild1',
                           tags: ['0']
                       },
                       {
                           text: 'Grandchild 2',
                           href: '#grandchild2',
                           tags: ['0']
                       }
                     ]
                 },
                 {
                     text: 'Child 2',
                     href: '#child2',
                     tags: ['0']
                 }
               ]
           },
           {
               text: 'Parent 2',
               href: '#parent2',
               tags: ['0']
           },
           {
               text: 'Parent 3',
               href: '#parent3',
               tags: ['0']
           },
           {
               text: 'Parent 4',
               href: '#parent4',
               tags: ['0']
           },
           {
               text: 'Parent 5',
               href: '#parent5',
               tags: ['0']
           }
         ];

         var alternateData = [
           {
               text: 'Parent 1',
               tags: ['2'],
               nodes: [
                 {
                     text: 'Child 1',
                     tags: ['3'],
                     nodes: [
                       {
                           text: 'Grandchild 1',
                           tags: ['6']
                       },
                       {
                           text: 'Grandchild 2',
                           tags: ['3']
                       }
                     ]
                 },
                 {
                     text: 'Child 2',
                     tags: ['3']
                 }
               ]
           },
           {
               text: 'Parent 2',
               tags: ['7']
           },
           {
               text: 'Parent 3',
               icon: 'glyphicon glyphicon-earphone',
               href: '#demo',
               tags: ['11']
           },
           {
               text: 'Parent 4',
               icon: 'glyphicon glyphicon-cloud-download',
               href: '/demo.html',
               tags: ['19'],
               selected: true
           },
           {
               text: 'Parent 5',
               icon: 'glyphicon glyphicon-certificate',
               color: 'pink',
               backColor: 'red',
               href: 'http://www.tesco.com',
               tags: ['available', '0']
           }
         ];

         var json = '[' +
           '{' +
             '"text": "Parent 1",' +
             '"nodes": [' +
               '{' +
                 '"text": "Child 1",' +
                 '"nodes": [' +
                   '{' +
                     '"text": "Grandchild 1"' +
                   '},' +
                   '{' +
                     '"text": "Grandchild 2"' +
                   '}' +
                 ']' +
               '},' +
               '{' +
                 '"text": "Child 2"' +
               '}' +
             ']' +
           '},' +
           '{' +
             '"text": "Parent 2"' +
           '},' +
           '{' +
             '"text": "Parent 3"' +
           '},' +
           '{' +
             '"text": "Parent 4"' +
           '},' +
           '{' +
             '"text": "Parent 5"' +
           '}' +
         ']';


         $('#treeview1').treeview({
             data: defaultData
         });

         $('#treeview2').treeview({
             levels: 1,
             data: defaultData
         });

         $('#treeview3').treeview({
             levels: 99,
             data: defaultData
         });

         $('#treeview4').treeview({

             color: "#428bca",
             data: defaultData
         });

         $('#treeview5').treeview({
             color: "#428bca",
             expandIcon: 'glyphicon glyphicon-chevron-right',
             collapseIcon: 'glyphicon glyphicon-chevron-down',
             nodeIcon: 'glyphicon glyphicon-bookmark',
             data: defaultData
         });

         $('#treeview6').treeview({
             color: "#428bca",
             expandIcon: "glyphicon glyphicon-stop",
             collapseIcon: "glyphicon glyphicon-unchecked",
             nodeIcon: "glyphicon glyphicon-user",
             showTags: true,
             data: defaultData
         });

         $('#treeview7').treeview({
             color: "#428bca",
             showBorder: false,
             data: defaultData
         });

         $('#treeview8').treeview({
             expandIcon: "glyphicon glyphicon-stop",
             collapseIcon: "glyphicon glyphicon-unchecked",
             nodeIcon: "glyphicon glyphicon-user",
             color: "yellow",
             backColor: "purple",
             onhoverColor: "orange",
             borderColor: "red",
             showBorder: false,
             showTags: true,
             highlightSelected: true,
             selectedColor: "yellow",
             selectedBackColor: "darkorange",
             data: defaultData
         });

         $('#treeview9').treeview({
             expandIcon: "glyphicon glyphicon-stop",
             collapseIcon: "glyphicon glyphicon-unchecked",
             nodeIcon: "glyphicon glyphicon-user",
             color: "yellow",
             backColor: "purple",
             onhoverColor: "orange",
             borderColor: "red",
             showBorder: false,
             showTags: true,
             highlightSelected: true,
             selectedColor: "yellow",
             selectedBackColor: "darkorange",
             data: alternateData
         });

         $('#treeview10').treeview({
             color: "#428bca",
             enableLinks: true,
             data: defaultData
         });



         var $searchableTree = $('#treeview-searchable').treeview({
             data: defaultData,
         });

         var search = function (e) {
             var pattern = $('#input-search').val();
             var options = {
                 ignoreCase: $('#chk-ignore-case').is(':checked'),
                 exactMatch: $('#chk-exact-match').is(':checked'),
                 revealResults: $('#chk-reveal-results').is(':checked')
             };
             var results = $searchableTree.treeview('search', [pattern, options]);

             var output = '<p>' + results.length + ' matches found</p>';
             $.each(results, function (index, result) {
                 output += '<p>- ' + result.text + '</p>';
             });
             $('#search-output').html(output);
         }

         $('#btn-search').on('click', search);
         $('#input-search').on('keyup', search);

         $('#btn-clear-search').on('click', function (e) {
             $searchableTree.treeview('clearSearch');
             $('#input-search').val('');
             $('#search-output').html('');
         });


         var initSelectableTree = function () {
             return $('#treeview-selectable').treeview({
                 data: defaultData,
                 multiSelect: $('#chk-select-multi').is(':checked'),
                 onNodeSelected: function (event, node) {
                     $('#selectable-output').prepend('<p>' + node.text + ' was selected</p>');
                 },
                 onNodeUnselected: function (event, node) {
                     $('#selectable-output').prepend('<p>' + node.text + ' was unselected</p>');
                 }
             });
         };
         var $selectableTree = initSelectableTree();

         var findSelectableNodes = function () {
             return $selectableTree.treeview('search', [$('#input-select-node').val(), { ignoreCase: false, exactMatch: false }]);
         };
         var selectableNodes = findSelectableNodes();

         $('#chk-select-multi:checkbox').on('change', function () {
             console.log('multi-select change');
             $selectableTree = initSelectableTree();
             selectableNodes = findSelectableNodes();
         });

         // Select/unselect/toggle nodes
         $('#input-select-node').on('keyup', function (e) {
             selectableNodes = findSelectableNodes();
             $('.select-node').prop('disabled', !(selectableNodes.length >= 1));
         });

         $('#btn-select-node.select-node').on('click', function (e) {
             $selectableTree.treeview('selectNode', [selectableNodes, { silent: $('#chk-select-silent').is(':checked') }]);
         });

         $('#btn-unselect-node.select-node').on('click', function (e) {
             $selectableTree.treeview('unselectNode', [selectableNodes, { silent: $('#chk-select-silent').is(':checked') }]);
         });

         $('#btn-toggle-selected.select-node').on('click', function (e) {
             $selectableTree.treeview('toggleNodeSelected', [selectableNodes, { silent: $('#chk-select-silent').is(':checked') }]);
         });



         var $expandibleTree = $('#treeview-expandible').treeview({
             data: defaultData,
             onNodeCollapsed: function (event, node) {
                 $('#expandible-output').prepend('<p>' + node.text + ' was collapsed</p>');
             },
             onNodeExpanded: function (event, node) {
                 $('#expandible-output').prepend('<p>' + node.text + ' was expanded</p>');
             }
         });

         var findExpandibleNodess = function () {
             return $expandibleTree.treeview('search', [$('#input-expand-node').val(), { ignoreCase: false, exactMatch: false }]);
         };
         var expandibleNodes = findExpandibleNodess();

         // Expand/collapse/toggle nodes
         $('#input-expand-node').on('keyup', function (e) {
             expandibleNodes = findExpandibleNodess();
             $('.expand-node').prop('disabled', !(expandibleNodes.length >= 1));
         });

         $('#btn-expand-node.expand-node').on('click', function (e) {
             var levels = $('#select-expand-node-levels').val();
             $expandibleTree.treeview('expandNode', [expandibleNodes, { levels: levels, silent: $('#chk-expand-silent').is(':checked') }]);
         });

         $('#btn-collapse-node.expand-node').on('click', function (e) {
             $expandibleTree.treeview('collapseNode', [expandibleNodes, { silent: $('#chk-expand-silent').is(':checked') }]);
         });

         $('#btn-toggle-expanded.expand-node').on('click', function (e) {
             $expandibleTree.treeview('toggleNodeExpanded', [expandibleNodes, { silent: $('#chk-expand-silent').is(':checked') }]);
         });

         // Expand/collapse all
         $('#btn-expand-all').on('click', function (e) {
             var levels = $('#select-expand-all-levels').val();
             $expandibleTree.treeview('expandAll', { levels: levels, silent: $('#chk-expand-silent').is(':checked') });
         });

         $('#btn-collapse-all').on('click', function (e) {
             $expandibleTree.treeview('collapseAll', { silent: $('#chk-expand-silent').is(':checked') });
         });



         var $checkableTree = $('#treeview-checkable').treeview({
             data: defaultData,
             showIcon: false,
             showCheckbox: true,
             onNodeChecked: function (event, node) {
                 $('#checkable-output').prepend('<p>' + node.text + ' was checked</p>');
             },
             onNodeUnchecked: function (event, node) {
                 $('#checkable-output').prepend('<p>' + node.text + ' was unchecked</p>');
             }
         });

         var findCheckableNodess = function () {
             return $checkableTree.treeview('search', [$('#input-check-node').val(), { ignoreCase: false, exactMatch: false }]);
         };
         var checkableNodes = findCheckableNodess();

         // Check/uncheck/toggle nodes
         $('#input-check-node').on('keyup', function (e) {
             checkableNodes = findCheckableNodess();
             $('.check-node').prop('disabled', !(checkableNodes.length >= 1));
         });

         $('#btn-check-node.check-node').on('click', function (e) {
             $checkableTree.treeview('checkNode', [checkableNodes, { silent: $('#chk-check-silent').is(':checked') }]);
         });

         $('#btn-uncheck-node.check-node').on('click', function (e) {
             $checkableTree.treeview('uncheckNode', [checkableNodes, { silent: $('#chk-check-silent').is(':checked') }]);
         });

         $('#btn-toggle-checked.check-node').on('click', function (e) {
             $checkableTree.treeview('toggleNodeChecked', [checkableNodes, { silent: $('#chk-check-silent').is(':checked') }]);
         });

         // Check/uncheck all
         $('#btn-check-all').on('click', function (e) {
             $checkableTree.treeview('checkAll', { silent: $('#chk-check-silent').is(':checked') });
         });

         $('#btn-uncheck-all').on('click', function (e) {
             $checkableTree.treeview('uncheckAll', { silent: $('#chk-check-silent').is(':checked') });
         });



         var $disabledTree = $('#treeview-disabled').treeview({
             data: defaultData,
             onNodeDisabled: function (event, node) {
                 $('#disabled-output').prepend('<p>' + node.text + ' was disabled</p>');
             },
             onNodeEnabled: function (event, node) {
                 $('#disabled-output').prepend('<p>' + node.text + ' was enabled</p>');
             },
             onNodeCollapsed: function (event, node) {
                 $('#disabled-output').prepend('<p>' + node.text + ' was collapsed</p>');
             },
             onNodeUnchecked: function (event, node) {
                 $('#disabled-output').prepend('<p>' + node.text + ' was unchecked</p>');
             },
             onNodeUnselected: function (event, node) {
                 $('#disabled-output').prepend('<p>' + node.text + ' was unselected</p>');
             }
         });

         var findDisabledNodes = function () {
             return $disabledTree.treeview('search', [$('#input-disable-node').val(), { ignoreCase: false, exactMatch: false }]);
         };
         var disabledNodes = findDisabledNodes();

         // Expand/collapse/toggle nodes
         $('#input-disable-node').on('keyup', function (e) {
             disabledNodes = findDisabledNodes();
             $('.disable-node').prop('disabled', !(disabledNodes.length >= 1));
         });

         $('#btn-disable-node.disable-node').on('click', function (e) {
             $disabledTree.treeview('disableNode', [disabledNodes, { silent: $('#chk-disable-silent').is(':checked') }]);
         });

         $('#btn-enable-node.disable-node').on('click', function (e) {
             $disabledTree.treeview('enableNode', [disabledNodes, { silent: $('#chk-disable-silent').is(':checked') }]);
         });

         $('#btn-toggle-disabled.disable-node').on('click', function (e) {
             $disabledTree.treeview('toggleNodeDisabled', [disabledNodes, { silent: $('#chk-disable-silent').is(':checked') }]);
         });

         // Expand/collapse all
         $('#btn-disable-all').on('click', function (e) {
             $disabledTree.treeview('disableAll', { silent: $('#chk-disable-silent').is(':checked') });
         });

         $('#btn-enable-all').on('click', function (e) {
             $disabledTree.treeview('enableAll', { silent: $('#chk-disable-silent').is(':checked') });
         });



         var $tree = $('#treeview12').treeview({
             data: json
         });
     });
  	</script>

</head>
<body>
    <form id="form1" runat="server">
   <div class="container">
    	<h1>Bootstrap Tree View</h1>
      <br>
      <div class="row">
        <div class="col-sm-4">
          <h2>Default</h2>
          <div id="treeview1" class="treeview"><ul class="list-group"><li class="list-group-item node-treeview1" data-nodeid="0" style="color:undefined;background-color:undefined;"><span class="icon expand-icon glyphicon glyphicon-minus"></span><span class="icon node-icon"></span>Parent 1</li><li class="list-group-item node-treeview1" data-nodeid="1" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="icon expand-icon glyphicon glyphicon-plus"></span><span class="icon node-icon"></span>Child 1</li><li class="list-group-item node-treeview1" data-nodeid="4" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="icon glyphicon"></span><span class="icon node-icon"></span>Child 2</li><li class="list-group-item node-treeview1" data-nodeid="5" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 2</li><li class="list-group-item node-treeview1" data-nodeid="6" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 3</li><li class="list-group-item node-treeview1" data-nodeid="7" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 4</li><li class="list-group-item node-treeview1" data-nodeid="8" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 5</li></ul></div>
        </div>
        <div class="col-sm-4">
          <h2>Collapsed</h2>
          <div id="treeview2" class="treeview"><ul class="list-group"><li class="list-group-item node-treeview2" data-nodeid="0" style="color:undefined;background-color:undefined;"><span class="icon expand-icon glyphicon glyphicon-minus"></span><span class="icon node-icon"></span>Parent 1</li><li class="list-group-item node-treeview2" data-nodeid="1" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="icon expand-icon glyphicon glyphicon-minus"></span><span class="icon node-icon"></span>Child 1</li><li class="list-group-item node-treeview2" data-nodeid="2" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="indent"></span><span class="icon glyphicon"></span><span class="icon node-icon"></span>Grandchild 1</li><li class="list-group-item node-treeview2" data-nodeid="3" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="indent"></span><span class="icon glyphicon"></span><span class="icon node-icon"></span>Grandchild 2</li><li class="list-group-item node-treeview2" data-nodeid="4" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="icon glyphicon"></span><span class="icon node-icon"></span>Child 2</li><li class="list-group-item node-treeview2" data-nodeid="5" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 2</li><li class="list-group-item node-treeview2" data-nodeid="6" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 3</li><li class="list-group-item node-treeview2" data-nodeid="7" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 4</li><li class="list-group-item node-treeview2 node-selected" data-nodeid="8" style="color:#FFFFFF;background-color:#428bca;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 5</li></ul></div>
        </div>
        <div class="col-sm-4">
          <h2>Expanded</h2>
          <div id="treeview3" class="treeview"><ul class="list-group"><li class="list-group-item node-treeview3" data-nodeid="0" style="color:undefined;background-color:undefined;"><span class="icon expand-icon glyphicon glyphicon-minus"></span><span class="icon node-icon"></span>Parent 1</li><li class="list-group-item node-treeview3" data-nodeid="1" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="icon expand-icon glyphicon glyphicon-minus"></span><span class="icon node-icon"></span>Child 1</li><li class="list-group-item node-treeview3" data-nodeid="2" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="indent"></span><span class="icon glyphicon"></span><span class="icon node-icon"></span>Grandchild 1</li><li class="list-group-item node-treeview3" data-nodeid="3" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="indent"></span><span class="icon glyphicon"></span><span class="icon node-icon"></span>Grandchild 2</li><li class="list-group-item node-treeview3" data-nodeid="4" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="icon glyphicon"></span><span class="icon node-icon"></span>Child 2</li><li class="list-group-item node-treeview3" data-nodeid="5" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 2</li><li class="list-group-item node-treeview3" data-nodeid="6" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 3</li><li class="list-group-item node-treeview3" data-nodeid="7" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 4</li><li class="list-group-item node-treeview3" data-nodeid="8" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 5</li></ul></div>
        </div>
      </div>
      <div class="row">
        <div class="col-sm-4">
          <h2>Blue Theme</h2>
          <div id="treeview4" class="treeview"><ul class="list-group"><li class="list-group-item node-treeview4" data-nodeid="0" style="color:undefined;background-color:undefined;"><span class="icon expand-icon glyphicon glyphicon-minus"></span><span class="icon node-icon"></span>Parent 1</li><li class="list-group-item node-treeview4" data-nodeid="1" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="icon expand-icon glyphicon glyphicon-plus"></span><span class="icon node-icon"></span>Child 1</li><li class="list-group-item node-treeview4" data-nodeid="4" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="icon glyphicon"></span><span class="icon node-icon"></span>Child 2</li><li class="list-group-item node-treeview4" data-nodeid="5" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 2</li><li class="list-group-item node-treeview4" data-nodeid="6" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 3</li><li class="list-group-item node-treeview4" data-nodeid="7" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 4</li><li class="list-group-item node-treeview4" data-nodeid="8" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 5</li></ul></div>
        </div>
        <div class="col-sm-4">
          <h2>Custom Icons</h2>
          <div id="treeview5" class="treeview"><ul class="list-group"><li class="list-group-item node-treeview5" data-nodeid="0" style="color:undefined;background-color:undefined;"><span class="icon expand-icon glyphicon glyphicon-chevron-down"></span><span class="icon node-icon glyphicon glyphicon-bookmark"></span>Parent 1</li><li class="list-group-item node-treeview5" data-nodeid="1" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="icon expand-icon glyphicon glyphicon-chevron-down"></span><span class="icon node-icon glyphicon glyphicon-bookmark"></span>Child 1</li><li class="list-group-item node-treeview5 node-selected" data-nodeid="2" style="color:#FFFFFF;background-color:#428bca;"><span class="indent"></span><span class="indent"></span><span class="icon glyphicon"></span><span class="icon node-icon glyphicon glyphicon-bookmark"></span>Grandchild 1</li><li class="list-group-item node-treeview5" data-nodeid="3" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="indent"></span><span class="icon glyphicon"></span><span class="icon node-icon glyphicon glyphicon-bookmark"></span>Grandchild 2</li><li class="list-group-item node-treeview5" data-nodeid="4" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="icon glyphicon"></span><span class="icon node-icon glyphicon glyphicon-bookmark"></span>Child 2</li><li class="list-group-item node-treeview5" data-nodeid="5" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon glyphicon glyphicon-bookmark"></span>Parent 2</li><li class="list-group-item node-treeview5" data-nodeid="6" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon glyphicon glyphicon-bookmark"></span>Parent 3</li><li class="list-group-item node-treeview5" data-nodeid="7" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon glyphicon glyphicon-bookmark"></span>Parent 4</li><li class="list-group-item node-treeview5" data-nodeid="8" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon glyphicon glyphicon-bookmark"></span>Parent 5</li></ul></div>
        </div>
        <div class="col-sm-4">
          <h2>Tags as Badges</h2>
          <div id="treeview6" class="treeview"><ul class="list-group"><li class="list-group-item node-treeview6" data-nodeid="0" style="color:undefined;background-color:undefined;"><span class="icon expand-icon glyphicon glyphicon-unchecked"></span><span class="icon node-icon glyphicon glyphicon-user"></span>Parent 1<span class="badge">4</span></li><li class="list-group-item node-treeview6" data-nodeid="1" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="icon expand-icon glyphicon glyphicon-stop"></span><span class="icon node-icon glyphicon glyphicon-user"></span>Child 1<span class="badge">2</span></li><li class="list-group-item node-treeview6" data-nodeid="4" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="icon glyphicon"></span><span class="icon node-icon glyphicon glyphicon-user"></span>Child 2<span class="badge">0</span></li><li class="list-group-item node-treeview6" data-nodeid="5" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon glyphicon glyphicon-user"></span>Parent 2<span class="badge">0</span></li><li class="list-group-item node-treeview6" data-nodeid="6" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon glyphicon glyphicon-user"></span>Parent 3<span class="badge">0</span></li><li class="list-group-item node-treeview6" data-nodeid="7" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon glyphicon glyphicon-user"></span>Parent 4<span class="badge">0</span></li><li class="list-group-item node-treeview6" data-nodeid="8" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon glyphicon glyphicon-user"></span>Parent 5<span class="badge">0</span></li></ul></div>
        </div>
      </div>
      <div class="row">
        <div class="col-sm-4">
          <h2>No Border</h2>
          <div id="treeview7" class="treeview"><ul class="list-group"><li class="list-group-item node-treeview7" data-nodeid="0" style="color:undefined;background-color:undefined;"><span class="icon expand-icon glyphicon glyphicon-minus"></span><span class="icon node-icon"></span>Parent 1</li><li class="list-group-item node-treeview7" data-nodeid="1" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="icon expand-icon glyphicon glyphicon-plus"></span><span class="icon node-icon"></span>Child 1</li><li class="list-group-item node-treeview7" data-nodeid="4" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="icon glyphicon"></span><span class="icon node-icon"></span>Child 2</li><li class="list-group-item node-treeview7" data-nodeid="5" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 2</li><li class="list-group-item node-treeview7" data-nodeid="6" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 3</li><li class="list-group-item node-treeview7" data-nodeid="7" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 4</li><li class="list-group-item node-treeview7" data-nodeid="8" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 5</li></ul></div>
        </div>
        <div class="col-sm-4">
          <h2>Colourful</h2>
          <div id="treeview8" class="treeview"><ul class="list-group"><li class="list-group-item node-treeview8" data-nodeid="0" style="color:undefined;background-color:undefined;"><span class="icon expand-icon glyphicon glyphicon-unchecked"></span><span class="icon node-icon glyphicon glyphicon-user"></span>Parent 1<span class="badge">4</span></li><li class="list-group-item node-treeview8" data-nodeid="1" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="icon expand-icon glyphicon glyphicon-stop"></span><span class="icon node-icon glyphicon glyphicon-user"></span>Child 1<span class="badge">2</span></li><li class="list-group-item node-treeview8" data-nodeid="4" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="icon glyphicon"></span><span class="icon node-icon glyphicon glyphicon-user"></span>Child 2<span class="badge">0</span></li><li class="list-group-item node-treeview8" data-nodeid="5" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon glyphicon glyphicon-user"></span>Parent 2<span class="badge">0</span></li><li class="list-group-item node-treeview8" data-nodeid="6" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon glyphicon glyphicon-user"></span>Parent 3<span class="badge">0</span></li><li class="list-group-item node-treeview8" data-nodeid="7" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon glyphicon glyphicon-user"></span>Parent 4<span class="badge">0</span></li><li class="list-group-item node-treeview8" data-nodeid="8" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon glyphicon glyphicon-user"></span>Parent 5<span class="badge">0</span></li></ul></div>
        </div>
        <div class="col-sm-4">
          <h2>Node Overrides</h2>
          <div id="treeview9" class="treeview"><ul class="list-group"><li class="list-group-item node-treeview9" data-nodeid="0" style="color:undefined;background-color:undefined;"><span class="icon expand-icon glyphicon glyphicon-unchecked"></span><span class="icon node-icon glyphicon glyphicon-user"></span>Parent 1<span class="badge">2</span></li><li class="list-group-item node-treeview9" data-nodeid="1" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="icon expand-icon glyphicon glyphicon-stop"></span><span class="icon node-icon glyphicon glyphicon-user"></span>Child 1<span class="badge">3</span></li><li class="list-group-item node-treeview9" data-nodeid="4" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="icon glyphicon"></span><span class="icon node-icon glyphicon glyphicon-user"></span>Child 2<span class="badge">3</span></li><li class="list-group-item node-treeview9" data-nodeid="5" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon glyphicon glyphicon-user"></span>Parent 2<span class="badge">7</span></li><li class="list-group-item node-treeview9" data-nodeid="6" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon glyphicon glyphicon-earphone"></span>Parent 3<span class="badge">11</span></li><li class="list-group-item node-treeview9" data-nodeid="7" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon glyphicon glyphicon-cloud-download"></span>Parent 4<span class="badge">19</span></li><li class="list-group-item node-treeview9" data-nodeid="8" style="color:pink;background-color:red;"><span class="icon glyphicon"></span><span class="icon node-icon glyphicon glyphicon-certificate"></span>Parent 5<span class="badge">available</span><span class="badge">0</span></li></ul></div>
        </div>
      </div>
      <div class="row">
        <div class="col-sm-4">
          <h2>Link enabled, or</h2>
          <div id="treeview10" class="treeview"><ul class="list-group"><li class="list-group-item node-treeview10" data-nodeid="0" style="color:undefined;background-color:undefined;"><span class="icon expand-icon glyphicon glyphicon-minus"></span><span class="icon node-icon"></span><a href="#parent1" style="color:inherit;">Parent 1</a></li><li class="list-group-item node-treeview10" data-nodeid="1" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="icon expand-icon glyphicon glyphicon-plus"></span><span class="icon node-icon"></span><a href="#child1" style="color:inherit;">Child 1</a></li><li class="list-group-item node-treeview10" data-nodeid="4" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="icon glyphicon"></span><span class="icon node-icon"></span><a href="#child2" style="color:inherit;">Child 2</a></li><li class="list-group-item node-treeview10" data-nodeid="5" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span><a href="#parent2" style="color:inherit;">Parent 2</a></li><li class="list-group-item node-treeview10" data-nodeid="6" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span><a href="#parent3" style="color:inherit;">Parent 3</a></li><li class="list-group-item node-treeview10" data-nodeid="7" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span><a href="#parent4" style="color:inherit;">Parent 4</a></li><li class="list-group-item node-treeview10" data-nodeid="8" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span><a href="#parent5" style="color:inherit;">Parent 5</a></li></ul></div>
        </div>
        <div class="col-sm-4">

        </div>
        <div class="col-sm-4">

        </div>
      </div>
      <div class="row">
        <hr>
        <h2>Searchable Tree</h2>
        <div class="col-sm-4">
          <h2>Input</h2>
          <!-- <form> -->
            <div class="form-group">
              <label for="input-search" class="sr-only">Search Tree:</label>
              <input type="input" class="form-control" id="input-search" placeholder="Type to search..." value="">
            </div>
            <div class="checkbox">
              <label>
                <input type="checkbox" class="checkbox" id="chk-ignore-case" value="false">
                Ignore Case
              </label>
            </div>
            <div class="checkbox">
              <label>
                <input type="checkbox" class="checkbox" id="chk-exact-match" value="false">
                Exact Match
              </label>
            </div>
            <div class="checkbox">
              <label>
                <input type="checkbox" class="checkbox" id="chk-reveal-results" value="false">
                Reveal Results
              </label>
            </div>
            <button type="button" class="btn btn-success" id="btn-search">Search</button>
            <button type="button" class="btn btn-default" id="btn-clear-search">Clear</button>
          <!-- </form> -->
        </div>
        <div class="col-sm-4">
          <h2>Tree</h2>
          <div id="treeview-searchable" class="treeview"><ul class="list-group"><li class="list-group-item node-treeview-searchable" data-nodeid="0" style="color:undefined;background-color:undefined;"><span class="icon expand-icon glyphicon glyphicon-minus"></span><span class="icon node-icon"></span>Parent 1</li><li class="list-group-item node-treeview-searchable" data-nodeid="1" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="icon expand-icon glyphicon glyphicon-plus"></span><span class="icon node-icon"></span>Child 1</li><li class="list-group-item node-treeview-searchable" data-nodeid="4" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="icon glyphicon"></span><span class="icon node-icon"></span>Child 2</li><li class="list-group-item node-treeview-searchable" data-nodeid="5" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 2</li><li class="list-group-item node-treeview-searchable" data-nodeid="6" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 3</li><li class="list-group-item node-treeview-searchable" data-nodeid="7" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 4</li><li class="list-group-item node-treeview-searchable" data-nodeid="8" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 5</li></ul></div>
        </div>
        <div class="col-sm-4">
          <h2>Results</h2>
          <div id="search-output"></div>
        </div>
      </div>
      <div class="row">
        <hr>
        <h2>Selectable Tree</h2>
        <div class="col-sm-4">
          <h2>Input</h2>
          <div class="form-group">
            <label for="input-select-node" class="sr-only">Search Tree:</label>
            <input type="input" class="form-control" id="input-select-node" placeholder="Identify node..." value="Parent 1">
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" class="checkbox" id="chk-select-multi" value="false">
              Multi Select
            </label>
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" class="checkbox" id="chk-select-silent" value="false">
              Silent (No events)
            </label>
          </div>
          <div class="form-group">
              <button type="button" class="btn btn-success select-node" id="btn-select-node">Select Node</button>
          </div>
          <div class="form-group">
            <button type="button" class="btn btn-danger select-node" id="btn-unselect-node">Unselect Node</button>
          </div>
          <div class="form-group">
            <button type="button" class="btn btn-primary select-node" id="btn-toggle-selected">Toggle Node</button>
          </div>
        </div>
        <div class="col-sm-4">
          <h2>Tree</h2>
          <div id="treeview-selectable" class="treeview"><ul class="list-group"><li class="list-group-item node-treeview-selectable search-result" data-nodeid="0" style="color:#D9534F;background-color:undefined;"><span class="icon expand-icon glyphicon glyphicon-minus"></span><span class="icon node-icon"></span>Parent 1</li><li class="list-group-item node-treeview-selectable" data-nodeid="1" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="icon expand-icon glyphicon glyphicon-plus"></span><span class="icon node-icon"></span>Child 1</li><li class="list-group-item node-treeview-selectable" data-nodeid="4" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="icon glyphicon"></span><span class="icon node-icon"></span>Child 2</li><li class="list-group-item node-treeview-selectable" data-nodeid="5" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 2</li><li class="list-group-item node-treeview-selectable" data-nodeid="6" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 3</li><li class="list-group-item node-treeview-selectable" data-nodeid="7" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 4</li><li class="list-group-item node-treeview-selectable" data-nodeid="8" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 5</li></ul></div>
        </div>
        <div class="col-sm-4">
          <h2>Events</h2>
          <div id="selectable-output"></div>
        </div>
      </div>
      <div class="row">
        <hr>
        <h2>Expandible Tree</h2>
        <div class="col-sm-4">
          <h2>Input</h2>
          <div class="form-group">
            <label for="input-expand-node" class="sr-only">Search Tree:</label>
            <input type="input" class="form-control" id="input-expand-node" placeholder="Identify node..." value="Parent 1">
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" class="checkbox" id="chk-expand-silent" value="false">
              Silent (No events)
            </label>
          </div>
          <div class="form-group row">
            <div class="col-sm-6">
              <button type="button" class="btn btn-success expand-node" id="btn-expand-node">Expand Node</button>
            </div>
            <div class="col-sm-6">
              <select class="form-control" id="select-expand-node-levels">
                <option>1</option>
                <option>2</option>
              </select>
            </div>
          </div>
          <div class="form-group">
            <button type="button" class="btn btn-danger expand-node" id="btn-collapse-node">Collapse Node</button>
          </div>
          <div class="form-group">
            <button type="button" class="btn btn-primary expand-node" id="btn-toggle-expanded">Toggle Node</button>
          </div>
          <hr>
          <div class="form-group row">
            <div class="col-sm-6">
              <button type="button" class="btn btn-success" id="btn-expand-all">Expand All</button>
            </div>
            <div class="col-sm-6">
              <select class="form-control" id="select-expand-all-levels">
                <option>1</option>
                <option>2</option>
              </select>
            </div>
          </div>
          <button type="button" class="btn btn-danger" id="btn-collapse-all">Collapse All</button>
        </div>
        <div class="col-sm-4">
          <h2>Tree</h2>
          <div id="treeview-expandible" class="treeview"><ul class="list-group"><li class="list-group-item node-treeview-expandible search-result" data-nodeid="0" style="color:#D9534F;background-color:undefined;"><span class="icon expand-icon glyphicon glyphicon-minus"></span><span class="icon node-icon"></span>Parent 1</li><li class="list-group-item node-treeview-expandible" data-nodeid="1" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="icon expand-icon glyphicon glyphicon-plus"></span><span class="icon node-icon"></span>Child 1</li><li class="list-group-item node-treeview-expandible" data-nodeid="4" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="icon glyphicon"></span><span class="icon node-icon"></span>Child 2</li><li class="list-group-item node-treeview-expandible" data-nodeid="5" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 2</li><li class="list-group-item node-treeview-expandible" data-nodeid="6" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 3</li><li class="list-group-item node-treeview-expandible" data-nodeid="7" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 4</li><li class="list-group-item node-treeview-expandible" data-nodeid="8" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 5</li></ul></div>
        </div>
        <div class="col-sm-4">
          <h2>Events</h2>
          <div id="expandible-output"></div>
        </div>
      </div>
      <div class="row">
        <hr>
        <h2>Checkable Tree</h2>
        <div class="col-sm-4">
          <h2>Input</h2>
          <div class="form-group">
            <label for="input-check-node" class="sr-only">Search Tree:</label>
            <input type="input" class="form-control" id="input-check-node" placeholder="Identify node..." value="Parent 1">
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" class="checkbox" id="chk-check-silent" value="false">
              Silent (No events)
            </label>
          </div>
          <div class="form-group row">
            <div class="col-sm-6">
              <button type="button" class="btn btn-success check-node" id="btn-check-node">Check Node</button>
            </div>
          </div>
          <div class="form-group">
            <button type="button" class="btn btn-danger check-node" id="btn-uncheck-node">Uncheck Node</button>
          </div>
          <div class="form-group">
            <button type="button" class="btn btn-primary check-node" id="btn-toggle-checked">Toggle Node</button>
          </div>
          <hr>
          <div class="form-group row">
            <div class="col-sm-6">
              <button type="button" class="btn btn-success" id="btn-check-all">Check All</button>
            </div>
          </div>
          <button type="button" class="btn btn-danger" id="btn-uncheck-all">Uncheck All</button>
        </div>
        <div class="col-sm-4">
          <h2>Tree</h2>
          <div id="treeview-checkable" class="treeview"><ul class="list-group"><li class="list-group-item node-treeview-checkable search-result" data-nodeid="0" style="color:#D9534F;background-color:undefined;"><span class="icon expand-icon glyphicon glyphicon-minus"></span><span class="icon check-icon glyphicon glyphicon-unchecked"></span>Parent 1</li><li class="list-group-item node-treeview-checkable" data-nodeid="1" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="icon expand-icon glyphicon glyphicon-plus"></span><span class="icon check-icon glyphicon glyphicon-unchecked"></span>Child 1</li><li class="list-group-item node-treeview-checkable" data-nodeid="4" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="icon glyphicon"></span><span class="icon check-icon glyphicon glyphicon-unchecked"></span>Child 2</li><li class="list-group-item node-treeview-checkable" data-nodeid="5" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon check-icon glyphicon glyphicon-unchecked"></span>Parent 2</li><li class="list-group-item node-treeview-checkable" data-nodeid="6" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon check-icon glyphicon glyphicon-unchecked"></span>Parent 3</li><li class="list-group-item node-treeview-checkable" data-nodeid="7" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon check-icon glyphicon glyphicon-unchecked"></span>Parent 4</li><li class="list-group-item node-treeview-checkable" data-nodeid="8" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon check-icon glyphicon glyphicon-unchecked"></span>Parent 5</li></ul></div>
        </div>
        <div class="col-sm-4">
          <h2>Events</h2>
          <div id="checkable-output"></div>
        </div>
      </div>
      <div class="row">
        <hr>
        <h2>Disabled Tree</h2>
        <div class="col-sm-4">
          <h2>Input</h2>
          <div class="form-group">
            <label for="input-disable-node" class="sr-only">Search Tree:</label>
            <input type="input" class="form-control" id="input-disable-node" placeholder="Identify node..." value="Parent 1">
          </div>
          <div class="checkbox">
            <label>
              <input type="checkbox" class="checkbox" id="chk-disable-silent" value="false">
              Silent (No events)
            </label>
          </div>
          <div class="form-group row">
            <div class="col-sm-6">
              <button type="button" class="btn btn-success disable-node" id="btn-disable-node">Disable Node</button>
            </div>
          </div>
          <div class="form-group">
            <button type="button" class="btn btn-danger disable-node" id="btn-enable-node">Enable Node</button>
          </div>
          <div class="form-group">
            <button type="button" class="btn btn-primary disable-node" id="btn-toggle-disabled">Toggle Node</button>
          </div>
          <hr>
          <div class="form-group row">
            <div class="col-sm-6">
              <button type="button" class="btn btn-success" id="btn-disable-all">Disable All</button>
            </div>
          </div>
          <button type="button" class="btn btn-danger" id="btn-enable-all">Enable All</button>
        </div>
        <div class="col-sm-4">
          <h2>Tree</h2>
          <div id="treeview-disabled" class="treeview"><ul class="list-group"><li class="list-group-item node-treeview-disabled search-result" data-nodeid="0" style="color:#D9534F;background-color:undefined;"><span class="icon expand-icon glyphicon glyphicon-minus"></span><span class="icon node-icon"></span>Parent 1</li><li class="list-group-item node-treeview-disabled" data-nodeid="1" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="icon expand-icon glyphicon glyphicon-plus"></span><span class="icon node-icon"></span>Child 1</li><li class="list-group-item node-treeview-disabled" data-nodeid="4" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="icon glyphicon"></span><span class="icon node-icon"></span>Child 2</li><li class="list-group-item node-treeview-disabled" data-nodeid="5" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 2</li><li class="list-group-item node-treeview-disabled" data-nodeid="6" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 3</li><li class="list-group-item node-treeview-disabled" data-nodeid="7" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 4</li><li class="list-group-item node-treeview-disabled" data-nodeid="8" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 5</li></ul></div>
        </div>
        <div class="col-sm-4">
          <h2>Events</h2>
          <div id="disabled-output"></div>
        </div>
      </div>
      <div class="row">
        <hr>
        <h2>Data</h2>
        <div class="col-sm-4">
          <h2>JSON Data</h2>
          <div id="treeview12" class="treeview"><ul class="list-group"><li class="list-group-item node-treeview12 node-selected" data-nodeid="0" style="color:#FFFFFF;background-color:#428bca;"><span class="icon expand-icon glyphicon glyphicon-minus"></span><span class="icon node-icon"></span>Parent 1</li><li class="list-group-item node-treeview12" data-nodeid="1" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="icon expand-icon glyphicon glyphicon-minus"></span><span class="icon node-icon"></span>Child 1</li><li class="list-group-item node-treeview12" data-nodeid="2" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="indent"></span><span class="icon glyphicon"></span><span class="icon node-icon"></span>Grandchild 1</li><li class="list-group-item node-treeview12" data-nodeid="3" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="indent"></span><span class="icon glyphicon"></span><span class="icon node-icon"></span>Grandchild 2</li><li class="list-group-item node-treeview12" data-nodeid="4" style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="icon glyphicon"></span><span class="icon node-icon"></span>Child 2</li><li class="list-group-item node-treeview12" data-nodeid="5" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 2</li><li class="list-group-item node-treeview12" data-nodeid="6" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 3</li><li class="list-group-item node-treeview12" data-nodeid="7" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 4</li><li class="list-group-item node-treeview12" data-nodeid="8" style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span class="icon node-icon"></span>Parent 5</li></ul></div>
        </div>
        <div class="col-sm-4">
          <h2></h2>
          <div id="treeview13" class=""></div>
        </div>
        <div class="col-sm-4">
          <h2></h2>
          <div id="treeview14"></div>
        </div>
      </div>
      <br>
      <br>
      <br>
      <br>
    </div>
    </form>
</body>
</html>





