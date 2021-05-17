  <table class="table datatable-basic table-bordered table-striped table-hover">
                            <thead>
                            <tr>
                                <g:sortableColumn property="id" title="${message(code: 'comapny.name.email', default: 'No')}"/>
                                <g:sortableColumn property="code"
                                                  title="${message(code: 'company.name.category', default: 'Full Name')}"/>


                                <g:sortableColumn property="form_four_no"
                                                  title="${message(code: 'company.name.label', default: 'Village')}"/>
                                <g:sortableColumn property="sex"
                                                  title="${message(code: 'company.name.label', default: 'Phone No')}"/>

                                <th class="text-center">Actions</th>

                            </tr>
                            </thead>
                            <tbody>
                            <g:each in="${mkpUserList}" status="i" var="zUserListInstance">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'} ">
                                    <td>

                                        <% def offset = 0
                                        if (params.offset) {
                                            offset = Integer.parseInt(params.offset)
                                        }
                                        %>
                                        ${i + 1 + offset}

                                    </td>
                                    <td>${zUserListInstance[0]?.full_name} </td>
                                    <td>${zUserListInstance[0]?.village_id?.name} </td>
                                    <td>${zUserListInstance[0]?.phone_number} </td>

                                    <td class="text-center">

                                      <g:link class="create" action="show" id="${zUserListInstance[0]?.id}"
                                                                                    >

                                                                                <i class="icon-menu-open"></i><span> <g:message code="view" default="View"/></span>

                                                                            </g:link>


                                    </td>
                                </tr>
                            </g:each>

                            </tbody>
                        </table>
