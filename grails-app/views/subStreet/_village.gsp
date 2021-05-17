<table  class="table datatable-basic table-bordered table-striped table-hover">
                                        <thead>
                                        <tr>
                                            <g:sortableColumn property="id" title="${message(code: 'no', default: 'No')}"/>
                                            <g:sortableColumn property="code"
                                                              title="${message(code: 'code', default: 'Name')}"/>

                                            <g:sortableColumn property="name_en"
                                                              title="${message(code: 'name', default: 'District')}"/>
                                            <g:sortableColumn property="dictionary_id"
                                                              title="${message(code: 'dictionary', default: 'Village')}"/>

                                            <th class="text-center"><g:message code="actions" default="Actions"/></th>

                                        </tr>
                                        </thead>
                                        <tbody>
                                        <g:each in="${subStreetList}" status="i" var="subListInstance">
                                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'} ">
                                                <td>${i + 1}</td>
                                                <td>${fieldValue(bean: subListInstance, field: "name")}</td>
                                                <td>${fieldValue(bean: subListInstance, field: "district_id.name")}</td>
                                                <td>${fieldValue(bean: subListInstance, field: "village_id.name")}</td>

                                                <td class="text-center">

                                                    <g:link class="create" action="show" id="${subListInstance.id}"
                                                            resource="${this.subListInstance}">

                                                        <i class="icon-menu-open"></i><span> View</span>

                                                    </g:link>

                                                </td>
                                            </tr>
                                        </g:each>

                                        </tbody>
                                    </table>