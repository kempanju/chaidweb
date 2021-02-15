<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'subStreet.label', default: 'SubStreet')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
       <asset:javascript src="customjs/applicant_module.js"/>


    </head>
    <body>
     <div class="register_dv expert" ng-app="myApplication" ng-controller="referrals" ng-init="linkName='${grailsApplication.config.systemLink.toString()}'">
            <div class="center  panel-body">


 <div class="btn-group btn-breadcrumb">
            <g:link controller="home" action="dashboard" class="btn btn-default"><i
                    class="glyphicon glyphicon-home"></i></g:link>
            <g:link controller="home" action="dashboard" class="btn btn-default">Dashboard</g:link>

            <a href="#"
               class="btn btn-primary">${message(code: 'application.list', default: 'Reports By Registered')} </a>
        </div>
 </div>


 <div class="col-md-12  panel">

   <form name="searchForm" ng-submit="registeredReportByDate()">

      <div class="col-md-3">

                                    <div class="form-group">

                                                        <div class="col-lg-10">
                                                            <g:select name="facility" id="facility" value="${params?.facility}" ng-model="insert.facility" ng-change="updateReferrals()"
                                                                      from="${chaid.Facility.findAllByDeleted(false)}" optionKey="id" optionValue="name"
                                                                      class="form-control select-search " noSelection="['': message(code:'select.dictionary', default:'Select Facility')]"/>

                                                        </div>
                                                    </div>
                                                    </div>




                    <div class="col-md-3">
                        <div class="form-group">

                            <div class="col-lg-12 ">
         <md-datepicker md-hide-icons="calendar" md-placeholder="From Date" 	 ng-model="insert.start_date" "></md-datepicker>

                            </div>
                        </div>
                    </div>


                    <div class="col-md-3">
                        <div class="form-group">

                            <div class="col-lg-12 ">
                              <md-datepicker md-hide-icons="calendar" md-placeholder="To Date" ng-model="insert.end_date" ng-change="selecteddate()"></md-datepicker>

                            </div>
                        </div>
                    </div>
     <div class="col-lg-3">
                    <div class="text-right col-md-3">

                        <button type="submit" class="btn btn-primary">SELECT REPORT
                        </button>
     </div>
     </form>



         </div>
<input type="text" name="linkName" style="display:none" ng-model="linkName" value="${grailsApplication.config.systemLink.toString()}"/>


   <div class="container col-md-12" style="margin-top: 10px">


                        <div class="col-md-8">
                                <table class="table  customers">
                                    <tr>
                                        <td colspan="2"><h5>
                                            <span class="text-bold"><g:message code="dictionary.details" default="Referrals Report"/></span>
                                        </h5></td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <span class="text-semibold"><g:message code="Pregnant.Women" default="Referrals from CHWs"/></span>
                                        </td>
                                        <td><span
                                                class="text-bold">{{report.referrals.referrals_no}}</span>
                                        </td> </tr>
       <tr>
                                          <td>
                                              <span class="text-semibold"><g:message code="Pregnant.Women" default="Pregnant women referrals generated"/></span>
                                          </td>
                                          <td><span
                                                  class="text-bold">{{report.referrals.pregnant_no}}</span>
                                          </td>
                                      </tr>
      <tr>
                                               <td>
                                                   <span class="text-semibold"><g:message code="Pregnant.Women" default="Breastfeeding above 42 days"/></span>
                                               </td>
                                               <td><span
                                                       class="text-bold">{{report.referrals.breast_feeding_above_no}}</span>
                                               </td>
                                           </tr>
  </tr>
      <tr>
                                               <td>
                                                   <span class="text-semibold"><g:message code="Pregnant.Women" default="Neonates (under 28 days of age)"/></span>
                                               </td>
                                               <td><span
                                                       class="text-bold">{{report.referrals.neonates_no}}</span>
                                               </td>
                                           </tr>
       </tr>
           <tr>
                                                    <td>
                                                        <span class="text-semibold"><g:message code="Pregnant.Women" default="Infants ( 1 month to under 1 year of age)"/></span>
                                                    </td>
                                                    <td><span
                                                            class="text-bold">{{report.referrals.infants_no}}</span>
                                                    </td>
                                                </tr>
     </tr>
         <tr>
                                                  <td>
                                                      <span class="text-semibold"><g:message code="Pregnant.Women" default="Children ( 1 year to under 5 years)	"/></span>
                                                  </td>
                                                  <td><span
                                                          class="text-bold">{{report.referrals.children_under_five_no}}</span>
                                                  </td>
                                              </tr>


                      </table>
</div>

  <div class="col-md-6">

  </div>

   </div>

   <script type="text/javascript">
       $(".form_datetime").datetimepicker({format: 'yyyy-mm-dd hh:mm'});
   </script>

       </body>
   </html>