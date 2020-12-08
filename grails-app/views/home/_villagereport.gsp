<table class="table">
<tr>
<th>No</th><th>Village Name</th><th>Households</th><th>Population</th><th>Women</th><th>Men</th>
<th>Women Childbearing between Age 15-49 years</th>
<th>Men between Age 15-49 years</th>

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
    <td>${chadNo}</td>
 <td>${chaid.MkChaid.countByRespondent_genderAndStreet("Female",villageListInstance)}</td>
 <td>${chaid.MkChaid.countByRespondent_genderAndStreet("Male",villageListInstance)}</td>
 <td>
 <%
    def womenAgeBetweenNo=chaid.MkChaid.executeQuery("from MkChaid where street=:street and respondent_gender=:gender and respondent_age>=15 and respondent_age<=49",[street:street,gender:'Female'] ).size()
 %>
 ${womenAgeBetweenNo}
 </td>


  <td>
  <%
     def maleAgeBetweenNo=chaid.MkChaid.executeQuery("from MkChaid where street=:street and respondent_gender=:gender and respondent_age>=15 and respondent_age<=49",[street:street,gender:'Male'] ).size()
  %>
  ${maleAgeBetweenNo}
  </td>

    </tr>
    <%
    countNo++;
    %>
</g:if>
</g:each>

</table>