<!DOCTYPE html>
<%
    def defaultTab = session.defaultTabL
    if (!defaultTab) {
        defaultTab = 0
    }
%>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'household.label', default: 'Household')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
    <div class="register_dv expert">

        <div class="center panel_div_list panel-body" style="padding: 20px">
        <a href="#show-household" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="show-household" class="content scaffold-show" role="main">
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>


<div style="width: 100%;float: left">


                        <div class="tabbable">
                                        <ul class="nav nav-sm nav-tabs  nav-tabs-component">
                                            <li class="<g:if test="${defaultTab == 0}">active</g:if>"><a href="#left-icon-tab1" data-toggle="tab">1: Chad Details</a></li >

                                            <li  class="<g:if test="${defaultTab == 1}">active</g:if>"><a href="#left-icon-tab2" data-toggle="tab">2: Visit List</a></li>


                                           </ul>
                                  <div class="tab-content">
                                                    <div class="tab-pane <g:if test="${defaultTab == 0}">active</g:if>" id="left-icon-tab1">
                                                        <g:render template="details" bean="household"/>

                                                    </div>

                                                     <div class="tab-pane  <g:if test="${defaultTab == 1}">active</g:if>" id="left-icon-tab2">
                                                                            <g:render template="visitlist" bean="household"/>

                                                                        </div>

                                           </div>

               </div>


            <g:form resource="${this.household}" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="edit" action="edit" resource="${this.household}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                </fieldset>
            </g:form>
        </div>
        </div>
        </div>
    </body>
</html>
