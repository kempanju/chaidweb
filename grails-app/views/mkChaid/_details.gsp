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

             <tr>
                                                               <td>
                                                                   <span class="text-semibold"><g:message code="description" default="Type of meeting/congression"/></span>
                                                               </td>
                                                               <td style="word-break:break-word">${fieldValue(bean: mkChaid, field: "meeting_type.name")}</td>
                                                           </tr>

       <tr>
                                    <td>
                                        <span class="text-semibold"><g:message code="type" default="Household Name"/></span>
                                    </td>
                                    <td>

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
                                        <span class="text-semibold"><g:message code="type" default="Respondent"/></span>
                                    </td>
                                    <td>${fieldValue(bean: mkChaid, field: "respondent_name")}</td>
                                </tr>


                                <tr>
                                    <td>
                                        <span class="text-semibold"><g:message code="description" default="Arrival Time"/></span>
                                    </td>
                                    <td style="word-break:break-word">

                                      <span class="text-muted"><g:formatDate format="dd MMM, yyyy"
                                                                                                       date="${mkChaid.arrival_time}"/></span>

                                                            </td>

                                    </td>
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
                                                        <span class="text-semibold"><g:message code="type" default="Registration No"/></span>
                                                    </td>
                                                    <td>${fieldValue(bean: mkChaid, field: "reg_no")}</td>
                                                </tr>


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


        <g:if test="${chaid.AvailableMemberHouse.countByChaid(mkChaid)>0}">


                <tr>
                                                   <td colspan="2">
                                                      <h5>Available household at time of visit</h5>
                                                   </td></tr>
       <g:each in="${chaid.AvailableMemberHouse.findAllByChaid(mkChaid)}" status="i" var="activityListInstance">
       <tr>

        <td colspan="2">
        ${fieldValue(bean: activityListInstance, field: "type_id.name")} ( Member No: ${fieldValue(bean: activityListInstance, field: "member_no")})
                                           </td>

       </tr>
       </g:each>
                    </tr>
               </g:if>

      <g:render template="pregnant" bean="mkChaid"/>



</table>
</div>