<%@ page import="materialize.view.RegionReport; materialize.view.YearReports; materialize.view.MonthlyReport; materialize.view.ChaidMeetingType; materialize.view.DangerSign; materialize.view.ViewHealthEducation; materialize.view.ChaidVisitType; admin.DictionaryItem; chaid.Household; chaid.MkChaid" %>
<%
def year = new Date().format("yyyy")
def month = new Date().format("MMM")

%>

 <div class="container col-lg-12" style="margin-top: 10px">
            <div class="row ">
                <div class="col-md-3">
                    <div class="card-counter primary">
                        <i class="fa fa-database"></i>
                        <span class="count-numbers">


                        <%
                        def totalChaid= MkChaid.countByDeleted(false)
                        %>
                        ${formatAmountString(name: (int)totalChaid)}
                        </span>
                        <span class="count-name">Gathering</span>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card-counter danger">
                        <i class="fa  fa-bus"></i>
                        <span class="count-numbers">
                        <%
                        def countHouse= Household.countByDeleted(false)
                        %>
                        ${formatAmountString(name: (int)countHouse)}
                        </span>
                        <span class="count-name">Household visits</span>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card-counter success">
                        <i class="fa  fa-bank"></i>
                        <span class="count-numbers">
                        <%
                        def countFacility= MkChaid.executeQuery("select m.facility.id from MkChaid m where m.deleted=false group by m.facility.id").size()
                        %>
                        ${formatAmountString(name: (int)countFacility)}
                        </span>
                        <span class="count-name">Facilities reached</span>
                    </div>
                </div>



                <div class="col-md-3">
                    <div class="card-counter info">
                        <i class="fa  fa-group"></i>

                        <span class="count-numbers"> ${formatAmountString(name: (int)houseHoldMember[0][0])}</span>
                        <span class="count-name">Population reached</span>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card-counter info">
                        <i class="fa fa-paper-plane-o"></i>
                        <span class="count-numbers">${MkChaid.executeQuery("select id from MkChaid where emergence_status<>0 and deleted=false").size()}</span>
                        <span class="count-name">Referrals</span>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card-counter info">
                        <i class="fa fa-envelope-o"></i>
                        <span class="count-numbers">${MkChaid.executeQuery("select id from MkChaid where emergence_status=2 and deleted=false").size()}</span>
                        <span class="count-name">Responded Referrals</span>
                    </div>
                </div>

                 <div class="col-md-3">
                                    <div class="card-counter secondary ">
                                        <i class="fa fa-circle-o"></i>
                                        <span class="count-numbers">${MkChaid.executeQuery("select distric.region_id.id from MkChaid where  deleted=false group by distric.region_id.id").size()}</span>
                                        <span class="count-name">Region Covered</span>
                                    </div>
                                </div>
             <div class="col-md-3">
                                                <div class="card-counter secondary ">
                                                    <i class="fa  fa-clock-o"></i>
                                                    <span class="count-numbers">${MkChaid.executeQuery("select distric.id from MkChaid where  deleted=false group by distric.id").size()}</span>
                                                    <span class="count-name">District Covered</span>
                                                </div>
                                            </div>

            <div class="col-md-3">
                   <div class="card-counter secondary ">
                       <i class="fa fa-certificate"></i>
                       <span class="count-numbers">${MkChaid.executeQuery("select street.ward_id.id from MkChaid where  deleted=false group by street.ward_id.id").size()}</span>
                       <span class="count-name">Wards Covered</span>
                   </div>
               </div>
<div class="col-md-3">
                   <div class="card-counter secondary">
                       <i class="fa fa-circle-o-notch"></i>
                       <span class="count-numbers">
                       <% def villagesNo= MkChaid.executeQuery("select street.id from MkChaid where  deleted=false group by street.id").size()
                       %>
                     ${formatAmountString(name: (int)villagesNo)}

                       </span>
                       <span class="count-name">Village Covered</span>
                   </div>
               </div>
            </div>
        </div>


    <div class="  col-md-12" style="padding: 5px; margin-bottom:40px">

             <div id="columnchart_year" style="width: 600px;height: 300px;"></div>

             </div>
             <div class="  col-md-12" style="padding: 5px; margin-bottom:40px">

                          <div id="columnchart_monthly" style="height: 300px;"></div>

                          </div>

            <div class="  col-md-12" style="padding: 5px; margin-bottom:40px">

                 <div id="columnchart_region" style="height: 300px;"></div>

                 </div>

        <div class="col-lg-6 text-center" style="padding: 5px">
            <div id="piechart_3d_comp_gender" style="width: 100%;min-height: 300px;margin-top: 5px"></div>

        </div>
         <div class="col-lg-6 text-center" style="padding: 5px">
                    <div id="piechart_3d_comp_education" style="width: 100%;min-height: 300px;margin-top: 5px"></div>

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
         google.charts.setOnLoadCallback(drawChartEducationType);
         google.charts.setOnLoadCallback(drawChartYearReports);
         google.charts.setOnLoadCallback(drawChartMonthlyReports);
         google.charts.setOnLoadCallback(drawChartRegionReports);



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
                <g:each  in="${DictionaryItem.findAllByDictionary_id(admin.Dictionary.findByCode("CHAD4"))}" var="lawyerDataInstance">

                ["${lawyerDataInstance.name}", ${ChaidVisitType.executeQuery("select sum(visitcount) from ChaidVisitType where visit_type=:visit_type",[visit_type:lawyerDataInstance])[0]}],
                </g:each>

            ]);

            var options = {
                title: 'Visit Type',
                is3D: true,
            };

            var chart = new google.visualization.PieChart(document.getElementById('piechart_3d_comp_population'));
            chart.draw(data, options);
        }


        function drawChartEducationType() {
                            var data = google.visualization.arrayToDataTable([
                                ['Task', ' Health Education Provided'],
                                <g:each  in="${ViewHealthEducation.executeQuery("select education_type.id,education_type.name from ViewHealthEducation group by education_type.id,education_type.name")}" var="lawyerDataInstance">
                                <%
                                def dictionaryInstance=DictionaryItem.read(lawyerDataInstance[0])
                                %>
                                ["${lawyerDataInstance[1]}", ${materialize.view.ViewHealthEducation.executeQuery(" select d.education_type from ViewHealthEducation d where d.education_type.id=:visit_type ",[visit_type:lawyerDataInstance[0]]).size()}],
                                </g:each>

                            ]);

                            var options = {
                                title: 'Health Education Provided',
                                is3D: true,
                            };

                            var chart = new google.visualization.PieChart(document.getElementById('piechart_3d_comp_education'));
                            chart.draw(data, options);
                        }




         function drawChartPopulationType() {
                    var data = google.visualization.arrayToDataTable([
                        ['Task', ' Population reached by Gender and Age'],
                        <g:each  in="${DangerSign.executeQuery("select signType.id,signType.name from DangerSign group by signType.id,signType.name")}" var="lawyerDataInstance">
                        <%
                        def dictionaryInstance=DictionaryItem.read(lawyerDataInstance[0])
                        %>
                        ["${lawyerDataInstance[1]} (${dictionaryInstance.dictionary_id.name})", ${DangerSign.executeQuery(" select d.signType from DangerSign d where d.signType.id=:visit_type ",[visit_type:lawyerDataInstance[0]]).size()}],
                        </g:each>

                    ]);

                    var options = {
                        title: 'Population reached by Gender and Age (Danger Signs)',
                        is3D: true,
                    };

                    var chart = new google.visualization.PieChart(document.getElementById('piechart_3d_comp'));
                    chart.draw(data, options);
                }



        function drawChartCrimeType() {
            var data = google.visualization.arrayToDataTable([
                ['Task', ' Types of gathering reached'],
                <g:each  in="${DictionaryItem.findAllByDictionary_id(admin.Dictionary.findByCode("CHAD5"))}" var="lawyerDataInstances">
                <%
                def countTotal=ChaidMeetingType.executeQuery("select meetingcount from ChaidMeetingType where meeting_type=:meeting_type",[meeting_type:lawyerDataInstances])[0];
                if(!countTotal){
                countTotal=0;
                }
                %>
                ["${lawyerDataInstances.name}", ${countTotal}],
                </g:each>

            ]);

            var options = {
                title: 'Types of gathering reached',
                is3D: true,
            };

            var chart = new google.visualization.PieChart(document.getElementById('piechart_3d_comp_crime'));
            chart.draw(data, options);
        }

 function drawChartMonthlyReports() {
              var data = google.visualization.arrayToDataTable([
                ["Month", "Gathering", { role: "style" } ],
                 <g:each  in="${MonthlyReport.executeQuery("select day_sum,txn_day from MonthlyReport ")}" var="reportDataInstance">

                ["${formatDateCustomDayGroovy(name:reportDataInstance[1].toString())}", ${reportDataInstance[0]},"#EF5350"],
                </g:each>

              ]);

              var view = new google.visualization.DataView(data);
              view.setColumns([0, 1,
                               { calc: "stringify",
                                 sourceColumn: 1,
                                 type: "string",
                                 role: "annotation" },
                               2]);

              var options = {
                title: "${year} ${month} Daily  Reports",
                width: 900,
                height: 300,
                bar: {groupWidth: "90%"},
                legend: { position: "none" },
              };
              var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_monthly"));
              chart.draw(view, options);
          }

        function drawChartYearReports() {
              var data = google.visualization.arrayToDataTable([
                ["Month", "Gathering", { role: "style" } ],
                 <g:each  in="${YearReports.executeQuery("select monthly_sum,txn_month from YearReports ")}" var="reportDataInstance">

                ["${formatDateCustomGroovy(name:reportDataInstance[1].toString())}", ${reportDataInstance[0]},"#007BFF"],
                </g:each>

              ]);

              var view = new google.visualization.DataView(data);
              view.setColumns([0, 1,
                               { calc: "stringify",
                                 sourceColumn: 1,
                                 type: "string",
                                 role: "annotation" },
                               2]);

              var options = {
                title: "${year} Monthly Reports",
                width: 900,
                height: 300,
                bar: {groupWidth: "90%"},
                legend: { position: "none" },
              };
              var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_year"));
              chart.draw(view, options);
          }




    function drawChartRegionReports() {
                 var data = google.visualization.arrayToDataTable([
                   ["Month", "Gathering", { role: "style" } ],
                    <g:each  in="${RegionReport.executeQuery("select population,region.name from RegionReport ")}" var="reportDataInstance">

                   ["${reportDataInstance[1]}", ${reportDataInstance[0]},"#66BB6A"],
                   </g:each>

                 ]);

                 var view = new google.visualization.DataView(data);
                 view.setColumns([0, 1,
                                  { calc: "stringify",
                                    sourceColumn: 1,
                                    type: "string",
                                    role: "annotation" },
                                  2]);

                 var options = {
                   title: "Tanzania Regions Reports",
                   width: 900,
                   height: 300,
                   bar: {groupWidth: "90%"},
                   legend: { position: "none" },
                 };
                 var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_region"));
                 chart.draw(view, options);
             }


</script>

