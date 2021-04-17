<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'facility.label', default: 'Facility')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#show-facility" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="show-facility" class="content scaffold-show" role="main">
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <div class="panel table-responsive">


                                       <div style="width: 100%;float: left">

                                           <table class="table text-nowrap customers">
                                               <tr>
                                                   <td colspan="2"><h5>
                                                       <span class="text-bold"><g:message code="dictionary.details" default="FACILITY DETAILS"/></span>
                                                   </h5></td>
                                               </tr>

                                               <tr>
                                                   <td>
                                                       <span class="text-semibold"><g:message code="code" default="Code"/></span>
                                                   </td>
                                                   <td><span
                                                           class="text-bold">${fieldValue(bean: facility, field: "number")}</span>
                                                   </td>
                                               </tr>

              <tr>
                                                   <td>
                                                       <span class="text-semibold"><g:message code="name.en" default="Name"/></span>
                                                   </td>
                                                   <td><span
                                                           class="text-bold">${fieldValue(bean: facility, field: "name")}</span>

                                                   </td>
                                               </tr>
                <tr>


                                                   <td>
                                                       <span class="text-semibold"><g:message code="name.en" default="Type"/></span>
                                                   </td>
                                                   <td><span
                                                           class="text-bold">${fieldValue(bean: facility, field: "type.name")}</span>

                                                   </td>
                                               </tr>

              <tr>
                                                   <td>
                                                       <span class="text-semibold"><g:message code="name.en" default="District"/></span>
                                                   </td>
                                                   <td><span
                                                           class="text-bold">${fieldValue(bean: facility, field: "district_id.name")}</span>

                                                   </td>
                                               </tr>
                     <tr>
                                                                   <td>
                                                                       <span class="text-semibold"><g:message code="name.en" default="Village"/></span>
                                                                   </td>
                                                                   <td><span
                                                                           class="text-bold">${fieldValue(bean: facility, field: "village_id.name")}</span>

                                                                   </td>
                                                               </tr>

                                           </table>
                                       </div>


                                   </div>
            <g:form resource="${this.facility}" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="edit" action="edit" resource="${this.facility}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
