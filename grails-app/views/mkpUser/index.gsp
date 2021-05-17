<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'mkpUser.label', default: 'MkpUser')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>

              <script>
                            function userSearch(ids) {

                                var ids = ids.value;
                                $.ajax({
                                    url: '${grailsApplication.config.systemLink.toString()}/mkpUser/searchUserList',
                                    data: {'search_string': ids}, // change this to send js object
                                    type: "post",
                                    success: function (data) {
                                        //document.write(data); just do not use document.write
                                        $("#list-mkpUser").html(data);
                                        //console.log(data);
                                    }
                                });
                            }
                        </script>
    </head>
    <body>
    <div class="register_dv expert">
        <div class="center panel_div_list panel-body">
         <div class="page-header-content">

                        <div class="heading-elements">
                            <div>
                            <input type="text" value="" name="search_text" class="form-control" onkeyup="userSearch(this)"
                                   placeholder="Search  User">
                            </div>
                            <div>
                                                    <span style="font-size: 10px;color:#858C93"> Search by Region, District, Village,Facility, Full Name and Mobile Number </span>

                            </div>
                        </div>


                    </div>

        <a href="#list-mkpUser" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="list-mkpUser" style="max-height:600px;overflow: auto;" class="content scaffold-list" role="main">
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>

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
                                    <td>${fieldValue(bean: zUserListInstance, field: "full_name")}</td>
                                    <td>${fieldValue(bean: zUserListInstance, field: "village_id.name")}</td>
                                    <td>${fieldValue(bean: zUserListInstance, field: "phone_number")}</td>

                                    <td class="text-center">

                                        <g:link class="create" action="show" id="${zUserListInstance.id}"
                                                resource="${this.zUserListInstance}">

                                            <i class="icon-menu-open"></i><span> <g:message code="view" default="View"/></span>

                                        </g:link>

                                    </td>
                                </tr>
                            </g:each>

                            </tbody>
                        </table>


                        <g:if test="${mkpUserCount > 10}">
                            <div class="col-md-10 text-center" style="margin-top: 20px">
                                <div class="pagination">
                                    <g:paginate total="${mkpUserCount ?: 0}"/>
                                </div>
                            </div>
                        </g:if>


        </div>


        </div>


        <div id="dialog" title="CSVfILE">
                                                           <div class="panel-body">

                                                               <g:uploadForm name="uploadUsers" controller="mkpUser"
                                                                             action="uploadUsers">
                                                                   <div class="col-lg-8">
                                                                       <input type="file" name="filename_csv" accept="text/csv"/>
                                                                   </div>

                                                                   <div class="text-right col-lg-10" style="margin-top: 20px">
                                                                       <button type="submit" style="margin-left:4px"
                                                                               class="btn btn-primary">Upload CSV <i
                                                                               class="icon-arrow-right14 position-right"></i>
                                                                       </button>
                                                                   </div>
                                                               </g:uploadForm>
                                                           </div>
                                                       </div>



        </div>
    </body>
</html>