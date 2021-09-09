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
            houseHoldNo=chaid.Household.executeQuery("from Household where created_at between '"+from_date+"' and '"+end_date+"'").size()

            }else{
           houseHoldNo=chaid.Household.executeQuery("from Household where deleted=false ").size()

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
                  groupAgeBetweenNo=chaid.AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and arrival_time between '"+from_date+"' and '"+end_date+"'",[categoryType:categorysListInstance])[0]

                  }else {
                      groupAgeBetweenNo=chaid.AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false ",[categoryType:categorysListInstance])[0]

                  }
                  if(!groupAgeBetweenNo){
                  groupAgeBetweenNo=0
                  }

               %>
              <td>${formatAmountString(name: (int)groupAgeBetweenNo)}</td>
             </g:each>

    </tr>

    <tr>
            <td colspan="16" class="text-bold text-left">  HEALTH EDUCATION:TYPE OF HEALTH EDUCATION PROVIDED FOR GIRLS AND BOYS IN THE ADOLESCENT GROUP AGES 10 -24 YEARS </td>
         </tr>

     <g:each in="${admin.DictionaryItem.findAllByDictionary_idAndDisplayReport(admin.Dictionary.findByCode("CHAD33F"),true)}" status="i" var="educationListInstance">

                    <tr>
                    <td  class="info" >${educationListInstance.name}</td>

                    <g:each in="${memberCategoryList}" var="categorysListInstance">
                    <%
                    def visitTypeInstance=admin.DictionaryItem.findByCode("CHAD4A")
                def noHoldMember=0
                  if(end_date&&from_date){
                   noHoldMember=materialize.view.ViewHealthEducation.executeQuery("select sum(h.member_no) from ViewHealthEducation h where category=:category and education_type=:education_type and chaid.visit_type=:visitTypeInstance and arrival_time between '"+from_date+"' and '"+end_date+"'",[category:categorysListInstance,education_type:educationListInstance,visitTypeInstance:visitTypeInstance])[0]

                  }else{
                      noHoldMember=materialize.view.ViewHealthEducation.executeQuery("select sum(h.member_no) from ViewHealthEducation h where category=:category and education_type=:education_type and chaid.visit_type=:visitTypeInstance",[category:categorysListInstance,education_type:educationListInstance,visitTypeInstance:visitTypeInstance])[0]

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
        def countReferrals=materialize.view.DangerSign.countBySignType(referralsListInstance)
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
              countByFacilityType=chaid.MkChaid.executeQuery("from MkChaid where deleted=false and emergence_status<>0 and facility.type=:type and arrival_time between '"+from_date+"' and '"+end_date+"'",[type:facilityTypeListInstance]).size();
            }else{
             countByFacilityType=chaid.MkChaid.executeQuery("from MkChaid where deleted=false and emergence_status<>0 and facility.type=:type",[type:facilityTypeListInstance]).size();

            }
        %>
        <g:if test="${countByFacilityType>0}">
        <td  class="info" colspan="3">${facilityTypeListInstance.name}</td>
        <td>
            ${formatAmountString(name: (int)countByFacilityType)}
        </td>
        </g:if>
  </tr>
</g:each>
<tr>
<td colspan="3">1.Idadi ya wavulana na wasichana kundi balehe umri 10-24 waliotoa ripoti na kupata huduma katika vituodhidi ya unyanyasaji wa kingono (Ukatili wa kijinsia- GBV)</td>
<td>${chaid.AdolescentAbuse.count()}</td>
</tr>

<td colspan="3">2-Idadi ya wavulana na wasichana umri 10-24 waliopewa ushauri juu ya  Virusi vya Ukimwi</td>
<td>${materialize.view.ViewHealthEducation.countByEducation_type(admin.DictionaryItem.findByCode('CHAD33F2'))}</td>
</tr>

<td colspan="3">3-Idadi ya wavulana na wasichana umri 10-24 waliopewa ushauri juu ya kufua kikuu</td>
<td>${materialize.view.ViewHealthEducation.countByEducation_type(admin.DictionaryItem.findByCode('CHAD6H'))} </td>
</tr>


<tr>
    <td colspan="16" class="text-bold text-center"> PROVISION OF HEALTH EDUCATION IN CONGREGATE SETTING/MASS</td>
 </tr>
 <tr><td colspan="2">Place Visited</td><td colspan="3">Total number reached during health education session</td>
 <td  colspan="3">Total number of Girls and Boys in the adolescent group who have received health education </td>
 </tr>
 <g:each in="${admin.DictionaryItem.findAllByDictionary_idAndDisplayReport(admin.Dictionary.findByCode("CHAD5"),true)}" status="i" var="gatheringTypeListInstance">
<tr>
<td  colspan="2">${gatheringTypeListInstance.name}</td>
<%
def totalCount=chaid.MkChaid.executeQuery("select sum(total_members) from MkChaid where deleted=false and meeting_type=:meeting_type",[meeting_type:gatheringTypeListInstance])[0]
%>
<td colspan="3">${totalCount}</td>
<td colspan="3"></td>
</tr>
</g:each>


<tr>
    <td colspan="16" class="text-bold text-left">TYPE OF HEALTH EDUCATION PROVIDED TO GIRLS AND BOYS IN THE ADOLESCENT GROUP DURING GATHERINGS </td>
 </tr>

<g:each in="${admin.DictionaryItem.findAllByDictionary_idAndDisplayReport(admin.Dictionary.findByCode("CHAD6"),true)}" status="i" var="educationListInstance">

                    <tr>
                    <td  class="info" colspan="3">${educationListInstance.name}</td>

                    <%
                def noHoldMember=0
                def visitTypeInstance=admin.DictionaryItem.findByCode("CHAD4B")

                  if(end_date&&from_date){
                   noHoldMember=materialize.view.ViewHealthEducation.executeQuery("select sum(h.member_no) from ViewHealthEducation h where  education_type=:education_type and chaid.visit_type=:visitTypeInstance and arrival_time between '"+from_date+"' and '"+end_date+"'",[education_type:educationListInstance,visitTypeInstance:visitTypeInstance])[0]

                  }else{
                      noHoldMember=materialize.view.ViewHealthEducation.executeQuery("select sum(h.member_no) from ViewHealthEducation h where  education_type=:education_type and chaid.visit_type=:visitTypeInstance",[education_type:educationListInstance,visitTypeInstance:visitTypeInstance])[0]

                  }
                   if(!noHoldMember){
                                  noHoldMember=0
                                  }
                    %>
                    <td>${formatAmountString(name: (int)noHoldMember)}</td>


                    </tr>
                    </g:each>

 <tr>
            <td colspan="16" class="text-bold text-center"> UHAMASISHAJI WA MFUKO WA BIMA YA AFYA ULIOBORESHA (iCHF)</td>
            <td></td>
         </tr>


    <tr>
            <%
             def surveyInstance1=admin.Dictionary.findByCode("CHAD60")
              def survey1=0
              if(end_date&&from_date){
               survey1=chaid.Survey.executeQuery(" select sum(survey_no) from Survey h where  type=:surveyInstance1  and arrival_time between '"+from_date+"' and '"+end_date+"'",[surveyInstance1:surveyInstance1]).size()

              }else{
             survey2=chaid.Survey.executeQuery("select sum(survey_no) from Survey where  type=:surveyInstance1",[surveyInstance1:surveyInstance1])[0]

              }

               def surveyInstance2=admin.Dictionary.findByCode("CHAD60")
                            def survey2=0
                            if(end_date&&from_date){
                             survey2=chaid.Survey.executeQuery(" select sum(survey_no)  from Survey h where  type=:surveyInstance1  and arrival_time between '"+from_date+"' and '"+end_date+"'",[surveyInstance1:surveyInstance2])[0]

                            }else{
                                survey2=chaid.Survey.executeQuery("select sum(survey_no) from Survey where  type=:surveyInstance1",[surveyInstance1:surveyInstance2])[0]

                            }
            %>
            <td colspan="3">1-Idadi ya kaya walio hamasishwa kujiunga na mfuko wa Bima ya Afya iliyoboreshwa (iCHF)</td>
            <td>${survey1}</td>
            </tr>
            <tr>
            <td  colspan="3">2-Idadi ya watu waliohamasishwa na kujiunga katika mfuko wa Bima ya Afya iliyoboeshwa</td>
            <td>0</td>
            </tr>
            <tr>
            <td  colspan="3">3-Idadi ya kaya ambao kadi zao za Bima ya Afya zimeisha wakahamasishwa na kujiunga tena katika Mfuko wa Bima ya Afya Ulioboreshwa</td>
            <td>${survey2}</td>
            </tr>
           <tr>
            <td  colspan="3">1.Idadi ya watoto na watu wazima walio ripoti kupata huduma za  uchunguzi wa magonjwa ya ngono na unyanyasaji kijinsia</td>
            <td>${chaid.AdolescentAbuse.count()}</td>
            </tr>

        <tr>
            <td colspan="16" class="text-bold text-center">  ELIMU YA COVID-19</td>
            <td></td>
         </tr>
         <tr>
         <%
          def educationListInstance=admin.DictionaryItem.findByCode("CHAD33F5")

           if(end_date&&from_date){
            noHoldMember=materialize.view.ViewHealthEducation.executeQuery("select sum(h.chaid.members_male), sum(h.chaid.members_female)  from ViewHealthEducation h where  education_type=:education_type  and arrival_time between '"+from_date+"' and '"+end_date+"'",[education_type:educationListInstance])[0]

           }else{
               noHoldMember=materialize.view.ViewHealthEducation.executeQuery("select sum(h.chaid.members_male), sum(h.chaid.members_female) from ViewHealthEducation h where  education_type=:education_type ",[education_type:educationListInstance])[0]

           }
         %>
         <td colspan="3">1. Idadi ya wanaume waliopatiwa elimu ya COVID 19</td>
         <td>${noHoldMember[1]}</td>
         </tr>
         <tr>
         <td  colspan="3">2. Idadi ya wanawake waliopatiwa elimu ya COVID 19</td>
         <td>${noHoldMember[1]}</td>
         </tr>
         <tr>
         <td  colspan="3">3. Jumla ya watu waliopatiwa elimu ya COVID 19</td>
         <td>0</td>
         </tr>

         </tr>

   </table>
</div>