
<div class="panel-body">
  <g:form controller="mkChaid" action="addChadStatus"
                                                  method="POST"
                                                  class="form-horizontal">
                                              <g:hiddenField name="chaid_id" value="${mkChaid.id}"/>


                                              <div class="col-lg-3">
                                                  <g:select name="status_id" id="status_id" value=""
                                                            from="${admin.DictionaryItem.findAllByDictionary_idAndActive(admin.Dictionary.findByCode("CHADSTATUS"),true)}"
                                                            optionKey="id" optionValue="name" required="required"
                                                            class="form-control select-search"
                                                            noSelection="['': 'Choose Action']"/>

                                              </div>

                                              <div class="col-lg-4">
                                                  <g:textArea name="comment" placeholder="Write any comment .."
                                                              rows="2" cols="10"/>

                                              </div>

                                              <div class="col-lg-3">

                                                  <button type="submit" class="btn btn-primary">SAVE CHANGES <i
                                                          class="icon-arrow-right14 position-right"></i>
                                                  </button>

                                              </div>
                                          </g:form>

</div>
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
