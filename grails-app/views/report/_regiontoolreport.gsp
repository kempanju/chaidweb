<%
    def memberCategoryList=admin.DictionaryItem.findAllByDictionary_idAndDisplayReport(admin.Dictionary.findByCode("CHAD17"),true,[sort:'displayOrder',order:'asc']);
%>

<div style=" overflow-x: auto;">
   <table class="table  table-bordered nowrap" >

     <tr style="white-space:nowrap;"><th></th>

   <g:each in="${memberCategoryList}" var="categoryListInstance">
                   <th class="success">${categoryListInstance.abbreviation}</th>

           </g:each></tr>
<tr>
            <td colspan="16" class="text-bold text-center"> PROVISION OF HEALTH EDUCATION AND FOLLOW UP AT HOUSEHOLD LEVEL</td>
         </tr>
   <tr>
   <%
           def houseHoldNo=0;
            if(end_date&&from_date){
            houseHoldNo=chaid.Household.executeQuery("from Household where created_at between '"+from_date+"' and '"+end_date+"' and district_id.region_id=:regionInstance",[regionInstance:regionInstance]).size()

            }else{
           houseHoldNo=chaid.Household.executeQuery("from Household where deleted=false and district_id.region_id=:regionInstance ",[regionInstance:regionInstance]).size()

           }
       %>
                      <td  class="info">Total household </td><td>${formatAmountString(name: (int)houseHoldNo)}</td>
    </tr>
<tr>
                      <td  class="info">Total number of Girls and Boys in the adoloscent group ages (10-24) reached  </td>
              <g:each in="${memberCategoryList}" var="categorysListInstance">
              <%
                     def groupAgeBetweenNo=0;
                if(end_date&&from_date){
                  groupAgeBetweenNo=chaid.AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and arrival_time between '"+from_date+"' and '"+end_date+"' and chaid.distric.region_id=:regionInstance",[categoryType:categorysListInstance,regionInstance:regionInstance])[0]

                  }else {
                      groupAgeBetweenNo=chaid.AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric.region_id=:regionInstance",[categoryType:categorysListInstance,regionInstance:regionInstance])[0]

                  }
                  if(!groupAgeBetweenNo){
                  groupAgeBetweenNo=0
                  }

               %>
              <td>${formatAmountString(name: (int)groupAgeBetweenNo)}</td>
             </g:each>

    </tr>

    <tr>
            <td colspan="16" class="text-bold text-center"> HEALTH EDUCATION:TYPE OF HEALTH EDUCATION PROVIDED</td>
         </tr>

     <g:each in="${admin.DictionaryItem.findAllByDictionary_id(admin.Dictionary.findByCode("CHAD33F"))}" status="i" var="educationListInstance">

                    <tr>
                    <td  class="info">${educationListInstance.name}</td>

                    <g:each in="${memberCategoryList}" var="categorysListInstance">
                    <%
                def noHoldMember=0
                  if(end_date&&from_date){
                   noHoldMember=materialize.view.ViewHealthEducation.executeQuery("select sum(h.member_no) from ViewHealthEducation h where category=:category and education_type=:education_type and  arrival_time between '"+from_date+"' and '"+end_date+"' and  chaid.distric.region_id=:regionInstance",[category:categorysListInstance,education_type:educationListInstance,regionInstance:regionInstance])[0]

                  }else{
                      noHoldMember=materialize.view.ViewHealthEducation.executeQuery("select sum(h.member_no) from ViewHealthEducation h where category=:category and education_type=:education_type and chaid.distric.region_id=:regionInstance ",[category:categorysListInstance,education_type:educationListInstance,regionInstance:regionInstance])[0]

                  }
                   if(!noHoldMember){
                                  noHoldMember=0
                                  }
                    %>
                    <td>${formatAmountString(name: (int)noHoldMember)}</td>
                    </g:each>

                    <td></td>
                    </tr>
                    </g:each>


        </tr>
        <g:each in="${admin.DictionaryItem.findAllByDictionary_id(admin.Dictionary.findByCode("CHAD6"))}" status="i" var="educationListInstance">

        <tr>
        <td  class="info">${educationListInstance.name}</td>

        <g:each in="${memberCategoryList}" var="categorysListInstance">
        <%
                    def noHoldMember=0
                if(end_date&&from_date){
                 noHoldMember=materialize.view.ViewHealthEducation.executeQuery("select sum(j.member_no) from ViewHealthEducation j where category=:category and education_type=:education_type and  arrival_time between '"+from_date+"' and '"+end_date+"' and chaid.distric.region_id=:regionInstance",[category:categorysListInstance,education_type:educationListInstance,regionInstance:regionInstance])[0]

                }else{
                    noHoldMember=materialize.view.ViewHealthEducation.executeQuery("select sum(j.member_no) from ViewHealthEducation j where category=:category and education_type=:education_type and chaid.distric.region_id=:regionInstance",[category:categorysListInstance,education_type:educationListInstance,regionInstance:regionInstance])[0]

                }

                if(!noHoldMember){
                noHoldMember=0
                }
        %>
        <td>${formatAmountString(name: (int)noHoldMember)}</td>
        </g:each>

        <td></td>
        </tr>
        </g:each>


<tr>
            <td colspan="16" class="text-bold text-center">  REFERRALS CONDUCTED FROM THE COMMUNITY :-TOTAL NUMBER OF GIRLS AND BOYS IN THE ADOLLENCENT GROUP Who (10-24 YRS) WERE REFERRED DUE TO:-</td>
         </tr>
        <g:each in="${admin.DictionaryItem.findAllByDictionary_id(admin.Dictionary.findByCode("CHAD54C"))}" status="i" var="referralsListInstance">
<tr>
        <td  class="info">${referralsListInstance.name}</td>
        <%
        def countReferrals=0
         if(end_date&&from_date){
            countReferrals=materialize.view.DangerSign.executeQuery(" select d.chaid  from DangerSign d left join MkChaid m on(m.id=d.chaid.id) where sign_type_id=:referralsListInstance and  m.arrival_time between '"+from_date+"' and '"+end_date+"' and m.distric.region_id=:regionInstance",[referralsListInstance:referralsListInstance.id,regionInstance:regionInstance]).size()
         }else{
            countReferrals=materialize.view.DangerSign.executeQuery("select d.chaid from DangerSign d left join MkChaid m on(m.id=d.chaid.id) where sign_type_id=:referralsListInstance and  m.distric.region_id=:regionInstance",[referralsListInstance:referralsListInstance.id,regionInstance:regionInstance]).size()
         }
        if(!countReferrals){
        countReferrals=0
        }
        %>
        <td>${formatAmountString(name: (int)countReferrals)}</td>
</tr>
</g:each>
<tr>
            <td colspan="16" class="text-bold text-center">  REFERRAL:- HEALTH FACILITY ADVISED TO GO DURING THE REFERRAL-</td>
         </tr>

        <g:each in="${admin.DictionaryItem.findAllByDictionary_idAndDisplayReport(admin.Dictionary.findByCode("FAUCYTYPE"),true)}" status="i" var="facilityTypeListInstance">
<tr>
        <%
                def countByFacilityType=0;
                        if(end_date&&from_date){
              countByFacilityType=chaid.MkChaid.executeQuery("from MkChaid where deleted=false and emergence_status<>0 and facility.type=:type and arrival_time between '"+from_date+"' and '"+end_date+"' and distric.region_id=:regionInstance ",[type:facilityTypeListInstance,regionInstance:regionInstance]).size();
            }else{
             countByFacilityType=chaid.MkChaid.executeQuery("from MkChaid where deleted=false and emergence_status<>0 and facility.type=:type and distric.region_id=:regionInstance",[type:facilityTypeListInstance,regionInstance:regionInstance]).size();

            }
        %>
        <g:if test="${countByFacilityType>0}">
        <td  class="info">${facilityTypeListInstance.name}</td>
        <td>
            ${formatAmountString(name: (int)countByFacilityType)}
        </td>
        </g:if>
  </tr>
</g:each>

   </table>
</div>