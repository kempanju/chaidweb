<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'dictionary.label', default: 'Dictionary')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>

    <div class="register_dv expert">
        <div class="center panel_div_list panel-body">
        <a href="#list-dictionary" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="list-dictionary" class="content scaffold-list" role="main">

            <table class="table datatable-basic table-bordered table-striped table-hover">
                            <thead>
                            <tr>
                                <g:sortableColumn property="id" title="${message(code: 'no', default: 'No')}"/>
                                <g:sortableColumn property="code"
                                                  title="${message(code: 'code', default: 'Code')}"/>

                                <g:sortableColumn property="name_en"
                                                  title="${message(code: 'name', default: 'Name')}"/>
                                <th class="text-center">Actions</th>

                            </tr>
                            </thead>
                            <tbody>
                            <g:each in="${dictionaryList}" status="i" var="dictionaryInstance">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'} ">
                                    <td>${i + 1}</td>
                                    <td>${fieldValue(bean: dictionaryInstance, field: "code")}</td>
                                    <td>${fieldValue(bean: dictionaryInstance, field: "name")}</td>
                                    <td class="text-center">

                                        <g:link class="create" action="show" id="${dictionaryInstance.id}"
                                                resource="${this.dictionaryInstance}">
                                            <i class="icon-menu-open"></i><span> View</span>


                                        </g:link>

                                    </td>
                                </tr>
                            </g:each>

                            </tbody>
                        </table>
                        <g:if test="${dictionaryCount > 10}">
                            <div class="col-md-10 text-center" style="margin-top: 20px">

                                <div class="pagination">
                                    <g:paginate total="${dictionaryCount ?: 0}"/>
                                </div>
                            </div>
                        </g:if>
        </div>
        </div>
        </div>
    </body>
</html>