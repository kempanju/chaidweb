 <div id="show-mkpUser" class="content scaffold-show" role="main">
           <g:if test="${flash.message}">
                    <div class="message alert alert-success alert-styled-left alert-arrow-left alert-bordered" role="status">${flash.message}</div>
                    </g:if>

        <table class="table datatable-basic table-bordered table-striped">
                                   <tr>
                                       <td colspan="2"><h5>
                                           <span class="text-bold">General information</span>
                                       </h5></td>
                                   </tr>

                                   <tr>
                                       <td>
                                           <span class="text-semibold">Full Name</span>
                                       </td>
                                       <td>
                                           ${fieldValue(bean: mkpUser, field: "full_name")}

                                       </td>

                                   </tr>

                                    <tr>
                                                                   <td>
                                                                       <span class="text-semibold">Phone Number</span>
                                                                   </td>
                                                                   <td>
                                                                       ${fieldValue(bean: mkpUser, field: "phone_number")}

                                                                   </td>

                                                               </tr>


                                    <tr>
                                   <td>
                                       <span class="text-semibold">Username</span>
                                   </td>
                                   <td>
                                       ${fieldValue(bean: mkpUser, field: "username")}

                                   </td>

        </tr>

    <tr>
                                      <td>
                                          <span class="text-semibold">Facility</span>
                                      </td>
                                      <td>
                                          ${fieldValue(bean: mkpUser, field: "facility.name")}

                                      </td>

           </tr>

    <tr>
                                   <td>
                                       <span class="text-semibold">District</span>
                                   </td>
                                   <td>
                                       ${fieldValue(bean: mkpUser, field: "district_id.name")}

                                   </td>

        </tr>
    <tr>
                                   <td>
                                       <span class="text-semibold">Village</span>
                                   </td>
                                   <td>
                                       ${fieldValue(bean: mkpUser, field: "village_id.name")}

                                   </td>

        </tr>

         <tr>
                            <td colspan="3">
                                <div class="col-lg-10">

                                    <table class="table text-nowrap customers">


                                        <sec:ifAnyGranted roles="ROLE_ADMIN">
                                            <tr>

                                                <td colspan="4">
                                                    <g:form method="POST" controller="mkpUser" action="sendPasswordUser"
                                                            class="form-horizontal">
                                                        <g:hiddenField name="id" value="${mkpUser.id}"/>
                                                        <div class="col-lg-3">
                                                            <label class="control-label col-lg-2 text-bold"><g:message code="password.options" default="Password Options"/></label>
                                                        </div>

                                                        <div class="col-lg-4">

                                                            <select name="optionData">
                                                                <option value="1"><g:message code="by.email" default="By Email"/></option>

                                                                <option value="2"><g:message code="by.phone.number" default="By Phonenumber"/></option>

                                                            </select>

                                                        </div>


                                                        <div class="text-right col-lg-5">
                                                            <button type="submit" class="btn btn-danger"><g:message code="send.password" default="Send Password"/> <i
                                                                    class="icon-arrow-right14 position-right"></i>
                                                            </button>

                                                        </div>
                                                    </g:form>

                                                </td>

                                            </tr>


                                        </sec:ifAnyGranted>

                                    </table>

                                </div>

                            </td>
                        </tr>


  <tr><td>Add Role</td><td> <a href="#" onclick="addRole()"><i class="icon-gear"></i> Add Role</a></td></tr>

                 <tr><td colspan="2">
                  <g:if test="${com.chaid.security.MkpUserMkpRole.countByMkpUser(mkpUser)}">
                         <div class="col-lg-5">

                         %{--
                                                     <span class="text-bold">User roles</span>
                         --}%

                             <g:each in="${com.chaid.security.MkpUserMkpRole.findAllByMkpUser(mkpUser)}"
                                     status="i"
                                     var="roleInstance">
                                 <tr class="${(i % 2) == 0 ? 'even' : 'odd'} ">
                                     <td>${i + 1}</td>
                                     <td>${fieldValue(bean: roleInstance, field: "mkpRole.authority")}</td>
                                     <sec:ifAnyGranted roles="ROLE_ADMIN">

                                     <td><g:link controller='mkpUser' action="deleteRole" params="[role_id:roleInstance.mkpRole.id,user_id:roleInstance.mkpUser.id]">Delete</g:link></td>
                                      </sec:ifAnyGranted>
                                 </tr>
                             </g:each>

                         </div>
                     </g:if>
                 </td></tr>



                                    </table>



            <g:form resource="${this.mkpUser}" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="edit" action="edit" resource="${this.mkpUser}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                </fieldset>
            </g:form>
        </div>


    <div id="dialogrole" style="display: none" title="Add Role To Users">
                    <div class="panel-body">

                        <g:form controller="mkpUser" action="addRole" method="POST" class="form-horizontal">
                            <div class="form-group">
                                <label class="control-label col-lg-2">Role</label>


                                <div class="col-lg-8">
                                    <g:select name="role_id" id="role_id"
                                              from="${com.chaid.security.MkpRole.all}" optionKey="id" optionValue="authority"
                                              class="form-control select-search" noSelection="['': 'Select Role']"/>

                                </div>
                            </div>
                            <g:hiddenField name="user_id" value="${mkpUser.id}"/>
                            <div class="text-right col-lg-10" style="margin-top: 20px">
                                <button type="submit" style="margin-left:4px"
                                        class="btn btn-primary">Add role <i
                                        class="icon-arrow-right14 position-right"></i>
                                </button>
                            </div>
                        </g:form>

                        </div>
                     </div>