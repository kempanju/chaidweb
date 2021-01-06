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
                            <g:each in="${admin.SystemLogs.findAllByChaid(mkChaid)}" status="i" var="systemLogListInstance">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'} ">
                                    <td>${i + 1}</td>
                                    <td class="text-capitalize">
                                        <g:link class="create" controller="mkpUser" action="show"
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
                                        <g:if test="${systemLogListInstance.log_type.code == "SSMS"}">
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
