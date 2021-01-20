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



        <div style="width: 100%;float: left">


                                <div class="tabbable">
                                                <ul class="nav nav-sm nav-tabs  nav-tabs-component">
                                                    <li class="<g:if test="${defaultTab == 0}">active</g:if>"><a href="#left-icon-tab1" data-toggle="tab">1: Chad Details</a></li >

                                                    <li  class="<g:if test="${defaultTab == 1}">active</g:if>"><a href="#left-icon-tab2" data-toggle="tab">2: Activity List</a></li>


                                                   </ul>
                                          <div class="tab-content">
                                                            <div class="tab-pane <g:if test="${defaultTab == 0}">active</g:if>" id="left-icon-tab1">
                                                                <g:render template="details" bean="mkpUser"/>

                                                            </div>

                                                             <div class="tab-pane  <g:if test="${defaultTab == 1}">active</g:if>" id="left-icon-tab2">
                                                                                    <g:render template="activitylist" bean="mkpUser"/>

                                                                                </div>

                                                   </div>

                       </div>

</div>




                    </div>
                </div>




    </body>
</html>
