<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'systemLogs.label', default: 'SystemLogs')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>

    <div class="register_dv expert">
        <div class="row panel-flat back_white">
        <a href="#list-systemLogs" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
            </ul>
        </div>
        <div id="list-systemLogs" class="content scaffold-list" role="main">
            <h4><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>


            <table class="table datatable-basic table-bordered table-striped table-hover">
                            <thead>
                            <tr>
                                <g:sortableColumn property="id" title="${message(code: 'no', default: 'No')}"/>
                                <g:sortableColumn property="user_id"
                                                  title="${message(code: 'username', default: 'Username')}"/>

                                <g:sortableColumn property="message"
                                                  title="${message(code: 'message', default: 'Message')}"/>
                                <g:sortableColumn property="created_at"
                                                  title="${message(code: 'time', default: 'Time')}"/>
                                <g:sortableColumn property="msg_status"
                                                  title="${message(code: 'status', default: 'Status')}"/>
                            </tr>
                            </thead>
                            <tbody>
                            <g:each in="${systemLogsList}" status="i" var="systemLogListInstance">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'} ">
                                    <td>${i + 1}</td>
                                    <td class="text-capitalize">
                                        <g:link class="create" controller="ZUser" action="userDetails"
                                                id="${systemLogListInstance?.user_id?.id}">
                                            ${fieldValue(bean: systemLogListInstance, field: "user_id.full_name")}
                                        </g:link>
                                    </td>
                                    <td>
                                        <% String message = systemLogListInstance.message
                                        message = message.replace(",", " , ")
                                        %>
                                        <p style="max-width: 400px">${message}</p></td>
                                    <td>${fieldValue(bean: systemLogListInstance, field: "created_at")}</td>
                                    <td>
                                        <g:if test="${systemLogListInstance.log_type.code == "SMSL"}">
                                            <span class="label label-info">

                                                ${fieldValue(bean: systemLogListInstance, field: "msg_status")}
                                            </span>
                                        </g:if>
                                        <g:else>
                                            <span class="label label-primary">
                                                None
                                            </span>
                                        </g:else>
                                    </td>
                                </tr>
                            </g:each>

                            </tbody>
                        </table>


                        <div class="col-md-10 text-center" style="margin-top: 20px">
                            <div class="pagination">
                                <g:paginate total="${systemLogsCount ?: 0}"/>
                            </div>
                        </div>



        </div>

        </div>
        </div>
    </body>
</html>