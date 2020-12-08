  <g:if test="${chaid.PreginantDetails.countByChaid(mkChaid)>0}">
        <%

        def pregnantInstance=chaid.PreginantDetails.findByChaid(mkChaid)

        %>
     <tr>
                                                   <td colspan="2">
                                                      <h5>Pregnant Women</h5>
                                                   </td></tr>

   <tr>
       <td>
           <span class="text-semibold"><g:message code="description" default="Menstrual Period"/></span>
       </td>
       <td >
        <span class="text-muted"><g:formatDate format="dd MMM, yyyy HH:mm"
                          date="${pregnantInstance.last_menstual}"/></span>


       </td>
   </tr>

<g:if test="${chaid.DangerSignPregnant.countByChaid(mkChaid)>0}">


                <tr>
                                                   <td colspan="2">
                                                      <h5>Danger Signs</h5>
                                                   </td></tr>
       <g:each in="${chaid.DangerSignPregnant.findAllByChaid(mkChaid)}" status="i" var="activityListInstance">
       <tr>
       <td>${i+1}</td>
        <td>
        ${fieldValue(bean: activityListInstance, field: "sign_type.name")}
                                           </td>

       </tr>
       </g:each>
                    </tr>
               </g:if>

 <tr>
       <td>
           <span class="text-semibold"><g:message code="description" default="Attended Any Clinic?"/></span>
       </td>
       <td >
${ pregnantInstance.attended_clinic?"Yes": "No"}


       </td>
   </tr>
<tr>
<td> <span class="text-semibold">Visit Type</span></td>
 <td>
 ${fieldValue(bean: pregnantInstance, field: "visit_type.name")}
                                    </td>

</tr>


<tr>
<td> <span class="text-semibold">Number of Child have?</span></td>
 <td>
 ${fieldValue(bean: pregnantInstance, field: "child_group_no.name")}
                                    </td>

</tr>


<tr>
       <td>
           <span class="text-semibold"><g:message code="description" default="Is any child aged under 1 year?"/></span>
       </td>
       <td >
${ pregnantInstance.child_under_one?"Yes": "No"}


       </td>
   </tr>

   <tr>
          <td>
              <span class="text-semibold"><g:message code="description" default="Have you ever used any family planning method?"/></span>
          </td>
          <td >
   ${ pregnantInstance.ever_used_any_family_planning?"Yes": "No"}


          </td>
      </tr>
 <tr>
          <td>
              <span class="text-semibold"><g:message code="description" default="Family Planning that is using"/></span>
          </td>
          <td >
   ${fieldValue(bean: pregnantInstance, field: "family_planning_type.name")}



          </td>
      </tr>


       <tr>
                <td>
                    <span class="text-semibold"><g:message code="description" default="Prefer family planning after  Delivery?"/></span>
                </td>
                <td >
         ${ pregnantInstance.prefer_family_planning?"Yes": "No"}


                </td>
            </tr>
       <tr>
</g:if>