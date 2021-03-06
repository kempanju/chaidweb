<table class="table">
<thead>
<tr class="active">
<th>No</th>
<th>Village Name </th>
<th>Visits</th>
<th>Households</th>
<th>Population</th>
<th>Available Women</th>
<th>Available Men</th>
<th>Adolescents Girls (10-19) </th>
<th style="width25%; ">Adolescents Boys (10-19)</th>
<th>Neonates</th>
<th>Infants</th>
<th>Pregnant Women</th>
<th>Breastfeeding Women</th>
</tr>
</thead>
<tbody>
<%
def countNo=1;
def totalHouseHold=0;
def totalMember=0;
def totalMemberMale=0;
def totalMemberWomen=0;
def totalWomenAgeBetweenNo=0;
def totalMaleAgeBetweenNo=0;
def totalNeonates=0;
def totalInfants=0;
def totalPregnantWomen=0;
def totalBreastFeedingWomen=0;
def totalVisit=0;

%>
<g:each in="${admin.District.findAllByRegion_idAndD_deleted(regionInstance,false,[order:'asc',sort:'name'])}" status="i" var="districtListInstance">
    <%
        def houseHoldNo=0;
        def chadNo=0;
         if(end_date&&from_date){
         houseHoldNo=chaid.Household.executeQuery("from Household where district_id=:district and deleted=false and created_at between '"+from_date+"' and '"+end_date+"'",[district:districtListInstance]).size()
         chadNo=chaid.MkChaid.executeQuery("from MkChaid where distric=:district and deleted=false and arrival_time between '"+from_date+"' and '"+end_date+"'",[district:districtListInstance]).size()

         }else{
        houseHoldNo=chaid.Household.countByDistrict_idAndDeleted(districtListInstance,false)
        chadNo=chaid.MkChaid.countByDistricAndDeleted(districtListInstance,false)
        }
    %>

    <g:if test="${houseHoldNo>0||chadNo>0}">

    <tr class="${(countNo % 2) == 0 ? 'even' : 'odd'} ">
    <td>${countNo}</td>
    <td><span class="text-bold">${districtListInstance.name}</span></td>
    <td class="info"><span>${chadNo}</span></td>

        <%
        totalHouseHold=totalHouseHold+houseHoldNo;
        totalVisit=totalVisit+chadNo;
        %>
        <td>${houseHoldNo}</td>
         <%
         def houseHoldMember=0

         if(end_date&&from_date){
                              houseHoldMember=chaid.MkChaid.executeQuery("select sum(household.total_members),sum(household.male_no),sum(household.female_no) from MkChaid  where distric=:district and  deleted=false and created_at between '"+from_date+"' and '"+end_date+"'",[district:districtListInstance] )
                            }else{
                            houseHoldMember=chaid.MkChaid.executeQuery("select sum(household.total_members),sum(household.male_no),sum(household.female_no) from MkChaid  where distric=:district and deleted=false",[district:districtListInstance] )

                            }


         %>
    <td >${houseHoldMember[0][0]}</td>
 <td>${houseHoldMember[0][1]}</td>
 <td>${houseHoldMember[0][2]}</td>
 <td>
 <%
       def womenAgeBetweenNo=0;
  if(end_date&&from_date){
    womenAgeBetweenNo=chaid.AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:district and arrival_time between '"+from_date+"' and '"+end_date+"'",[categoryType:admin.DictionaryItem.findByCode("CHAD17G"),district:districtListInstance])

    }else {
        womenAgeBetweenNo=chaid.AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:district ",[categoryType:admin.DictionaryItem.findByCode("CHAD17G"),district:districtListInstance])

    }

 %>
 ${womenAgeBetweenNo[0]}
 </td>


  <td>
  <%
     def maleAgeBetweenNo=0;
    if(end_date&&from_date){
      maleAgeBetweenNo=chaid.AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:district and arrival_time between '"+from_date+"' and '"+end_date+"' ",[categoryType:admin.DictionaryItem.findByCode("CHAD17H"),district:districtListInstance])
    }else{
       maleAgeBetweenNo=chaid.AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:district ",[categoryType:admin.DictionaryItem.findByCode("CHAD17H"),district:districtListInstance])
    }
  %>
  ${maleAgeBetweenNo[0]}
  </td>

  <td>
   <%
        def neonates=0;
       if(end_date&&from_date){
        neonates=chaid.CategoryAvailableChildren.executeQuery("select sum(member_no) from CategoryAvailableChildren where categoryType=:categoryType  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.distric=:district and created_at between '"+from_date+"' and '"+end_date+"' ",[categoryType:admin.DictionaryItem.findByCode("CHAD17D"),district:districtListInstance])

       }else{
         neonates=chaid.CategoryAvailableChildren.executeQuery("select sum(member_no) from CategoryAvailableChildren where categoryType=:categoryType  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.distric=:district ",[categoryType:admin.DictionaryItem.findByCode("CHAD17D"),district:districtListInstance])

       }
    %>

    ${neonates[0]}
  </td>

  <td>
   <%
          def infants=0
        if(end_date&&from_date){
           infants=chaid.CategoryAvailableChildren.executeQuery("select sum(member_no)  from CategoryAvailableChildren where categoryType=:categoryType  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.distric=:district and created_at between '"+from_date+"' and '"+end_date+"'",[categoryType:admin.DictionaryItem.findByCode("CHAD17E"),district:districtListInstance])
        }else{
            infants=chaid.CategoryAvailableChildren.executeQuery("select sum(member_no)  from CategoryAvailableChildren where categoryType=:categoryType  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.distric=:district ",[categoryType:admin.DictionaryItem.findByCode("CHAD17E"),district:districtListInstance])

        }
       %>

      ${infants[0]}
    </td>
    <td>

      <%
       def pregnantWomen=0
              if(end_date&&from_date){
             pregnantWomen=chaid.AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:district and arrival_time between '"+from_date+"' and '"+end_date+"'",[categoryType:admin.DictionaryItem.findByCode("CHAD17A"),district:districtListInstance])

                }else{
                  pregnantWomen=chaid.AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:district ",[categoryType:admin.DictionaryItem.findByCode("CHAD17A"),district:districtListInstance])

                }

          %>
          ${pregnantWomen[0]}

    </td>
    <td>
  <%
                def breastFeedingWomen=0;
                 if(end_date&&from_date){
             breastFeedingWomen=chaid.AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:district and arrival_time between '"+from_date+"' and '"+end_date+"'",[categoryType:admin.DictionaryItem.findByCode("CHAD17B"),district:districtListInstance])

                 }else{
                  breastFeedingWomen=chaid.AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:district ",[categoryType:admin.DictionaryItem.findByCode("CHAD17B"),district:districtListInstance])
                }
          %>
          ${breastFeedingWomen[0]}

    </td>

    </tr>

    <g:each  in="${admin.DictionaryItem.findAllByDictionary_id(admin.Dictionary.findByCode("CHAD4"))}" var="visitDataInstance">

      <tr>
      <td></td>
      <td>${visitDataInstance.name}</td>

         <%
                def chadNoH=0;
                 if(end_date&&from_date){
                 chadNoH=chaid.MkChaid.executeQuery("from MkChaid where distric=:district and deleted=false and visit_type=:visit_type and arrival_time between '"+from_date+"' and '"+end_date+"'",[district:districtListInstance,visit_type:visitDataInstance]).size()

                 }else{
                chadNoH=chaid.MkChaid.countByDistricAndDeletedAndVisit_type(districtListInstance,false,visitDataInstance)
                }
            %>
        <td>${chadNoH}</td>
        <td></td>

         <%
                def houseHoldMemberH=0;
                    if(end_date&&from_date){
                      houseHoldMemberH=chaid.Household.executeQuery("select sum(household.total_members),sum(household.male_no),sum(household.female_no) from MkChaid  where distric=:district and visit_type=:visit_type and deleted=false and created_at between '"+from_date+"' and '"+end_date+"'",[district:districtListInstance,visit_type:visitDataInstance] )
                    }else{
                    houseHoldMemberH=chaid.Household.executeQuery("select sum(household.total_members),sum(household.male_no),sum(household.female_no) from MkChaid  where distric=:district and visit_type=:visit_type and deleted=false",[district:districtListInstance,visit_type:visitDataInstance] )

                    }
                %>
           <td >${houseHoldMemberH[0][0]}</td>
        <td>${houseHoldMemberH[0][1]}</td>
        <td>${houseHoldMemberH[0][2]}</td>

      </tr>
    </g:each>
    <%
    if(houseHoldMember[0][0]){
    totalMember=totalMember+houseHoldMember[0][0];
    }

    if(houseHoldMember[0][2]){
    totalMemberMale=totalMemberMale+houseHoldMember[0][2];
    }

    if(houseHoldMember[0][1]){
    totalMemberWomen=totalMemberWomen+houseHoldMember[0][1];
    }
    if(womenAgeBetweenNo[0]){
    totalWomenAgeBetweenNo=totalWomenAgeBetweenNo+womenAgeBetweenNo[0];
    }
    if(maleAgeBetweenNo[0]){
    totalMaleAgeBetweenNo=totalMaleAgeBetweenNo+maleAgeBetweenNo[0];
    }
    if(neonates[0]){
    totalNeonates=totalNeonates+neonates[0];
    }
    if(infants[0]){
        totalInfants=totalInfants+infants[0]
    }
    if(pregnantWomen[0]){
    totalPregnantWomen=totalPregnantWomen+pregnantWomen[0];
    }
    if(breastFeedingWomen[0]){
    totalBreastFeedingWomen=totalBreastFeedingWomen+breastFeedingWomen[0];
    }
    countNo++;
    %>
</g:if>
</g:each>
</tbody>
  <tfoot>
  <tr class="success">
  <td></td>
  <td class="semi-bold">Total</td>
  <td>${formatAmountString(name: (int)totalVisit)}</td>
  <td>${formatAmountString(name: (int) totalHouseHold)}</td>
 <td>${formatAmountString(name: (int)totalMember)}</td>
  <td>${formatAmountString(name: (int)totalMemberWomen)}</td>
  <td>${formatAmountString(name: (int)totalMemberMale)}</td>
  <td>${formatAmountString(name: (int)totalWomenAgeBetweenNo)}</td>
  <td>${formatAmountString(name: (int)totalMaleAgeBetweenNo)}</td>
  <td>${formatAmountString(name: (int)totalNeonates)}</td>
  <td>${formatAmountString(name: (int)totalInfants)}</td>
    <td>${formatAmountString(name: (int)totalPregnantWomen)}</td>
<td>${formatAmountString(name: (int)totalBreastFeedingWomen)}</td>
  </tr>
</tfoot>
</table>