<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'dictionaryItem.label', default: 'DictionaryItem')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>

              <script>
                            function userSearch(ids) {

                                var ids = ids.value;
                                $.ajax({
                                    url: '${grailsApplication.config.systemLink.toString()}/dictionaryItem/searchDictionaryList',
                                    data: {'search_string': ids}, // change this to send js object
                                    type: "post",
                                    success: function (data) {
                                        //document.write(data); just do not use document.write
                                        $("#list-dictionaryItem").html(data);
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
                                               placeholder="Search  Dictionary Item">
                                        </div>

                                    </div>


                                </div>
        <a href="#list-dictionaryItem" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>


        <div id="list-dictionaryItem" class="content scaffold-list" role="main">
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>


             <table  class="table datatable-basic table-bordered table-striped table-hover">
                            <thead>
                            <tr>
                                <g:sortableColumn property="id" title="${message(code: 'no', default: 'No')}"/>
                                <g:sortableColumn property="code"
                                                  title="${message(code: 'code', default: 'Code')}"/>

                                <g:sortableColumn property="name_en"
                                                  title="${message(code: 'name', default: 'Name')}"/>
                                <g:sortableColumn property="dictionary_id"
                                                  title="${message(code: 'dictionary', default: 'Dictionary')}"/>

                                <th class="text-center"><g:message code="actions" default="Actions"/></th>

                            </tr>
                            </thead>
                            <tbody>
                            <g:each in="${dictionaryItemList}" status="i" var="dictionaryListInstance">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'} ">
                                    <td>${i + 1}</td>
                                    <td>${fieldValue(bean: dictionaryListInstance, field: "code")}</td>
                                    <td>${fieldValue(bean: dictionaryListInstance, field: "name")}</td>
                                    <td>${fieldValue(bean: dictionaryListInstance, field: "dictionary_id.name")}</td>

                                    <td class="text-center">

                                        <g:link class="create" action="show" id="${dictionaryListInstance.id}"
                                                resource="${this.dictionaryListInstance}">

                                            <i class="icon-menu-open"></i><span> View</span>

                                        </g:link>

                                    </td>
                                </tr>
                            </g:each>

                            </tbody>
                        </table>

                        <g:if test="${dictionaryItemCount > 10}">
                            <div class="col-md-10 text-center" style="margin-top: 20px">

                                <div class="pagination">
                                <g:paginate total="${dictionaryItemCount ?: 0}"/>
                            </div>
                            </div>
                        </g:if>



        </div>

        </div>
        </div>
    </body>
</html>