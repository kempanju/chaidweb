
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'dictionaryItem.label', default: 'DictionaryItem')}"/>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

    <title>Dashboard</title>

                    <sec:ifAnyGranted roles="ROLE_CORE_WEB,ROLE_ADMIN">


    <script type="text/javascript">
$( document ).ready(function() {

  getReports();
});


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


function getReports(){
var district_id=$("#district_id").val();
var region_id=$("#region_id").val();
var village_id=$("#village_id").val();
var selectedOption=$("#selectedOption").val();
$('.loader').show();

  $.ajax({
                        url: '${grailsApplication.config.systemLink.toString()}/home/dashboardFilter',
                        data: {'district_id': district_id,'region_id':region_id,'village_id':village_id,'selectedOption':selectedOption}, // change this to send js object
                        type: "post",
                        success: function (data) {
                            //document.write(data); just do not use document.write
                            $("#dashboard-data").html(data);
                            //console.log(data);
                            $('.loader').hide();

                        }
                    });

var lengthDistrict=document.getElementById("village_id");


if(selectedOption=="district"&&!lengthDistrict){
getVillagesByDistrict(district_id);
}


}
 function getVillagesByDistrict(ids){


                 $.ajax({
                     url: '${grailsApplication.config.systemLink.toString()}/home/search_village_list?src=1',
                     data: {'id': ids}, // change this to send js object
                     type: "post",
                     success: function (data) {
                    // alert("Done");
                         //document.write(data); just do not use document.write
                         $("#list-village").html(data);
                         $("#list-village").show();

                         //console.log(data);
                     }
                 });


     }
    </script>
 </sec:ifAnyGranted>


 <sec:ifAnyGranted roles="ROLE_REGION">


     <script type="text/javascript">

$( document ).ready(function() {
  $("#districtId").show();

  getReports();
});


 function callOption (data){
 var selectedItem=data.value;
 $("#village-report").empty();
 $("#districtId").show();

 }


 function getReports(){
 var district_id=$("#district_id").val();
 var region_id=$("#region_id").val();
 var selectedOption=$("#selectedOption").val();
 if(region_id){
 selectedOption="region";
 }
 if(district_id){
  selectedOption="district";
  }
                            $('.loader').show();

   $.ajax({
                         url: '${grailsApplication.config.systemLink.toString()}/home/dashboardFilter',
                         data: {'district_id': district_id,'region_id':region_id,'selectedOption':selectedOption}, // change this to send js object
                         type: "post",
                         success: function (data) {
                        // alert("Done");
                             //document.write(data); just do not use document.write
                             $("#dashboard-data").html(data);
                             $('.loader').hide();

                             //console.log(data);
                         }
                     });


getVillagesByDistrict(district_id);
 }

  function getVillagesByDistrict(idsData){
     var ids = idsData.value;


                 $.ajax({
                     url: '${grailsApplication.config.systemLink.toString()}/home/search_village_list?src=1',
                     data: {'id': ids}, // change this to send js object
                     type: "post",
                     success: function (data) {
                    // alert("Done");
                         //document.write(data); just do not use document.write
                         $("#list-village").html(data);
                         //console.log(data);
                     }
                 });


     }

     </script>
  </sec:ifAnyGranted>


   <sec:ifAnyGranted roles="ROLE_DISTRICT">


       <script type="text/javascript">

  $( document ).ready(function() {
    $("#districtId").show();

    getReports();
  });


   function callOption (data){
   var selectedItem=data.value;
   $("#village-report").empty();
   $("#districtId").show();

   }


   function getReports(){
   var district_id="${currentUser?.district_id?.id}";
   var region_id=$("#region_id").val();
   var selectedOption=$("#selectedOption").val();
   if(district_id){
   selectedOption="district";
   }

     $.ajax({
                           url: '${grailsApplication.config.systemLink.toString()}/home/dashboardFilter',
                           data: {'district_id': district_id,'region_id':region_id,'selectedOption':selectedOption}, // change this to send js object
                           type: "post",
                           success: function (data) {
                          // alert("Done");
                               //document.write(data); just do not use document.write
                               $("#dashboard-data").html(data);
                               //console.log(data);
                           }
                       });



   }

       </script>
    </sec:ifAnyGranted>



      <style>
        /* Set the size of the div element that contains the map */
        #map {
            height: 400px;  /* The height is 400 pixels */
            width: 100%;  /* The width is the width of the web page */
        }
        </style>
</head>

<body>

<div class="register_dv expert">

    <div class="center panel_div_list panel">



        <div class="row panel-flat back_white">
            <div class="btn-group btn-breadcrumb">
                <g:link controller="home" action="dashboard" class="btn btn-primary"><i
                        class="glyphicon glyphicon-home"></i></g:link>

                <a href="#"
                   class="btn btn-default">${message(code: 'dashboard', default: 'Dashboard')}</a>

                  <a href="#"
                               class="btn btn-primary">
                        <sec:ifAnyGranted roles="ROLE_REGION">
                        ${currentUser?.region?.name}
                        </sec:ifAnyGranted>

                           <sec:ifAnyGranted roles="ROLE_DISTRICT">
                                                ${currentUser?.district_id?.name}
                                                </sec:ifAnyGranted>
                                      <sec:ifAnyGranted roles="ROLE_CORE_WEB,ROLE_ADMIN">
                                      National
 </sec:ifAnyGranted>

                               </a>
            </div>
        </div>

 <div class="col-lg-12  panel-body">
  <form name="searchForm" ng-submit="registeredReportByDate()">


         <div class="form-group">
                    <sec:ifAnyGranted roles="ROLE_CORE_WEB,ROLE_ADMIN">

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
 </sec:ifAnyGranted>
  <sec:ifAnyGranted roles="ROLE_REGION">
  <g:hiddenField name="region_id" id="region_id" value="${currentUser?.region?.id}"/>
    <g:hiddenField name="region_id" id="region_id" value="${currentUser?.region?.id}"/>

  <div class="col-lg-3" id="districtId" style="display:none">
    <g:select name="district_id" id="district_id" value="" onchange="getReports(this)"
              data-show-subtext="true" data-live-search="true"
              from="${admin.District.findAllByD_deletedAndRegion_id(false,currentUser.region)}" optionKey="id" optionValue="name"
              class="form-control " noSelection="['': 'District']"/>

</div>
  </sec:ifAnyGranted>


</div>
</form>
</div>

<div id="dashboard-data">
                    <sec:ifAnyGranted roles="ROLE_CORE_WEB,ROLE_ADMIN">

                    </sec:ifAnyGranted>

</div>
</div>


        </div>



</div>

<script type="text/javascript">
    $(".form_datetime").datetimepicker({format: 'yyyy-mm-dd hh:mm'});
</script>
</body>
</html>
