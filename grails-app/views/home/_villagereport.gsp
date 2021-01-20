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
    <td><span class="text-bold">${villageListInstance.name}</span></td>
        <td>${houseHoldNo}</td>
         <%
            def houseHoldMember=chaid.Household.executeQuery("select sum(total_members),sum(male_no),sum(female_no) from Household where village_id=:street ",[street:villageListInstance] )
         %>
    <td>${houseHoldMember[0][0]}</td>
 <td>${houseHoldMember[0][1]}</td>
 <td>${houseHoldMember[0][2]}</td>
 <td>
 <%
      def womenAgeBetweenNo=chaid.AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.street=:village ",[categoryType:admin.DictionaryItem.findByCode("CHAD17K"),village:villageListInstance])

 %>
 ${womenAgeBetweenNo[0]}
 </td>


  <td>
  <%
     def maleAgeBetweenNo=chaid.AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.street=:village ",[categoryType:admin.DictionaryItem.findByCode("CHAD17K"),village:villageListInstance])

  %>
  ${maleAgeBetweenNo[0]}
  </td>

  <td>
   <%
       def neonates=chaid.CategoryAvailableChildren.executeQuery("select sum(member_no) from CategoryAvailableChildren where categoryType=:categoryType  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.street=:village ",[categoryType:admin.DictionaryItem.findByCode("CHAD17D"),village:villageListInstance])
    %>

    ${neonates[0]}
  </td>

  <td>
   <%
          def infants=chaid.CategoryAvailableChildren.executeQuery("select sum(member_no)  from CategoryAvailableChildren where categoryType=:categoryType  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.street=:village ",[categoryType:admin.DictionaryItem.findByCode("CHAD17E"),village:villageListInstance])
       %>

      ${infants[0]}
    </td>
    <td>

      <%
                   def pregnantWomen=chaid.AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.street=:village ",[categoryType:admin.DictionaryItem.findByCode("CHAD17A"),village:villageListInstance])

          %>
          ${pregnantWomen[0]}

    </td>
    <td>
  <%
                   def breastFeedingWomen=chaid.AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.street=:village ",[categoryType:admin.DictionaryItem.findByCode("CHAD17B"),village:villageListInstance])

          %>
          ${breastFeedingWomen[0]}

    </td>

    </tr>
    <%
    countNo++;
    %>
</g:if>
</g:each>

</table>