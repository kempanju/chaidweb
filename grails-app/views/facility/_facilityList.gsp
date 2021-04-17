  <table  class="table datatable-basic table-bordered table-striped table-hover">
                                        <thead>
                                        <tr>
                                            <g:sortableColumn property="id" title="${message(code: 'no', default: 'No')}"/>
                                            <g:sortableColumn property="number"
                                                              title="${message(code: 'code', default: 'Number')}"/>

                                            <g:sortableColumn property="name"
                                                              title="${message(code: 'name', default: 'Name')}"/>
                                            <g:sortableColumn property="district_id.name"
                                                              title="${message(code: 'dictionary', default: 'District')}"/>

                                            <th class="text-center"><g:message code="actions" default="Actions"/></th>

                                        </tr>
                                        </thead>
                                        <tbody>
                                        <g:each in="${facilityList}" status="i" var="facilityListInstance">
                                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'} ">
                                                <td>${i + 1}</td>
                                                <td>${fieldValue(bean: facilityListInstance, field: "number")}</td>
                                                <td>${fieldValue(bean: facilityListInstance, field: "name")}</td>
                                                <td>${fieldValue(bean: facilityListInstance, field: "district_id.name")}</td>

                                                <td class="text-center">

                                                    <g:link class="create" action="show" id="${facilityListInstance.id}"
                                                            resource="${this.facilityListInstance}">

                                                        <i class="icon-menu-open"></i><span> View</span>

                                                    </g:link>

                                                </td>
                                            </tr>
                                        </g:each>

                                        </tbody>
                                    </table>