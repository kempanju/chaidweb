<div style=" overflow-x: auto;">
   <table class="table  table-bordered">

    <tr>
            <td colspan="18" class="text-bold text-center">PROVISION OF HEALTH EDUCATION AND FOLLOW UP AT HOUSEHOLD LEVEL</td>
         </tr>
         <tr><td></td>

<g:each in="${admin.DictionaryItem.findAllByDictionary_id(admin.Dictionary.findByCode("CHAD17"))}" var="categoryListInstance">
                <td class="success">${categoryListInstance.name}</td>

        </g:each></tr>
     <g:each in="${admin.DictionaryItem.findAllByDictionary_id(admin.Dictionary.findByCode("CHAD33F"))}" status="i" var="educationListInstance">

                    <tr>
                    <td  class="info">${educationListInstance.name}</td>

                    <g:each in="${admin.DictionaryItem.findAllByDictionary_id(admin.Dictionary.findByCode("CHAD17"))}" var="categorysListInstance">
                    <%
                def noHoldMember=0
                  if(end_date&&from_date){
                   noHoldMember=materialize.view.ViewHealthEducation.executeQuery("select sum(h.member_no) from ViewHealthEducation h where category=:category and education_type=:education_type and chaid.distric.region_id=:regionInstance and  arrival_time between '"+from_date+"' and '"+end_date+"'",[category:categorysListInstance,education_type:educationListInstance,regionInstance:regionInstance])[0]

                  }else{
                      noHoldMember=materialize.view.ViewHealthEducation.executeQuery("select sum(h.member_no) from ViewHealthEducation h where category=:category and chaid.distric.region_id=:regionInstance and education_type=:education_type ",[category:categorysListInstance,education_type:educationListInstance,regionInstance:regionInstance])[0]

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

        <g:each in="${admin.DictionaryItem.findAllByDictionary_id(admin.Dictionary.findByCode("CHAD17"))}" var="categorysListInstance">
        <%
                    def noHoldMember=0
                if(end_date&&from_date){
                 noHoldMember=materialize.view.ViewHealthEducation.executeQuery("select sum(j.member_no) from ViewHealthEducation j where category=:category and education_type=:education_type and chaid.distric.region_id=:regionInstance and  arrival_time between '"+from_date+"' and '"+end_date+"'",[category:categorysListInstance,education_type:educationListInstance,regionInstance:regionInstance])[0]

                }else{
                    noHoldMember=materialize.view.ViewHealthEducation.executeQuery("select sum(j.member_no) from ViewHealthEducation j where category=:category and chaid.distric.region_id=:regionInstance and education_type=:education_type ",[category:categorysListInstance,education_type:educationListInstance,regionInstance:regionInstance])[0]

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





   </table>
</div>