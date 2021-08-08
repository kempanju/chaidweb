
<%
    def userIntance =com.chaid.security.MkpUser.get(sec.loggedInUserInfo(field: 'id'))

    def activePage = session["activePage"]



%>

<div class="sidebar sidebar-main sidebar-default">
    <div class="sidebar-content">

        <!-- User menu -->
        <div class="sidebar-user">
            <div class="category-content">
                <sec:ifLoggedIn>

                    <div class="media">
                        <a href="#" class="media-left">
                            <img
                                    src="${createLinkTo(dir: 'images', file: 'default_user.jpg')}"
                                    class="img-circle img-sm" alt="">

                        </a>

                        <div class="media-body">
                            <g:link controller="lawyers" action="show"><span
                                    class="media-heading text-semibold">${userIntance.full_name}
                            </span></g:link>
                            <div class="text-size-mini text-muted">
                                <i class="icon-user text-size-small"></i> &nbsp;<sec:loggedInUserInfo field='username'/>
                            </div>

                        </div>

                    </div>
                </sec:ifLoggedIn>
            </div>
        </div>
        <!-- /user menu -->


        <!-- Main navigation -->
        <div class="sidebar-category sidebar-category-visible">
            <div class="category-content no-padding">
                <ul class="navigation navigation-main navigation-accordion">

                    <sec:ifLoggedIn>

                        <li class="<g:if test="${activePage == 'dashboard'}">active</g:if>">
                            <g:link class="list" controller="home" action="dashboard"><i
                                    class=" icon-user"></i> <span><g:message code="my.application"
                                                                                  default="Dashboard"/></span></g:link>
                        </li>
                    <sec:ifAnyGranted roles="ROLE_CORE_WEB,ROLE_ADMIN">

      <li class="<g:if test="${activePage == 'mkchaid'}">active</g:if>">
                                                        <a href="#"><i class="icon-select2"></i> <span>Activity</span></a>
                                                        <ul>
                                                            <li><g:link controller='mkChaid' action="index">Activity</g:link></li>



                                                        </ul>
                                                    </li>



                        <li class="<g:if test="${activePage == 'household'}">active</g:if>">
                            <g:link class="list" controller="household" action="index"><i
                                    class="icon-clipboard3"></i> <span><g:message code="my.publication"
                                                                                  default="Households"/></span></g:link>
                        </li>

                         <li class="<g:if test="${activePage == 'facility'}">active</g:if>">
                                                    <g:link class="list" controller="facility" action="index"><i
                                                            class=" icon-circle"></i> <span><g:message code="my.publication"
                                                                                                          default="Facilities"/></span></g:link>
                                                </li>

            <li class="<g:if test="${activePage == 'reports'}">active</g:if>">
                                                          <a href="#"><i class="icon-file-excel"></i> <span>Reports</span></a>
                                                          <ul>
                                                        <li><g:link controller='home' action="reportByVillage">General Reports</g:link></li>

                                                     <li><g:link controller='home' action="reportByRegistered">Registered</g:link></li>
                                                        <li><g:link controller='home' action="reportByReached">Reached</g:link></li>

                                                     <li><g:link controller='home' action="reportByReferralsGenerated">Referrals</g:link></li>
                                                     <li><g:link controller='home' action="reportByHealthEducation">Health Education</g:link></li>
                                                        <li><g:link controller='home' action="chwActivity">CHW Activity Report</g:link></li>
                                                        <li><g:link controller='home' action="chwReferral">CHW Referral Report</g:link></li>
                                                            <li><g:link controller='home' action="reportTool">Report Tools</g:link></li>

                                                        <li><g:link controller='home' action="map">Map</g:link></li>

                                                          </ul>

                                   </li>



<li class="<g:if test="${activePage == 'dictionary'}">active</g:if>">
                                                    <a href="#"><i class="icon-book"></i> <span>Dictionary</span></a>
                                                    <ul>
                         <li class="<g:if test="${activePage == 'dictionary'}">active</g:if>">
                                                    <g:link class="list" controller="dictionary" action="index"><i
                                                            class=" icon-book"></i> <span><g:message code="my.documents"
                                                                                                          default="Parent Dictionary"/></span></g:link>
                                                </li>


                                                  <li class="<g:if test="${activePage == 'dictionaryitem'}">active</g:if>">
                                                                                                    <g:link class="list" controller="dictionaryItem" action="index"><i
                                                                                                            class="icon-file-text"></i> <span><g:message code="my.lawyers"
                                                                                                                                                          default="Dictionary Item"/></span></g:link>
                                                                                                </li>
</ul>
</li>
                                         <li class="<g:if test="${activePage == 'logs'}">active</g:if>">
                                                                    <g:link class="list" controller="systemLogs" action="index"><i
                                                                            class=" icon-file-text"></i> <span><g:message code="my.publication"
                                                                                                                          default="Logs"/></span></g:link>
                                                                </li>
 <li class="<g:if test="${activePage == 'users'}">active</g:if>">
                            <g:link class="list" controller="mkpUser" action="index"><i
                                    class=" icon-users"></i> <span><g:message code="my.publication"
                                                                                  default="Users"/></span></g:link>
                        </li>




                           <li class="<g:if test="${activePage == 'location'}">active</g:if>">
                                                    <a href="#"><i class="icon-map"></i> <span>Location</span></a>
                                                    <ul>
                                                        <li><g:link controller='region' action="index">Region</g:link></li>

                                                        <li><g:link controller='district' action="index">District</g:link>
                                                        </li>
                                                        <li><g:link controller='wards' action="index">Wards</g:link>
                                                        </li>

                                                         <li><g:link controller='street' action="index">Village</g:link>
                                                                                                                </li>
  <li><g:link controller='subStreet' action="index">Hamlets</g:link>
                                                                                                                </li>


                                                    </ul>
                                                </li>

                        <li class="<g:if test="${activePage == 'password'}">active</g:if>">
                            <g:link controller='applicant' action="password"><i class="icon-key"></i> <span><g:message
                                    code="password" default="Password Setting"/></span></g:link>
                        </li>

                    </sec:ifAnyGranted>
                        <sec:ifAnyGranted roles="ROLE_REGION">
    <li class="<g:if test="${activePage == 'mkchaid'}">active</g:if>">
                            <g:link class="list" controller="mkChaid" action="byRegion"><i
                                    class=" icon-select2"></i> <span><g:message code="my.activity.application"
                                                                                  default="Activity"/></span></g:link>
                        </li>

        <li class="<g:if test="${activePage == 'household'}">active</g:if>">
                                <g:link class="list" controller="household" action="byRegion"><i
                                        class="icon-clipboard3"></i> <span><g:message code="my.publication"
                                                                                      default="Households"/></span></g:link>
                            </li>
     <li class="<g:if test="${activePage == 'facility'}">active</g:if>">
                                    <g:link class="list" controller="facility" action="byRegion"><i
                                            class=" icon-circle"></i> <span><g:message code="my.publication"
                                                                                          default="Facilities"/></span></g:link>
                                </li>
  <li class="<g:if test="${activePage == 'reports'}">active</g:if>">
                                                          <a href="#"><i class="icon-file-excel"></i> <span>Reports</span></a>
                                                          <ul>
                                                        <li><g:link controller='home' action="reportByRegion">General Reports</g:link></li>
                                                        <li><g:link controller='home' action="chwActivity">CHW Activity Report</g:link></li>
                                                        <li><g:link controller='home' action="chwReferral">CHW Referral Report</g:link></li>

                                                          </ul>

                                   </li>




    </sec:ifAnyGranted>

    <sec:ifAnyGranted roles="ROLE_DISTRICT">
      <li class="<g:if test="${activePage == 'mkchaid'}">active</g:if>">
                              <g:link class="list" controller="mkChaid" action="byDistrict"><i
                                      class=" icon-select2"></i> <span><g:message code="my.activity.application"
                                                                                    default="Activity"/></span></g:link>
                          </li>

          <li class="<g:if test="${activePage == 'household'}">active</g:if>">
                                  <g:link class="list" controller="household" action="byDistrict"><i
                                          class="icon-clipboard3"></i> <span><g:message code="my.publication"
                                                                                        default="Households"/></span></g:link>
                              </li>
       <li class="<g:if test="${activePage == 'facility'}">active</g:if>">
                                      <g:link class="list" controller="facility" action="byDistrict"><i
                                              class=" icon-circle"></i> <span><g:message code="my.publication"
                                                                                            default="Facilities"/></span></g:link>
                                  </li>
    <li class="<g:if test="${activePage == 'reports'}">active</g:if>">
                                                            <a href="#"><i class="icon-file-excel"></i> <span>Reports</span></a>
                                                            <ul>
                                                          <li><g:link controller='home' action="reportByDistrict">General Reports</g:link></li>
                                                          <li><g:link controller='home' action="chwActivity">CHW Activity Report</g:link></li>
                                                          <li><g:link controller='home' action="chwReferral">CHW Referral Report</g:link></li>

                                                            </ul>

                                     </li>




      </sec:ifAnyGranted>


 <li class="<g:if test="${activePage == 'attachment'}">active</g:if>">
                            <g:link class="list" controller="logout"><i
                                    class="icon-switch"></i>  <span><g:message code="log.out"
                                                                               default="Log out"/></span></g:link>
                        </li>
                    </sec:ifLoggedIn>

                </ul>
            </div>
        </div>
        <!-- /main navigation -->

    </div>
</div>