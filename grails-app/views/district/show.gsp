<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'district.label', default: 'District')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#show-district" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="show-district" class="content scaffold-show" role="main">
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
               <table class="table customers">
                                                <tr>
                                                    <td colspan="2"><h5>
                                                        <span class="text-bold"><g:message code="dictionary.details" default="DISTRICT DETAILS"/></span>
                                                    </h5></td>
                                                </tr>
              <tr>
                                                                  <td>
                                                                      <span class="text-semibold"><g:message code="code" default="Region"/></span>
                                                                  </td>
                                                                  <td><span
                                                                          class="text-bold">${fieldValue(bean: district, field: "region_id.name")}</span>
                                                                  </td>
                                                              </tr>


              <tr>
                                                    <td>
                                                        <span class="text-semibold"><g:message code="code" default="Name"/></span>
                                                    </td>
                                                    <td><span
                                                            class="text-bold">${fieldValue(bean: district, field: "name")}</span>
                                                    </td>
                                                </tr>

                            <tr>
                                <td colspan="2">
                                    <g:if test="${flash.message}">
                                        <div class="alert bg-info alert-styled-left"
                                             role="status">${flash.message}</div>
                                    </g:if>
                                    <div id="dialog" title="CSVfILE">
                                        <div class="panel-body">

                                            <g:uploadForm name="myUploadLogo" controller="district"
                                                          action="uploadCVDistrict">
                                                <div class="col-lg-8">
                                                    <input type="file" name="filename_csv" accept="text/csv"/>
                                                </div>
                                                <g:hiddenField name="district_id" value="${district.id}"/>

                                                <div class="text-right col-lg-10" style="margin-top: 20px">
                                                    <button type="submit" style="margin-left:4px"
                                                            class="btn btn-primary">Upload CSV <i
                                                            class="icon-arrow-right14 position-right"></i>
                                                    </button>
                                                </div>
                                            </g:uploadForm>
                                        </div>
                                    </div>
                                </td>

                            </tr>
            </table>
            <g:form resource="${this.district}" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="edit" action="edit" resource="${this.district}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
