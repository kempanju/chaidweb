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
        <g:set var="entityName" value="${message(code: 'mkChaid.label', default: 'MkChaid')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
         <style>
            /* Set the size of the div element that contains the map */
            #map {
                height: 400px; /* The height is 400 pixels */
                width: 100%; /* The width is the width of the web page */
            }
            </style>
    </head>
    <body>
    <div class="register_dv expert">

        <div class="row panel-flat back_white">
            <div class="btn-group btn-breadcrumb">
                <g:link controller="home" action="dashboard" class="btn btn-default"><i
                        class="glyphicon glyphicon-home"></i></g:link>
                <g:link controller="home" action="dashboard" class="btn btn-default">Dashboard</g:link>
                <g:link action="index"  class="btn btn-default">Chad</g:link>

                <a href="#" class="btn btn-primary text-capitalize">${message(code: 'details', default: 'Details')}</a>

            </div>
        </div>

        <div id="show-mkChaid" class="content scaffold-show panel-body" role="main">


   <div class="tabbable">
                <ul class="nav nav-sm nav-tabs  nav-tabs-component">
                    <li class="<g:if test="${defaultTab == 0}">active</g:if>"><a href="#left-icon-tab1" data-toggle="tab">1: Chad Details</a></li >

                    <li  class="<g:if test="${defaultTab == 1}">active</g:if>"><a href="#left-icon-tab2" data-toggle="tab">2: Status</a></li>

                                     <li  class="<g:if test="${defaultTab == 2}">active</g:if>"><a href="#left-icon-tab3" data-toggle="tab">3: Map</a></li>
                                     <li  class="<g:if test="${defaultTab == 3}">active</g:if>"><a href="#left-icon-tab4" data-toggle="tab">4: Logs</a></li>

                   </ul>


                <div class="tab-content">
                    <div class="tab-pane <g:if test="${defaultTab == 0}">active</g:if>" id="left-icon-tab1">
                        <g:render template="details" bean="mkChaid"/>

                    </div>

                    <div class="tab-pane  <g:if test="${defaultTab == 1}">active</g:if>" id="left-icon-tab2">
                        <g:render template="status" bean="mkChaid"/>

                    </div>

                     <div class="tab-pane  <g:if test="${defaultTab == 2}">active</g:if>" id="left-icon-tab3">
                                            <g:render template="map" bean="mkChaid"/>

                                        </div>

                     <div class="tab-pane  <g:if test="${defaultTab == 3}">active</g:if>" id="left-icon-tab4">
                                                            <g:render template="chadlogs" bean="mkChaid"/>

                                                        </div>


                   <div>

        </div>



        </div>

        </div>


        <script async defer
                src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBPB9AxnZBelfaOOLgATTB2B-t3BR685eE&callback=initMap">
        </script>
    </body>
</html>
