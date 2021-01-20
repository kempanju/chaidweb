<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'subStreet.label', default: 'SubStreet')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
     <div class="register_dv expert" ng-app="myApplication" ng-controller="myCtrl" ng-init="linkName='${grailsApplication.config.systemLink.toString()}'">
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

   <div class="col-md-3">

                                 <div class="form-group">
                                                     <label class="control-label col-lg-8 text-bold"><g:message code="dictionary" default="Facility Name"/> </label>

                                                     <div class="col-lg-8">
                                                         <g:select name="facility" id="facility" value="${params?.facility}" ng-model="selectedItem" ng-change="updateRegistered()"
                                                                   from="${chaid.Facility.findAllByDeleted(false)}" optionKey="id" optionValue="name"
                                                                   class="form-control select-search " noSelection="['': message(code:'select.dictionary', default:'Select Facility')]"/>

                                                     </div>
                                                 </div>
                                                 </div>

                 <div class="col-md-3">
                     <div class="form-group">
                         <label class="control-label col-lg-5 text-bold">From Date</label>


                         <div class="col-lg-10 input-append date form_datetime">
                             <input type="text" ng-model="start_date" readonly required="required" class="form-control"/>
                             <span class="add-on"><i class="icon-th"></i></span>

                         </div>
                     </div>
                 </div>

                 <div class="col-md-3">
                     <div class="form-group">
                         <label class="control-label col-lg-5 text-bold">To Date</label>

                         <div class="col-lg-10 input-append date form_datetime">
                             <input type="text" ng-model="end_date"  readonly required="required" class="form-control"/>
                             <span class="add-on"><i class="icon-th"></i></span>

                         </div>
                     </div>
                 </div>
  <div class="col-lg-3">
                 <div class="text-right col-md-3">
                                         <label class="control-label col-lg-5 text-bold">..</label>

                     <button type="submit" ng-click="registeredReportByDate()" class="btn btn-primary">SELECT REPORT
                     </button>
  </div>
                 </div>

         </div>
<input type="text" name="linkName" style="display:none" ng-model="linkName" value="${grailsApplication.config.systemLink.toString()}"/>


   <div class="container col-md-12" style="margin-top: 10px">


                        <div class="col-md-10">
                                <table class="table  customers">
                                    <tr>
                                        <td colspan="2"><h5>
                                            <span class="text-bold"><g:message code="dictionary.details" default="Registered Report"/></span>
                                        </h5></td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <span class="text-semibold"><g:message code="Pregnant.Women" default="Pregnant Women"/></span>
                                        </td>
                                        <td><span
                                                class="text-bold">{{report.registered.pregnant_no}}</span>
                                        </td> </tr>
       <tr>
                                          <td>
                                              <span class="text-semibold"><g:message code="Pregnant.Women" default="Breastfeeding Mother"/></span>
                                          </td>
                                          <td><span
                                                  class="text-bold">{{report.registered.breastFeedingMother}}</span>
                                          </td>
                                      </tr>


      <tr>
                                               <td>
                                                   <span class="text-semibold"><g:message code="Pregnant.Women" default="Neonates (under 28 days of age)"/></span>
                                               </td>
                                               <td><span
                                                       class="text-bold">{{report.registered.neonates_no}}</span>
                                               </td>

       </tr>
           <tr>
                                                    <td>
                                                        <span class="text-semibold"><g:message code="Pregnant.Women" default="Infants ( 1 month to under 1 year of age)"/></span>
                                                    </td>
                                                    <td><span
                                                            class="text-bold">{{report.registered.infants_no}}</span>
                                                    </td>
                                                </tr>
     </tr>
         <tr>
                                                  <td>
                                                      <span class="text-semibold"><g:message code="Pregnant.Women" default="Children ( 1 year to under 5 years)	"/></span>
                                                  </td>
                                                  <td><span
                                                          class="text-bold">{{report.registered.children_under_five_no}}</span>
                                                  </td>
                                              </tr>


<tr>
                                                  <td>
                                                      <span class="text-semibold"><g:message code="Pregnant.Women" default="Adolescents of 10 to 19 years registered"/></span>
                                                  </td>
                                                  <td><span
                                                          class="text-bold">{{report.registered.totalTenToNinteen}}</span>
                                                  </td>
                                              </tr>
<tr>
                                                  <td>
                                                      <span class="text-semibold"><g:message code="Pregnant.Women" default="Youths of 20 to 24 years registered"/></span>
                                                  </td>
                                                  <td><span
                                                          class="text-bold">{{report.registered.totalchildYouth}}</span>
                                                  </td>
                                              </tr>
<tr>
                                                  <td>
                                                      <span class="text-semibold"><g:message code="Pregnant.Women" default="Individuals of 15 to 49 years registered"/></span>
                                                  </td>
                                                  <td><span
                                                          class="text-bold">{{report.registered.totalfifteenToFourty}}</span>
                                                  </td>
                                              </tr>
<tr>
                                                  <td>
                                                      <span class="text-semibold"><g:message code="Pregnant.Women" default="Adults of above 50 years registered"/></span>
                                                  </td>
                                                  <td><span
                                                          class="text-bold">{{report.registered.totalAbove}}</span>
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
       <asset:javascript src="customjs/applicant_module.js"/>

       </body>
   </html>