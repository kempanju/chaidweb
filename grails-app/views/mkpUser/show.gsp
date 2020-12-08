<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'mkpUser.label', default: 'MkpUser')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>

   <script>
           function addRole() {
                      $(function () {
                          $("#dialogrole").dialog({
                              width: "30%",
                              maxWidth: "500px"
                          });
                      });
                  }

              </script>


    </head>
    <body>
     <div class="register_dv expert">
            <div class="row panel-flat back_white">
        <a href="#show-mkpUser" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="show-mkpUser" class="content scaffold-show" role="main">
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
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
                                       <span class="text-semibold">Email</span>
                                   </td>
                                   <td>
                                       ${fieldValue(bean: mkpUser, field: "email")}

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
                                 </tr>
                             </g:each>

                         </div>
                     </g:if>
                 </td></tr>



                                    </table>




            <g:form resource="${this.mkpUser}" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="edit" action="edit" resource="${this.mkpUser}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                    <input class="delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </fieldset>
            </g:form>
        </div>

     </div>
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




    </body>
</html>
