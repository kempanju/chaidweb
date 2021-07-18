 <div class="container col-lg-12" style="margin-top: 10px">
            <div class="row ">
                <div class="col-md-4">
                    <div class="card-counter primary">
                        <i class="fa fa-code-fork"></i>
                        <span class="count-numbers">${chaid.MkChaid.countByDeletedAndDistric(false,districtInstance)}</span>
                        <span class="count-name">Gathering</span>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card-counter danger">
                        <i class="fa fa-legal"></i>
                        <span class="count-numbers">${chaid.Household.countByDeletedAndDistrict_id(false,districtInstance)}</span>
                        <span class="count-name">Households visits</span>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card-counter success">
                        <i class="fa fa-database"></i>
                        <span class="count-numbers">${chaid.Facility.countByDeletedAndDistrict_id(false,districtInstance)}</span>
                        <span class="count-name">Facilities reached</span>
                    </div>
                </div>



                <div class="col-md-4">
                    <div class="card-counter info">
                        <i class="fa fa-building-o"></i>

                        <span class="count-numbers">${houseHoldMember[0][0]}</span>
                        <span class="count-name">Population reached</span>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card-counter info">
                        <i class="fa fa-file"></i>
                        <span class="count-numbers">${chaid.MkChaid.executeQuery("from MkChaid where emergence_status<>0 and deleted=false and distric=:districtInstance",[districtInstance:districtInstance]).size()}</span>
                        <span class="count-name">Referrals</span>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card-counter info">
                        <i class="fa fa-users"></i>
                        <span class="count-numbers">${chaid.MkChaid.executeQuery("from MkChaid where emergence_status=2 and deleted=false  and distric=:districtInstance",[districtInstance:districtInstance]).size()}</span>
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
                title: 'Reached population by Gender',
                is3D: true,
            };

            var chart = new google.visualization.PieChart(document.getElementById('piechart_3d_comp_gender'));
            chart.draw(data, options);
        }


        function drawChartCategory() {
            var data = google.visualization.arrayToDataTable([
                ['Task', ' Visit Type'],
                <g:each  in="${admin.DictionaryItem.findAllByDictionary_id(admin.Dictionary.findByCode("CHAD4"))}" var="lawyerDataInstance">

                ["${lawyerDataInstance.name}", ${chaid.MkChaid.executeQuery("from MkChaid where visit_type=:visit_type and distric=:districtInstance and deleted=false",[visit_type:lawyerDataInstance,districtInstance:districtInstance]).size()}],
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

                        ["${lawyerDataInstance.name}", ${chaid.AvailableMemberHouse.executeQuery("from AvailableMemberHouse where type_id=:visit_type and chaid.deleted=false and chaid.distric=:districtInstance",[visit_type:lawyerDataInstance,districtInstance:districtInstance]).size()}],
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
                ['Task', 'Types of gathering reached'],
                <g:each  in="${admin.DictionaryItem.findAllByDictionary_id(admin.Dictionary.findByCode("CHAD5"))}" var="lawyerDataInstances">

                ["${lawyerDataInstances.name}", ${chaid.MkChaid.executeQuery("from MkChaid where meeting_type=:meeting_type and distric=:districtInstance and deleted=false",[meeting_type:lawyerDataInstances,districtInstance:districtInstance]).size()}],
                </g:each>

            ]);

            var options = {
                title: 'Types of gathering reached',
                is3D: true,
            };

            var chart = new google.visualization.PieChart(document.getElementById('piechart_3d_comp_crime'));
            chart.draw(data, options);
        }

</script>

