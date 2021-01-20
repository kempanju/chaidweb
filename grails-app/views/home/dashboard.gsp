
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'dictionaryItem.label', default: 'DictionaryItem')}"/>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

    <title>Dashboard</title>


    <script type="text/javascript">
        google.charts.load("current", {packages: ["corechart"]});

        google.charts.setOnLoadCallback(drawChartGender);
        google.charts.setOnLoadCallback(drawChartCategory);
        google.charts.setOnLoadCallback(drawChartCrimeType);
        google.charts.setOnLoadCallback(drawChartPopulationType);

        function drawChartGender() {
            var data = google.visualization.arrayToDataTable([
                ['Task', 'Chad numbers'],
                ['Male', ${houseHoldMember[0][1]}],
                ['Female', ${houseHoldMember[0][2]}],

            ]);

            var options = {
                title: 'Gender Graph',
                is3D: true,
            };

            var chart = new google.visualization.PieChart(document.getElementById('piechart_3d_comp_gender'));
            chart.draw(data, options);
        }


        function drawChartCategory() {
            var data = google.visualization.arrayToDataTable([
                ['Task', ' Visit Type'],
                <g:each  in="${admin.DictionaryItem.findAllByDictionary_id(admin.Dictionary.findByCode("CHAD4"))}" var="lawyerDataInstance">

                ["${lawyerDataInstance.name}", ${chaid.MkChaid.executeQuery("from MkChaid where visit_type=:visit_type",[visit_type:lawyerDataInstance]).size()}],
                </g:each>

            ]);

            var options = {
                title: 'Visit Type',
                is3D: true,
            };

            var chart = new google.visualization.PieChart(document.getElementById('piechart_3d_comp_population'));
            chart.draw(data, options);
        }


         function drawChartPopulationType() {
                    var data = google.visualization.arrayToDataTable([
                        ['Task', ' Available Members'],
                        <g:each  in="${admin.DictionaryItem.findAllByDictionary_id(admin.Dictionary.findByCode("CHAD17"))}" var="lawyerDataInstance">

                        ["${lawyerDataInstance.name}", ${chaid.AvailableMemberHouse.executeQuery("from AvailableMemberHouse where type_id=:visit_type and chaid.deleted=false",[visit_type:lawyerDataInstance]).size()}],
                        </g:each>

                    ]);

                    var options = {
                        title: 'Available Members',
                        is3D: true,
                    };

                    var chart = new google.visualization.PieChart(document.getElementById('piechart_3d_comp'));
                    chart.draw(data, options);
                }



        function drawChartCrimeType() {
            var data = google.visualization.arrayToDataTable([
                ['Task', ' Meeting Type'],
                <g:each  in="${admin.DictionaryItem.findAllByDictionary_id(admin.Dictionary.findByCode("CHAD5"))}" var="lawyerDataInstances">

                ["${lawyerDataInstances.name}", ${chaid.MkChaid.executeQuery("from MkChaid where meeting_type=:meeting_type",[meeting_type:lawyerDataInstances]).size()}],
                </g:each>

            ]);

            var options = {
                title: 'Meeting Type',
                is3D: true,
            };

            var chart = new google.visualization.PieChart(document.getElementById('piechart_3d_comp_crime'));
            chart.draw(data, options);
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



        <div class="container col-lg-12" style="margin-top: 10px">
            <div class="row ">
                <div class="col-md-4">
                    <div class="card-counter primary">
                        <i class="fa fa-code-fork"></i>
                        <span class="count-numbers">${chaid.MkChaid.countByDeleted(false)}</span>
                        <span class="count-name">Activity</span>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card-counter danger">
                        <i class="fa fa-legal"></i>
                        <span class="count-numbers">${chaid.Household.count()}</span>
                        <span class="count-name">Households</span>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card-counter success">
                        <i class="fa fa-database"></i>
                        <span class="count-numbers">${chaid.Facility.countByDeleted(false)}</span>
                        <span class="count-name">Facilities</span>
                    </div>
                </div>



                <div class="col-md-4">
                    <div class="card-counter info">
                        <i class="fa fa-building-o"></i>

                        <span class="count-numbers">${houseHoldMember[0][0]}</span>
                        <span class="count-name">Population</span>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card-counter info">
                        <i class="fa fa-file"></i>
                        <span class="count-numbers">${chaid.MkChaid.executeQuery("from MkChaid where emergence_status<>0 and deleted=false").size()}</span>
                        <span class="count-name">Referrals</span>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card-counter info">
                        <i class="fa fa-users"></i>
                        <span class="count-numbers">${chaid.MkChaid.executeQuery("from MkChaid where emergence_status=2 and deleted=false").size()}</span>
                        <span class="count-name">Responded Referrals</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-6 text-center" style="padding: 10px">
            <div id="piechart_3d_comp_gender" style="width: 100%;min-height: 300px;margin-top: 5px"></div>

        </div>
        <div class="col-lg-6 text-center" style="padding: 10px">
            <div id="piechart_3d_comp" style="width: 100%;min-height: 300px;margin-top: 5px"></div>

        </div>

        <div class="col-lg-6 text-center" style="padding: 10px">
            <div id="piechart_3d_comp_crime" style="width: 100%;min-height: 300px;margin-top: 1px"></div>

        </div>
<div class="col-lg-6 text-center" style="padding: 10px">
            <div id="piechart_3d_comp_population" style="width: 100%;min-height: 300px;margin-top: 1px"></div>

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
