<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'subStreet.label', default: 'SubStreet')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
            <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load("current", {packages: ["corechart"]});
        google.charts.setOnLoadCallback(drawChartEducationType);

function drawChartEducationType() {
            var data = google.visualization.arrayToDataTable([
                ['Task', ' Health Education'],
                <g:each  in="${admin.DictionaryItem.findAllByDictionary_id(admin.Dictionary.findByCode("CHAD33F"))}" var="chaidDataInstance">
                <%
                def healthcount=0;
                 if(params.start_date&&params.end_date&&params.facility){
                healthcount= chaid.HealthEducation.executeQuery("from HealthEducation where type=:visit_type and chaid.deleted=false and chaid.facility.id=:facilityid and  created_at>='" + params.start_date + "' and created_at<='" + params.end_date + "' ",[visit_type:chaidDataInstance,facilityid:Integer.parseInt(params.facility)]).size()

                }else if(params.start_date&&params.end_date){

                                healthcount= chaid.HealthEducation.executeQuery("from HealthEducation where type=:visit_type and chaid.deleted=false and   created_at>='" + params.start_date + "' and created_at<='" + params.end_date + "' ",[visit_type:chaidDataInstance]).size()

                }
            else if(params.facility){
                healthcount= chaid.HealthEducation.executeQuery("from HealthEducation where type=:visit_type and chaid.deleted=false and chaid.facility.id=:facilityid",[visit_type:chaidDataInstance,facilityid:Integer.parseInt(params.facility)]).size()

                }
                else{
                healthcount= chaid.HealthEducation.executeQuery("from HealthEducation where type=:visit_type and chaid.deleted=false",[visit_type:chaidDataInstance]).size()
               }
                %>
                ["${chaidDataInstance.name}", ${healthcount}],
                </g:each>

            ]);

            var options = {
                title: 'Health Education',
                is3D: true,
            };

            var chart = new google.visualization.PieChart(document.getElementById('piechart_3d_comp'));
            chart.draw(data, options);
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
               class="btn btn-primary">${message(code: 'application.list', default: 'Reports By Health Education')} </a>
        </div>
 </div>

<div class="col-lg-12" style="max-height:500px;overflow:auto" id="village-report">

<div class="col-lg-8 text-center" style="padding: 20px">
            <div id="piechart_3d_comp" style="width: 100%;min-height: 400px;margin-top: 1px"></div>

        </div>
        <div class="col-lg-4">

         <table class="table text-wrap customers" >


                 <tr>
                                                    <td colspan="3">
                                                       <h6>Health Education</h6>
                                                    </td>
        <g:each in="${admin.DictionaryItem.findAllByDictionary_id(admin.Dictionary.findByCode("CHAD33F"))}" status="i" var="itemListInstance">
        <tr>
        <td>${i+1}</td>
         <td>
         ${fieldValue(bean: itemListInstance, field: "name")}
                                            </td><td>


                                   <%
                                                  def healthcount=0;
                                                   if(params.start_date&&params.end_date&&params.facility){
                                                  healthcount= chaid.HealthEducation.executeQuery("from HealthEducation where type=:visit_type and chaid.deleted=false and chaid.facility.id=:facilityid and  created_at>='" + params.start_date + "' and created_at<='" + params.end_date + "' ",[visit_type:itemListInstance,facilityid:Integer.parseInt(params.facility)]).size()

                                                  }else if(params.start_date&&params.end_date){

                                                                  healthcount= chaid.HealthEducation.executeQuery("from HealthEducation where type=:visit_type and chaid.deleted=false and   created_at>='" + params.start_date + "' and created_at<='" + params.end_date + "' ",[visit_type:itemListInstance]).size()

                                                  }
                                              else if(params.facility){
                                                  healthcount= chaid.HealthEducation.executeQuery("from HealthEducation where type=:visit_type and chaid.deleted=false and chaid.facility.id=:facilityid",[visit_type:itemListInstance,facilityid:Integer.parseInt(params.facility)]).size()

                                                  }
                                                  else{
                                                  healthcount= chaid.HealthEducation.executeQuery("from HealthEducation where type=:visit_type and chaid.deleted=false",[visit_type:itemListInstance]).size()
                                                 }
                                                  %>

                                            <span class="badge badge-success">
                                           ${healthcount}
                                            </span></td>

        </tr>
        </g:each>
                     </tr>

</table>

        </div>


</div>

      </div>

        <script type="text/javascript">
             $(".form_datetime").datetimepicker({format: 'yyyy-mm-dd hh:mm'});
         </script>
      </body>
  </html>