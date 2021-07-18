<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'subStreet.label', default: 'SubStreet')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
       <asset:javascript src="customjs/applicant_module.js"/>


    </head>
    <body>
     <div class="register_dv expert" ng-app="myApplication" ng-controller="chwActivity" ng-init="linkName='${grailsApplication.config.systemLink.toString()}'">
            <div class="center  panel-body">


 <div class="btn-group btn-breadcrumb">
            <g:link controller="home" action="dashboard" class="btn btn-default"><i
                    class="glyphicon glyphicon-home"></i></g:link>
            <g:link controller="home" action="dashboard" class="btn btn-default">Dashboard</g:link>

            <a href="#"
               class="btn btn-primary">${message(code: 'application.list', default: 'Reports By CHW Activity')} </a>
        </div>
 </div>


 <div class="col-md-12  panel"  style="max-height:600px;overflow: auto;">

   <form name="searchForm" ng-submit="chwReportByDate()">

      <div class="col-md-3">

                                    <div class="form-group">

                                                        <div class="col-lg-10">
                                                            <g:select name="district" id="district" value="${params?.district}" ng-model="insert.district" ng-change="updateChwReport()"
                                                                      from="${admin.District.list()}" optionKey="id" optionValue="name"
                                                                      class="form-control select-search " noSelection="['': message(code:'select.dictionary', default:'Select District')]"/>

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


   <div class="col-md-12" style="margin-top: 10px">
        <div class="panel-body success"><div class="col-lg-5"><h5>Total CHW: {{report.length}}</h5></div>
         <div class="col-lg-5"><h5>Sum of Reports:{{calculateTotal(report)|number}}</h5></div>

                        <div class="col-md-12">
                                <table class="table  table-bordered">

                                <thead>
                                <tr>
                                <th>#</th>
                                <th>CHW</th>
                                <th>Village</th>
                                <th>Report Submitted</th>
                                <th>Location</th>
                                </tr>
                                </thead>

                                <tbody>
                                    <tr ng-repeat="row in report">
                                    <td>{{$index + 1}}</td>
                              <td><g:link controller="mkpUser" action="show" id="{{row.id}}">{{row.full_name}}</g:link></td>
                                 <td class="active">{{row.village}}</td>
                                <td class="success">{{row.report_no}}</td>
                                   <td>{{row.facility}}</td>
                                    </tr>
                                </tbody>


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