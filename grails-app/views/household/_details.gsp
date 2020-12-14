
                                <table class="table text-nowrap customers">
                                    <tr>
                                        <td colspan="2"><h5>
                                            <span class="text-bold"><g:message code="dictionary.details" default="HOUSEHOLD DETAILS"/></span>
                                        </h5></td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <span class="text-semibold"><g:message code="code" default="Number"/></span>
                                        </td>
                                        <td><span
                                                class="text-bold">${fieldValue(bean: household, field: "number")}</span>
                                        </td>
                                    </tr>

 <tr>
                                        <td>
                                            <span class="text-semibold"><g:message code="code" default="Name"/></span>
                                        </td>
                                        <td><span
                                                class="text-bold">${fieldValue(bean: household, field: "name")}</span>
                                        </td>
                                    </tr>
    <tr>
                                            <td>
                                                <span class="text-semibold"><g:message code="code" default="District"/></span>
                                            </td>
                                            <td><span
                                                    class="text-bold">${fieldValue(bean: household, field: "district_id.name")}</span>
                                            </td>
                                        </tr>
                  <tr>
                                                          <td>
                                                              <span class="text-semibold"><g:message code="code" default="Village"/></span>
                                                          </td>
                                                          <td><span
                                                                  class="text-bold">${fieldValue(bean: household, field: "village_id.name")}</span>
                                                          </td>
                                                      </tr>
                  <tr>
                                                          <td>
                                                              <span class="text-semibold"><g:message code="code" default="Street"/></span>
                                                          </td>
                                                          <td><span
                                                                  class="text-bold">${fieldValue(bean: household, field: "street.name")}</span>
                                                          </td>
                                                      </tr>
         <tr>
                                                     <td>
                                                         <span class="text-semibold"><g:message code="code" default="Total Member"/></span>
                                                     </td>
                                                     <td><span
                                                             class="text-bold">${fieldValue(bean: household, field: "total_members")}</span>
                                                     </td>
                                                 </tr>
     <tr>
                                             <td>
                                                 <span class="text-semibold"><g:message code="code" default="Male No"/></span>
                                             </td>
                                             <td><span
                                                     class="text-bold">${fieldValue(bean: household, field: "male_no")}</span>
                                             </td>
                                         </tr>

            <tr>
                                                       <td>
                                                           <span class="text-semibold"><g:message code="code" default="Female No"/></span>
                                                       </td>
                                                       <td><span
                                                               class="text-bold">${fieldValue(bean: household, field: "female_no")}</span>
                                                       </td>
                                                   </tr>


 <g:if test="${chaid.HouseholdDetails.countByHousehold(household)>0}">


         <tr>
                                            <td colspan="2">
                                               <h5>Household Members</h5>
                                            </td>
<g:each in="${chaid.HouseholdDetails.findAllByHousehold(household)}" status="i" var="houseListInstance">
<tr>
<td>${i+1}</td>
 <td>
 ${fieldValue(bean: houseListInstance, field: "detailsType.name")} (Members No: ${fieldValue(bean: houseListInstance, field: "member_no")})
                                    </td>

</tr>
</g:each>
             </tr>
        </g:if>



                               </table>