   <h5>Total Activity : <span>${chaid.MkChaid.countByDeletedAndCreated_by(false,mkpUser)}</span></h5>

    <table  class="table datatable-basic table-bordered table-striped table-hover">
                                        <thead>
                                        <tr>
                                            <g:sortableColumn property="id" title="${message(code: 'no', default: 'No')}"/>
                                            <g:sortableColumn property="code"
                                                              title="${message(code: 'code', default: 'Respondent')}"/>

                                            <g:sortableColumn property="name_en"
                                                              title="${message(code: 'name', default: 'District')}"/>
                                            <g:sortableColumn property="dictionary_id"
                                                              title="${message(code: 'dictionary', default: 'Household')}"/>

                                            <th class="text-center"><g:message code="actions" default="Actions"/></th>

                                        </tr>
                                        </thead>
                                        <tbody>
                                        <g:each in="${chaid.MkChaid.findAllByCreated_byAndDeleted(mkpUser,false,[max:10,sort:'id',order:'desc'])}" status="i" var="mkchaidListInstance">
                                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'} ">
                                                <td>

                                             <% def offset = 0
                                                                                                     if (params.offset) {
                                                                                                         offset = Integer.parseInt(params.offset)
                                                                                                     }
                                                                                                     %>
                                                                                                     ${i + 1 + offset}

                                                </td>
                                                <td>${fieldValue(bean: mkchaidListInstance, field: "respondent_name")}</td>
                                                <td>
                                                                                                 <g:link class="list" controller="district" action="show" id="${mkchaidListInstance.distric.id}">

                                                ${fieldValue(bean: mkchaidListInstance, field: "distric.name")}</g:link></td>
                                                <td>${fieldValue(bean: mkchaidListInstance, field: "household.full_name")}</td>

                                                <td class="text-center">

                                                    <g:link class="create" controller="mkChaid" action="show" id="${mkchaidListInstance.id}"
                                                            resource="${this.mkchaidListInstance}">

                                                        <i class="icon-menu-open"></i><span> View</span>

                                                    </g:link>

                                                </td>
                                            </tr>
                                        </g:each>

                                        </tbody>
                                    </table>



