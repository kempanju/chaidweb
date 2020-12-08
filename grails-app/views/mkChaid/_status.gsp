  <table class="table datatable-basic tabs_table">

                            <thead>
                            <tr>
                                <th>#</th>
                                <th>Action</th>

                                %{--
                                        <th>${message(code: 'company.size.label', default: 'Size')}</th>
                                --}%
                                <th class="text-center">Description</th>

                                <th>Created By</th>
                                <th>Created Time</th>


                            </tr>
                            </thead>
                            <g:each in="${chaid.ChadStatus.findAllByChaid(mkChaid)}" status="i"
                                    var="appStatusInstance">
                                <tr>
                                    <td>${i+1}</td>
                                    <td>
                                        <span class="label <g:if test="${appStatusInstance.status.code=="CREPORTED"||appStatusInstance.status.code=="REJAAPLIC"||appStatusInstance.status.code=="AAPPROVE"}">label-success</g:if><g:else>label-warning</g:else>">

                                            ${fieldValue(bean: appStatusInstance, field: "status.name")}

                                    </td>

                                    <td>
                                        ${fieldValue(bean: appStatusInstance, field: "comment")}
                                    </td>
                                    <td>
                                        ${fieldValue(bean: appStatusInstance, field: "createdBy.full_name")}
                                    </td>
                                    <td>

                                        <span class="text-muted"><g:formatDate format="dd MMM, yyyy HH:mm"
                                                                               date="${appStatusInstance.created_at}"/></span>

                                    </td>
                                </tr>

                            </g:each>
                        </table>
