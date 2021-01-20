<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'mkChaid.label', default: 'MkChaid')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>

         <script>
                    function chaidSearch(ids) {

                        var ids = ids.value;
                        $.ajax({
                            url: '${grailsApplication.config.systemLink.toString()}/mkChaid/searchChadList',
                            data: {'search_string': ids}, // change this to send js object
                            type: "post",
                            success: function (data) {
                                //document.write(data); just do not use document.write
                                $("#list-mkChaid").html(data);
                                //console.log(data);
                            }
                        });
                    }
                </script>
    </head>
    <body>
<div class="register_dv expert">

    <div class="row panel-flat back_white">
        <div class="btn-group btn-breadcrumb">
            <g:link controller="home" action="dashboard" class="btn btn-default"><i
                    class="glyphicon glyphicon-home"></i></g:link>
            <g:link controller="home" action="dashboard" class="btn btn-default">Dashboard</g:link>

            <a href="#"
               class="btn btn-primary">${message(code: 'application.list', default: 'Activity List')} (<g:formatNumber number="${mkChaidCount}" type="number" />)</a>
        </div>
    </div>
      <div class="page-header-content">


                <div class="heading-elements">

                    <input type="text" value="" name="search_text" class="form-control" onkeyup="chaidSearch(this)"
                           placeholder="Search  Chad">

                </div>

            </div>
        <div id="list-mkChaid" class="content scaffold-list " role="main">
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>


             <table  class="table datatable-basic table-bordered table-striped table-hover">
                                        <thead>
                                        <tr>
                                            <g:sortableColumn property="id" title="${message(code: 'no', default: 'No')}"/>
                                            <g:sortableColumn property="respondent_name"
                                                              title="${message(code: 'code', default: 'Respondent')}"/>

                                            <g:sortableColumn property="distric.name"
                                                              title="${message(code: 'name', default: 'District')}"/>
                                            <g:sortableColumn property="household.full_name"
                                                              title="${message(code: 'dictionary', default: 'Household')}"/>

                                            <th class="text-center"><g:message code="actions" default="Actions"/></th>

                                        </tr>
                                        </thead>
                                        <tbody>
                                        <g:each in="${mkChaidList}" status="i" var="mkchaidListInstance">
                                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'} ">
                                                <td>

                                             <% def offset = 0
                                                                                                     if (params.offset) {
                                                                                                         offset = Integer.parseInt(params.offset)
                                                                                                     }
                                                                                                     %>
                                                                                                     ${i + 1 + offset}

                                                </td>
                                                <td class="text-capitalize">${fieldValue(bean: mkchaidListInstance, field: "respondent_name")}</td>
                                                <td>
                                                                                                 <g:link class="list" controller="district" action="show" id="${mkchaidListInstance.distric.id}">

                                                ${fieldValue(bean: mkchaidListInstance, field: "distric.name")}</g:link></td>
                                                <td class="text-capitalize">${fieldValue(bean: mkchaidListInstance, field: "household.full_name")}</td>

                                                <td class="text-center">

                                                    <g:link class="create" action="show" id="${mkchaidListInstance.id}"
                                                            resource="${this.mkchaidListInstance}">

                                                        <i class="icon-menu-open"></i><span> View</span>

                                                    </g:link>

                                                </td>
                                            </tr>
                                        </g:each>

                                        </tbody>
                                    </table>

                                    <g:if test="${mkChaidCount > 10}">
                                        <div class="col-md-10 text-center" style="margin-top: 20px">

                                            <div class="pagination">
                                            <g:paginate total="${mkChaidCount ?: 0}"/>
                                        </div>
                                        </div>
                                    </g:if>







        </div>

        </div>
    </body>
</html>