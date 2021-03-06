<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'household.label', default: 'Household')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
      <div class="register_dv expert">

        <div class="center panel_div_list panel-body">

        <a href="#list-household" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="list-household" class="content scaffold-list" role="main">
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>

      <table  class="table datatable-basic table-bordered table-striped table-hover">
                                            <thead>
                                            <tr>
                                                <g:sortableColumn property="id" title="${message(code: 'no', default: 'No')}"/>
                                                <g:sortableColumn property="code"
                                                                  title="${message(code: 'code', default: 'Number')}"/>

                                                <g:sortableColumn property="name_en"
                                                                  title="${message(code: 'name', default: 'Name')}"/>
                                                <g:sortableColumn property="dictionary_id"
                                                                  title="${message(code: 'dictionary', default: 'District')}"/>

 <g:sortableColumn property="dictionary_id"
                                                                  title="${message(code: 'dictionary', default: 'Village')}"/>

                                                <th class="text-center"><g:message code="actions" default="Actions"/></th>

                                            </tr>
                                            </thead>
                                            <tbody>
                                            <g:each in="${householdList}" status="i" var="householdListInstance">
                                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'} ">
                                                    <td>${i + 1}</td>
                                                    <td>${fieldValue(bean: householdListInstance, field: "number")}</td>
                                                    <td class="text-capitalize">${fieldValue(bean: householdListInstance, field: "name")}</td>
                                                    <td>${fieldValue(bean: householdListInstance, field: "district_id.name")}</td>
                                                    <td>${fieldValue(bean: householdListInstance, field: "village_id.name")}</td>

                                                    <td class="text-center">

                                                        <g:link class="create" action="show" id="${householdListInstance.id}"
                                                                resource="${this.householdListInstance}">

                                                            <i class="icon-menu-open"></i><span> View</span>

                                                        </g:link>

                                                    </td>
                                                </tr>
                                            </g:each>

                                            </tbody>
                                        </table>





             <g:if test="${householdCount > 10}">
                                        <div class="col-md-10 text-center" style="margin-top: 20px">
                        <div class="pagination">
                            <g:paginate total="${householdCount ?: 0}" />
                        </div>
                        </div>


                          </g:if>


        </div>


        </div>
        </div>
    </body>
</html>