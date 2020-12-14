  <g:if test="${chaid.PreginantDetails.countByChaid(mkChaid)>0}">
        <%

        def postDeliveryInstance=chaid.PostDelivery.findByChaid(mkChaid)

        %>
     <tr>
                                                   <td colspan="2">
                                                      <h5>Post Delivery up to 42 </h5>
                                                   </td></tr>

   <tr>
       <td>
           <span class="text-semibold"><g:message code="description" default="Delivery Date"/></span>
       </td>
       <td >
        <span class="text-muted"><g:formatDate format="dd MMM, yyyy HH:mm"
                          date="${postDeliveryInstance.delivery_date}"/> ${postDeliveryInstance.child_age}</span>


       </td>
   </tr>
<tr>
<td> <span class="text-semibold">Delivery Outcome of Baby</span></td>
 <td>
 ${fieldValue(bean: postDeliveryInstance, field: "outcome_type.name")}
                                    </td>

</tr>

<tr>
<td> <span class="text-semibold">Condition of baby during Delivery</span></td>
 <td>
 ${fieldValue(bean: postDeliveryInstance, field: "baby_condition.name")}
                                    </td>

</tr>

<tr>
<td> <span class="text-semibold">Type of Delivery</span></td>
 <td>
 ${fieldValue(bean: postDeliveryInstance, field: "delivery_type.name")}
                                    </td>

</tr>

<tr>
<td> <span class="text-semibold">Place of Delivery</span></td>
 <td>
 ${fieldValue(bean: postDeliveryInstance, field: "delivery_place.name")}
                                    </td>

</tr>


<tr>
<td> <span class="text-semibold">Health facility/Hospital</span></td>
 <td>
 ${fieldValue(bean: postDeliveryInstance, field: "facility_card_name")}
                                    </td>

</tr>


<g:if test="${chaid.DangerSignMotherDelivery.countByChaid(mkChaid)>0}">


                <tr>
                                                   <td colspan="2">
                                                      <h5>Mother Danger Signs</h5>
                                                   </td></tr>
       <g:each in="${chaid.DangerSignMotherDelivery.findAllByChaid(mkChaid)}" status="i" var="activityListInstance">
       <tr>
       <td>${i+1}</td>
        <td>
        ${fieldValue(bean: activityListInstance, field: "sign_type.name")}
                                           </td>

       </tr>
       </g:each>
                    </tr>
               </g:if>


 <g:if test="${chaid.DangerSignChildDelivery.countByChaid(mkChaid)>0}">


                 <tr>
                                                    <td colspan="2">
                                                       <h5>Child Danger Signs</h5>
                                                    </td></tr>
        <g:each in="${chaid.DangerSignChildDelivery.findAllByChaid(mkChaid)}" status="i" var="activityListInstance">
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
           <span class="text-semibold"><g:message code="description" default="Since Delivery Did you take child to Any Clinic?"/></span>
       </td>
       <td >
${ postDeliveryInstance.postnatal_clinic?"Yes": "No"}


       </td>
   </tr>
<tr>
<td> <span class="text-semibold">Used Any Family Planning?</span></td>
 <td>
 ${fieldValue(bean: postDeliveryInstance, field: "family_planning.name")}
                                    </td>

</tr>





<tr>
       <td>
           <span class="text-semibold"><g:message code="description" default="Baby provided with Immunization?"/></span>
       </td>
       <td >
${ postDeliveryInstance.provided_immunization?"Yes": "No"}


       </td>
   </tr>



   <g:if test="${postDeliveryInstance.provided_immunization}">


                   <tr>
                                                      <td colspan="2">
                                                         <h5>Mother Danger Signs</h5>
                                                      </td></tr>
          <g:each in="${chaid.ChildImmunization.findAllByChaid(mkChaid)}" status="i" var="activityListInstance">
          <tr>
          <td>${i+1}</td>
           <td>
           ${fieldValue(bean: activityListInstance, field: "immunization_type.name")}
                                              </td>

          </tr>
          </g:each>
                       </tr>
                  </g:if>





       <tr>
                <td>
                    <span class="text-semibold"><g:message code="description" default="Under five children?"/></span>
                </td>
                <td >
         ${ postDeliveryInstance.under_five_no}


                </td>
            </tr>
       <tr>
</g:if>