<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'region.label', default: 'Region')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
    <div class="register_dv expert">

                        <div class="center panel_div_list panel-body">
        <a href="#list-region" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="list-region" class="content scaffold-list" role="main">
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
   <table  class="table datatable-basic table-bordered table-striped table-hover">
        <thead>
        <tr>
            <g:sortableColumn property="id" title="${message(code: 'no', default: 'No')}"/>
            <g:sortableColumn property="code"
                              title="${message(code: 'code', default: 'Name')}"/>


            <th class="text-center"><g:message code="actions" default="Actions"/></th>

        </tr>
        </thead>
        <tbody>
        <g:each in="${regionList}" status="i" var="subListInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'} ">
                <td>
                 <% def offset = 0
                                                                        if (params.offset) {
                                                                            offset = Integer.parseInt(params.offset)
                                                                        }
                                                                        %>
                                                                        ${i + 1 + offset}
                </td>
                <td>${fieldValue(bean: subListInstance, field: "name")}</td>

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

             <g:if test="${regionCount > 10}">
              <div class="col-md-10 text-center" style="margin-top: 20px">

                  <div class="pagination">
                  <g:paginate total="${regionCount ?: 0}"/>
              </div>
              </div>
          </g:if>

        </div>

    <div id="dialog" title="CSVfILE">
                                            <div class="panel-body">

                                                <g:uploadForm name="uploadCVRegion" controller="region"
                                                              action="uploadCVRegion">
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
        </div>
    </body>
</html>