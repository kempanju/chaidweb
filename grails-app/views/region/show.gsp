<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'region.label', default: 'Region')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#show-region" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="show-region" class="content scaffold-show" role="main">
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
              <table class="table customers">
                                                <tr>
                                                    <td colspan="2"><h5>
                                                        <span class="text-bold"><g:message code="dictionary.details" default="REGION DETAILS"/></span>
                                                    </h5></td>
                                                </tr>
              <tr>
                          <td>
                              <span class="text-semibold"><g:message code="code" default="Region"/></span>
                          </td>
                          <td><span
                                  class="text-bold">${fieldValue(bean: region, field: "name")}</span>
                          </td>
                      </tr>
                <tr>
                            <td>
                                <span class="text-semibold"><g:message code="code" default="District No"/></span>
                            </td>
                            <td><span
                                    class="text-bold">${admin.District.countByRegion_id(region)}</span>
                            </td>
                        </tr>
             <%
                    def wardsNo=admin.Wards.executeQuery("from Wards where district_id.region_id=:region",[region:region]).size()
                    def villageNo=admin.Street.executeQuery("from Street where district_id.region_id=:region",[region:region]).size()

             %>
                  <tr>
                              <td>
                                  <span class="text-semibold"><g:message code="code" default="Wards No"/></span>
                              </td>
                              <td><span
                                      class="text-bold">${wardsNo}</span>
                              </td>
                          </tr>
                   <tr>
                               <td>
                                   <span class="text-semibold"><g:message code="code" default="Village No"/></span>
                               </td>
                               <td><span
                                       class="text-bold">${villageNo}</span>
                               </td>
                           </tr>

            </table>


            <g:form resource="${this.region}" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="edit" action="edit" resource="${this.region}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
