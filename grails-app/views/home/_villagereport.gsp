<table class="table">
<tr>
<th>No</th><th>Village Name</th><th>Households</th><th>Population</th><th>Women</th><th>Men</th>
<th>Women Childbearing (15-49) </th>
<th>Men(15-49)</th>
<th>Neonates</th>
<th>Infants</th>
<th>Pregnant Women</th>
<th>Breastfeeding Women</th>
</tr>
<%
def countNo=1;
%>
<g:each in="${admin.Street.findAllByDistrict_id(districtInstance,[order:'asc',sort:'name'])}" status="i" var="villageListInstance">
    <%
        def houseHoldNo=chaid.Household.countByVillage_id(villageListInstance)
        def chadNo=chaid.MkChaid.countByStreet(villageListInstance)
    %>

    <g:if test="${houseHoldNo>0||chadNo>0}">

    <tr>
    <td>${countNo}</td>
    <td>${villageListInstance.name}</td>
        <td>${houseHoldNo}</td>
         <%
            def houseHoldMember=chaid.Household.executeQuery("select sum(total_members),sum(male_no),sum(female_no) from Household where village_id=:street ",[street:villageListInstance] )
         %>
    <td>${houseHoldMember[0][0]}</td>
 <td>${houseHoldMember[0][1]}</td>
 <td>${houseHoldMember[0][2]}</td>
 <td>
 <%
    def womenAgeBetweenNo=chaid.MkChaid.executeQuery("from MkChaid where street=:street and respondent_gender=:gender and respondent_age>=15 and respondent_age<=49",[street:villageListInstance,gender:'Female'] ).size()
 %>
 ${womenAgeBetweenNo}
 </td>


  <td>
  <%
     def maleAgeBetweenNo=chaid.MkChaid.executeQuery("from MkChaid where street=:street and respondent_gender=:gender and respondent_age>=15 and respondent_age<=49",[street:villageListInstance,gender:'Male'] ).size()
  %>
  ${maleAgeBetweenNo}
  </td>

  <td>
   <%
       def postDelivery=chaid.PostDelivery.executeQuery("from PostDelivery where chaid.street=:street and child_age_month<1",[street:villageListInstance] ).size()
    %>

    ${postDelivery}
  </td>

  <td>
     <%
         def postDeliveryYear=chaid.PostDelivery.executeQuery("from PostDelivery where chaid.street=:street and child_age_month>0 and child_age_month<=12",[street:villageListInstance] ).size()
      %>

      ${postDeliveryYear}
    </td>
    <td>

      <%
             def pregnantWomen=chaid.PreginantDetails.executeQuery("from PreginantDetails where chaid.street=:street",[street:villageListInstance] ).size()
          %>
          ${pregnantWomen}

    </td>
    <td>
    </td>

    </tr>
    <%
    countNo++;
    %>
</g:if>
</g:each>

</table>