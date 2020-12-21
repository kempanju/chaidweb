<div class="panel-body">

<h4 class="modal-title">Member Details - ${categoryInstance?.categoryType?.name}</h4>


    <table class="table text-wrap customers" >

           <tr>
                                         <td>
                                             <span class="text-semibold"><g:message code="type" default="Category Name"/></span>
                                         </td>
                                         <td>${fieldValue(bean: categoryInstance, field: "categoryType.name")}</td>
                                     </tr>

        <tr>
                                                <td>
                                                    <span class="text-semibold"><g:message code="type" default="Member No"/></span>
                                                </td>
                                                <td>${fieldValue(bean: categoryInstance, field: "member_no")}</td>
                                            </tr>
                                   <tr>
                                         <td>
                                             <span class="text-semibold"><g:message code="description" default="Taken them to Clinic"/></span>
                                         </td>
                                         <td style="word-break:break-word"> ${ categoryInstance?.taken_baby_to_clinic?"Yes": "No"}</td>



                                     </tr>

       <tr>
                                       <td>
                                           <span class="text-semibold"><g:message code="description" default="Provided with Immunization"/></span>
                                       </td>
                                       <td style="word-break:break-word"> ${ categoryInstance?.baby_provided_immunization?"Yes": "No"}</td>



                                   </tr>



      <tr>
                                                           <td colspan="2">
                                                              <h5>Immunization Provided</h5>
                                                           </td></tr>
               <g:each in="${chaid.ImmunizationAvailableChildren.findAllByCategoryAvailableChildren(categoryInstance)}" status="i" var="activityListInstance">
               <tr>
               <td>${i+1}</td>
                <td>
                ${fieldValue(bean: activityListInstance, field: "immunization_type.name")}
                                                   </td>

               </tr>
               </g:each>
                            </tr>


   <tr>
                                                           <td colspan="2">
                                                              <h5>Danger Signs</h5>
                                                           </td></tr>
               <g:each in="${chaid.DangerSignAvailableChildren.findAllByCategoryAvailableChildren(categoryInstance)}" status="i" var="activityListInstance">
               <tr>
               <td>${i+1}</td>
                <td>
                ${fieldValue(bean: activityListInstance, field: "danger_type.name")}
                                                   </td>

               </tr>
               </g:each>
                            </tr>




       </table>

  </div>