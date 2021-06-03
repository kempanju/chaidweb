<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'subStreet.label', default: 'SubStreet')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>


        <script>
                                                         function helmetSearch(ids) {

                                                             var ids = ids.value;
                                                             $.ajax({
                                                                 url: '${grailsApplication.config.systemLink.toString()}/subStreet/searchStreetList',
                                                                 data: {'search_string': ids}, // change this to send js object
                                                                 type: "post",
                                                                 success: function (data) {
                                                                     //document.write(data); just do not use document.write
                                                                     $("#list-subStreet").html(data);
                                                                     //console.log(data);
                                                                 }
                                                             });
                                                         }
                                                     </script>
    </head>
    <body>

      <div class="register_dv expert">

                    <div class="center panel_div_list panel-body">
        <a href="#list-subStreet" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="create" action="create">Create Hamlet</g:link></li>
            </ul>
        </div>

        <div class="page-header-content">


                                                                        <div class="heading-elements">

                                                                            <input type="text" value="" name="search_text" class="form-control" onkeyup="helmetSearch(this)"
                                                                                   placeholder="Search  Hamlet">

                                                                        </div>

                                                                    </div>
        <div id="list-subStreet" class="content scaffold-list" role="main">
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>


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

        <g:if test="${subStreetCount > 10}">
            <div class="col-md-10 text-center" style="margin-top: 20px">

                <div class="pagination">
                <g:paginate total="${subStreetCount ?: 0}"/>
            </div>
            </div>
        </g:if>





        </div>

        </div>
        </div>
    </body>
</html>