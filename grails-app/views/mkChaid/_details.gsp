  <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>


             <div style="width: 50%;float: left">

                    <table class="table text-wrap customers" >

           <tr>
                                         <td>
                                             <span class="text-semibold"><g:message code="type" default="District Name"/></span>
                                         </td>
                                         <td>${fieldValue(bean: mkChaid, field: "distric.name")}</td>
                                     </tr>
                                     <tr>
                                         <td>
                                             <span class="text-semibold"><g:message code="description" default="Village"/></span>
                                         </td>
                                         <td style="word-break:break-word">${fieldValue(bean: mkChaid, field: "street.name")}</td>
                                     </tr>

                <tr>
                                                        <td>
                                                            <span class="text-semibold"><g:message code="description" default="Type of Visit/Daily Activity"/></span>
                                                        </td>
                                                        <td style="word-break:break-word">${fieldValue(bean: mkChaid, field: "visit_type.name")}</td>
                                                    </tr>

        <g:if test="${mkChaid.visit_type.code=='CHAD4B'}">

             <tr>
                                                               <td>
                                                                   <span class="text-semibold"><g:message code="description" default="Type of meeting/congression"/></span>
                                                               </td>
                                                               <td style="word-break:break-word">${fieldValue(bean: mkChaid, field: "meeting_type.name")}</td>
                                                           </tr>

                                                               <td>
                                                                   <span class="text-semibold"><g:message code="description" default="Idadi ya wajumbe katika mkutano"/></span>
                                                               </td>
                                                               <td style="word-break:break-word">KE:<span  class="badge  badge-primary"> ${fieldValue(bean: mkChaid, field: "members_female")} </span> , ME: <span  class="badge  badge-success">${fieldValue(bean: mkChaid, field: "members_male")}</span></td>
                                                           </tr>

           </g:if>
        <g:if test="${mkChaid.visit_type.code!='CHAD4B'}">

       <tr>
                                    <td>
                                        <span class="text-semibold text-capitalize"><g:message code="type" default="Household Name"/></span>
                                    </td>
                                    <td class="text-capitalize">

           <g:link class="list" controller="household" action="show" id="${mkChaid?.household?.id}">
                                    ${fieldValue(bean: mkChaid, field: "household.full_name")}</g:link></td>
                                </tr>

                 <tr>
                                                   <td>
                                                       <span class="text-semibold"><g:message code="type" default="Household Number"/></span>
                                                   </td>
                                                   <td>
                                                 <g:link class="list" controller="household" action="show" id="${mkChaid?.household?.id}">
                                                   ${fieldValue(bean: mkChaid, field: "household.number")}</g:link></td>
                                               </tr>
 <tr>
                                                   <td>
                                                       <span class="text-semibold"><g:message code="type" default="Household Male Number"/></span>
                                                   </td>
                                                   <td>
                                                 <g:link class="list" controller="household" action="show" id="${mkChaid?.household?.id}">
                                                   ${fieldValue(bean: mkChaid, field: "household.male_no")}</g:link></td>
                                               </tr>
 <tr>
                                                   <td>
                                                       <span class="text-semibold"><g:message code="type" default="Household Female Number"/></span>
                                                   </td>
                                                   <td>
                                                 <g:link class="list" controller="household" action="show" id="${mkChaid?.household?.id}">
                                                   ${fieldValue(bean: mkChaid, field: "household.female_no")}</g:link></td>
                                               </tr>
                       <tr>
                                                         <td>
                                                             <span class="text-semibold"><g:message code="description" default="Gender"/></span>
                                                         </td>
                                                         <td style="word-break:break-word">${fieldValue(bean: mkChaid, field: "respondent_gender")}</td>
                                                     </tr>
                          <tr>
                                                         <td>
                                                             <span class="text-semibold"><g:message code="description" default="Age"/></span>
                                                         </td>
                                                         <td style="word-break:break-word">${fieldValue(bean: mkChaid, field: "respondent_age")}</td>
                                                     </tr>

                   </g:if>
    <tr>
                                    <td>

                                        <span class="text-semibold"><g:message code="type" default="Facility Name"/></span>
                                    </td>
                                    <td class="text-capitalize">${fieldValue(bean: mkChaid, field: "facility.name")}</td>
                                </tr>

                                 <tr>
                                    <td>
                                        <span class="text-semibold"><g:message code="type" default="Respondent"/></span>
                                    </td>
                                    <td class="text-capitalize">${fieldValue(bean: mkChaid, field: "respondent_name")}</td>
                                </tr>


                                <tr>
                                    <td>
                                        <span class="text-semibold"><g:message code="description" default="Arrival Time"/></span>
                                    </td>
                                    <td style="word-break:break-word">

                                      <span class="text-muted"><g:formatDate format="dd MMM, yyyy HH:mm"
                                                                                                       date="${mkChaid.arrival_time}"/></span>

                                                            </td>

                                    </td>
                                </tr>


   <tr>
                                    <td>
                                        <span class="text-semibold"><g:message code="type" default="Marriage Status"/></span>
                                    </td>
                                    <td>${fieldValue(bean: mkChaid, field: "relationship_status.name")}</td>
                                </tr>

    <tr>
                                        <td>
                                            <span class="text-semibold"><g:message code="type" default="Interview Status"/></span>
                                        </td>
                                        <td>${fieldValue(bean: mkChaid, field: "interview_status.name")}</td>
                                    </tr>
 <tr>
                                        <td>
                                            <span class="text-semibold"><g:message code="type" default="Visit Objective"/></span>
                                        </td>
                                        <td>${fieldValue(bean: mkChaid, field: "objective_type.name")}</td>
                                    </tr>

         <tr>
                                                <td>
                                                    <span class="text-semibold"><g:message code="type" default="Code"/></span>
                                                </td>
                                                <td>${fieldValue(bean: mkChaid, field: "uniquecode")}</td>
                                            </tr>
            <tr>
                                                           <td>
                                                               <span class="text-semibold"><g:message code="type" default="Added By"/></span>
                                                           </td>
                                                           <td>
                                                         <g:link class="list" controller="mkpUser" action="show" id="${mkChaid?.created_by?.id}">

                                                           ${fieldValue(bean: mkChaid, field: "created_by.full_name")}

                                                           </g:link>

                                                           </td>
                                                       </tr>

       <tr>
                                                    <td>
                                                        <span class="text-semibold"><g:message code="type" default="Registration No"/></span>
                                                    </td>
                                                    <td>${fieldValue(bean: mkChaid, field: "reg_no")}</td>
                                                </tr>
      <g:if test="${mkChaid.sick_person}">

             <tr>
                                                               <td>
                                                                   <span class="text-semibold"><g:message code="description" default="Is there sick person in household?"/></span>
                                                               </td>
                                                               <td style="word-break:break-word"> ${ mkChaid.sick_person?"Yes": "No"}</td>



                                                           </tr>
           </g:if>


            <g:if test="${mkChaid.age_sick_person}">

                        <tr>
                                                                          <td>
                                                                              <span class="text-semibold"><g:message code="description" default="Age of sick person in household"/></span>
                                                                          </td>
                                                                          <td style="word-break:break-word">

${fieldValue(bean: mkChaid, field: "age_sick_person")}
                                                                          </td>



                                                                      </tr>
                      </g:if>
 <g:if test="${mkChaid.care_giver}">

             <tr>
                                                               <td>
                                                                   <span class="text-semibold"><g:message code="description" default="Are you Care giver for sick person?"/></span>
                                                               </td>
                                                               <td style="word-break:break-word"> ${ mkChaid.care_giver?"Yes": "No"}</td>



                                                           </tr>
           </g:if>

      <g:render template="postdelivery" bean="mkChaid"/>


                    </table>



            </div>

             <div style="width: 50%;float: left">

                              <table class="table text-wrap customers" >
        <g:if test="${chaid.EducationType.countByChaid(mkChaid)>0}">


         <tr>
                                            <td colspan="2">
                                               <h5>Education Type</h5>
                                            </td>
<g:each in="${chaid.EducationType.findAllByChaid(mkChaid)}" status="i" var="mkchaidListInstance">
<tr>
<td>${i+1}</td>
 <td>
 ${fieldValue(bean: mkchaidListInstance, field: "type.name")}
                                    </td>

</tr>
</g:each>
             </tr>
        </g:if>


  <g:if test="${chaid.Survey.countByChaid(mkChaid)>0}">


         <tr>
                                            <td colspan="2">
                                               <h5>Huduma Nyinginezo</h5>
                                            </td>
<g:each in="${chaid.Survey.findAllByChaid(mkChaid)}" status="i" var="surveyListInstance">
<tr>
<td>${i+1}</td>
 <td>
 ${fieldValue(bean: surveyListInstance, field: "type.name")}
 <span  class="badge  badge-primary">${fieldValue(bean: surveyListInstance, field: "survey_no")}</span>
                                    </td>

</tr>
</g:each>
             </tr>
        </g:if>

 <g:if test="${chaid.ActivityType.countByChaid(mkChaid)>0}">


         <tr>
                                            <td colspan="2">
                                               <h5>Type of Activity Done at OutReach</h5>
                                            </td>
<g:each in="${chaid.ActivityType.findAllByChaid(mkChaid)}" status="i" var="activityListInstance">
<tr>
<td>${i+1}</td>
 <td>
 ${fieldValue(bean: activityListInstance, field: "type.name")}
                                    </td>

</tr>
</g:each>
             </tr>
        </g:if>


   <g:if test="${chaid.Adolescent.countByChaid(mkChaid)>0}">


            <tr>
                                               <td colspan="2">
                                                  <h5>Adolescent</h5>
                                               </td>
   <g:each in="${chaid.Adolescent.findAllByChaid(mkChaid)}" status="i" var="activityListInstance">
   <tr>
   <td>${i+1}</td>
    <td>
    ${fieldValue(bean: activityListInstance, field: "name")} , ${fieldValue(bean: activityListInstance, field: "gender")}, ${fieldValue(bean: activityListInstance, field: "age")}
                                       </td>

   </tr>
   </g:each>
                </tr>
           </g:if>


        <g:if test="${chaid.AvailableMemberHouse.countByChaid(mkChaid)>0}">


                <tr>
                                                   <td colspan="2">
                                                      <h5>Available household at time of visit</h5>
                                                   </td></tr>
       <g:each in="${chaid.AvailableMemberHouse.findAllByChaid(mkChaid)}" status="i" var="activityListInstance">
       <tr>

        <td colspan="2">
        ${fieldValue(bean: activityListInstance, field: "type_id.name")} ( Member No: ${fieldValue(bean: activityListInstance, field: "member_no")})

          <g:link class="create" data-toggle="modal" data-target="#myModal" action="memberDetailsShow"
                                        id="${activityListInstance.id}">
                                    <i class="icon-menu-open"></i><span>Read More</span>

                                </g:link>
                                           </td>

       </tr>
       </g:each>
                    </tr>
               </g:if>

      <g:render template="pregnant" bean="mkChaid"/>
       <sec:ifAnyGranted roles="ROLE_PUBLISHER,ROLE_ADMIN">

                                                 <tr><td>Actions</td><td>

                                                                    <g:link action="deleteChad" id="${mkChaid.id}"
                                                                            class="btn btn-link btn-float has-text"><i
                                                                            class=" icon-database-remove text-warning"></i><span>Delete</span></g:link>

                                                                </td></tr>
                             </sec:ifAnyGranted>


</table>
</div>


   <div id="myModal" class="modal fade" role="dialog">
                <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Member Details</h4>
                        </div>

                        <div class="modal-body">
                            <p>Loading....</p>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>

                </div>
            </div>