<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="CHW Activity" />
        <title>Reports</title>
<style>
th {
  position: sticky;
  top: 0;
  z-index: 2;
  white-space:wrap;
}

</style>
<script>
function callOption (data){
var selectedItem=data.value;
$("#village-report").empty();
if(selectedItem=="district"){
    $("#districtId").show();
    $("#regionId").hide();

}
else if(selectedItem=="region"){
$("#districtId").hide();
$("#regionId").show();

}else{
$("#regionId").hide();
$("#districtId").hide();
}
}

$( document ).ready(function() {
   getReports();
});


function getReports(){
var district_id=$("#district_id").val();
var region_id="${currentUser.region.id}";
var end_date=$("#end_date").val();
var from_date=$("#from_date").val();
var selectedOption="region";
if((end_date&&from_date)||selectedOption=="region"){

  $.ajax({
                        url: '${grailsApplication.config.systemLink.toString()}/home/searchReportByDate',
                        data: {'district_id': district_id,'region_id':region_id,'end_date':end_date,'from_date':from_date,'selectedOption':selectedOption}, // change this to send js object
                        type: "post",
                        success: function (data) {
                       // alert("Done");
                            //document.write(data); just do not use document.write
                            $("#village-report").html(data);
                            //console.log(data);
                        }
                    });

                    }

}
</script>

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
 </div>
        <div class="col-lg-12  panel-body">

   <form name="searchForm" ng-submit="registeredReportByDate()">


        <div class="form-group">



                       <div class="col-lg-3" id="districtId" >
                           <g:select name="district_id" id="district_id" value="" onchange="getVillageReports(this)"
                                     data-show-subtext="true" data-live-search="true"
                                     from="${admin.District.findAllByD_deletedAndRegion_id(false,currentUser.region)}" optionKey="id" optionValue="name"
                                     class="form-control " noSelection="['': 'District']"/>

                       </div>
           <div class="col-lg-3" id="regionId" style="display:none">
                            <g:select name="region_id" id="region_id" value="" onchange="getDistrictReports(this)"
                                      data-show-subtext="true" data-live-search="true"
                                      from="${admin.Region.list()}" optionKey="id" optionValue="name"
                                      class="form-control " noSelection="['': 'Region']"/>

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
<div class="col-lg-12" style="overflow:auto" id="village-report">

</div>

      </div>
  <script type="text/javascript">
      $(".form_datetime").datetimepicker({format: 'yyyy-mm-dd hh:mm'});
  </script>

      </body>
  </html>