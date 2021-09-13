<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'subStreet.label', default: 'SubStreet')}" />
        <title>Reports</title>
<style>
th {
  position: sticky;
  top: 0;
  z-index: 2;
  white-space:wrap;
}
</style>
  </head>
    <body>
     <div class="register_dv expert">
            <div class="center  panel-body">


 <div class="btn-group btn-breadcrumb">
            <g:link controller="home" action="dashboard" class="btn btn-default"><i
                    class="glyphicon glyphicon-home"></i></g:link>
            <g:link controller="home" action="dashboard" class="btn btn-default">Dashboard</g:link>

            <a href="#"
               class="btn btn-primary">${message(code: 'application.list', default: 'Reports')} </a>
        </div>



    <div class="col-lg-12  panel-body">

     <form name="searchForm" ng-submit="registeredReportByDate()">


          <div class="form-group">

            <div class="col-lg-2">
            <select id="selectedOption" name="selectedOption" onchange="callOption(this)">
            <option value="country">Country</option>
            <option value="region">Region</option>
            <option value="district">District</option>
            </select>
            </div>


             <div class="col-lg-3" id="regionId" style="display:none">
                              <g:select name="region_id" id="region_id" value="" onchange="getReports(this)"
                                        data-show-subtext="true" data-live-search="true"
                                        from="${admin.Region.list()}" optionKey="id" optionValue="name"
                                        class="form-control " noSelection="['': 'Region']"/>

                          </div>
     <div class="col-lg-3" id="districtId" style="display:none">
      <g:select name="district_id" id="district_id" value="" onchange="getReports(this)"
                data-show-subtext="true" data-live-search="true"
                from="${admin.District.findAllByD_deleted(false)}" optionKey="id" optionValue="name"
                class="form-control " noSelection="['': 'District']"/>

  </div>
       <div class="col-lg-3" id="list-village" style="display:none">
            </div>
    <div class="col-lg-3">
                          <div class="form-group">
                              <div class="col-lg-10 input-append date form_datetime">
                                  <input type="text" id="from_date" placeholder="From Date" onchange="getReports()" name="from_date" value="${params.end_date}" readonly required="required" class="form-control"/>
                                  <span class="add-on"><i class="icon-th"></i></span>

                              </div>
                          </div>
                      </div>
       <div class="col-lg-3">
                          <div class="form-group">
                              <div class="col-lg-10 input-append date form_datetime">
                                  <input type="text" placeholder="To Date" id="end_date" name="end_date" value="${params.end_date}" readonly required="required" onchange="getReports()" class="form-control"/>
                                  <span class="add-on"><i class="icon-th"></i></span>

                              </div>
                          </div>
                      </div>


    </div>

       </form>

          </div>


<g:render template="/report/monthlydata"/>



 </div>

  </div>
   <script type="text/javascript">
       $(".form_datetime").datetimepicker({format: 'yyyy-mm-dd hh:mm'});
   </script>

       </body>
   </html>