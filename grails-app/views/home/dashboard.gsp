
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'dictionaryItem.label', default: 'DictionaryItem')}"/>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

    <title>Dashboard</title>


    <script type="text/javascript">



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
var selectedOption=$("#selectedOption").val();

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
            </div>
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

                        <div class="col-lg-3" id="districtId" style="display:none">
                            <g:select name="district_id" id="district_id" value="" onchange="getReports(this)"
                                      data-show-subtext="true" data-live-search="true"
                                      from="${admin.District.findAllByD_deleted(false)}" optionKey="id" optionValue="name"
                                      class="form-control " noSelection="['': 'District']"/>

                        </div>
            <div class="col-lg-3" id="regionId" style="display:none">
                             <g:select name="region_id" id="region_id" value="" onchange="getReports(this)"
                                       data-show-subtext="true" data-live-search="true"
                                       from="${admin.Region.list()}" optionKey="id" optionValue="name"
                                       class="form-control " noSelection="['': 'Region']"/>

                         </div>
</div>
</form>
</div>

<div id="dashboard-data">
<g:render template="dashboardcountry" />
</div>


        </div>

    <div id="map" class="col-lg-10"></div>
       <script>


           // Initialize and add the map
           function initMap() {

               var locations=[
                   <g:each  in="${chaid.MkChaid.executeQuery("from MkChaid where centroid_y>0 and deleted=false")}" status="i" var="locInstance">

                   ['${locInstance.created_by.full_name}',${locInstance.centroid_x}, ${locInstance.centroid_y},${i+1}],
                   </g:each>
               ];
               // The location of Uluru
               var uluru = {lat: -6.369028, lng: 34.888822};
               // The map, centered at Uluru
               var map = new google.maps.Map(
                   document.getElementById('map'), {zoom: 7, center: uluru});
               // The marker, positioned at Uluru
               var marker = new google.maps.Marker({position: uluru, map: map , icon:{
                       url:'http://maps.google.com/mapfiles/ms/icons/blue-dot.png'
                   }});

               var infowindow = new google.maps.InfoWindow();

               var marker, i;

               for (i = 0; i < locations.length; i++) {
                   marker = new google.maps.Marker({
                       position: new google.maps.LatLng(locations[i][1], locations[i][2]),
                       map: map
                   });

                   google.maps.event.addListener(marker, 'click', (function (marker, i) {
                       return function () {
                           infowindow.setContent(locations[i][0]);
                           infowindow.open(map, marker);
                       }
                   })(marker, i));
               }





           }
       </script>


</div>
<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBPB9AxnZBelfaOOLgATTB2B-t3BR685eE&callback=initMap">
</script>

<script type="text/javascript">
    $(".form_datetime").datetimepicker({format: 'yyyy-mm-dd hh:mm'});
</script>
</body>
</html>
