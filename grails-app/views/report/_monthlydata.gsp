<%
    def memberCategoryList=admin.DictionaryItem.findAllByDictionary_idAndDisplayReport(admin.Dictionary.findByCode("CHAD17"),true,[sort:'displayOrder',order:'asc']);
%>

<div class="col-lg-12" style=" overflow-x: auto">
   <table class="table  table-bordered nowrap" >

     <tr style="white-space:nowrap;"><th></th><th></th>

   <g:each in="${memberCategoryList}" var="categoryListInstance">
                   <th class="success">${categoryListInstance.abbreviation}</th>

           </g:each></tr>
<tr>
            <td colspan="16" class="text-bold text-center"> TAARIFA ZA KUTEMBELEA MAJUMBANI </td>
         </tr>
  <tr>
  <td colspan="3">1. Idadi ya kaya zilizotembelewa</td>
  <%
  def visitType=admin.DictionaryItem.findByCode("CHAD4A")

  def visitedHouseHold=chaid.MkChaid.countByDeletedAndVisit_type(false,visitType)

  %>
  <td>${formatAmountString(name: (int)visitedHouseHold)}</td>
  </tr>

   <td colspan="3">2. Idadi ya kaya zilizotembelewa ndani ya mwezi huu</td>
    <%

    def visitedNewHouseHold=chaid.MkChaid.executeQuery("from MkChaid where deleted=false and visit_type=:visitType and  household.created_at >= date_trunc('month', CURRENT_DATE) ",[visitType:visitType]).size()

    %>
    <td>${formatAmountString(name: (int)visitedNewHouseHold)}</td>
    </tr>
<tr>
            <td colspan="16" class="text-bold text-center"> TAARIFA ZA RUFAA ZILIZOTOLEWA </td>
         </tr>
 <tr>
 <td>3. Idadi ya wajawazito waliopewa rufaa kwenda kuanza huduma za kliniki </td>
 <%
 def dangerSignNo=chaid.DangerSignPregnant.count();
 def totalNumber=dangerSignNo
 %>
 <td>${formatAmountString(name: (int)dangerSignNo)}</td>
 <td style="background:black"></td>
 <td style="background:black"></td>
 <%
  def dangerSignNo1=chaid.DangerSignPregnant.executeQuery("from  DangerSignPregnant where preginantDetails.age between 10 and 19").size();
  %>
 <td>${formatAmountString(name: (int)dangerSignNo1)}</td>
  <td style="background:black"></td>
  <%
    def dangerSignNo2=chaid.DangerSignPregnant.executeQuery("from  DangerSignPregnant where preginantDetails.age between 19 and 24").size();
    %>
<td>${formatAmountString(name: (int)dangerSignNo2)}</td>
  <td style="background:black"></td>

 </tr>

 <tr>
  <td>4. Idadi ya Watoto chini ya miaka 5 wenye utapiamlo waliopewa rufaa kwa matibabu zaidi </td>
  <%
  def dangerSignChildNo=chaid.DangerSignChildDelivery.count();
  totalNumber=totalNumber+dangerSignChildNo
  %>
  <td>${formatAmountString(name: (int)dangerSignChildNo)}</td>
  </tr>

<tr>
  <td>5. Idadi ya wateja waliopewa rufaa kwa sababu zingine za kiafya mbali na ujauzito na utapiamlo </td>
  <%
  def dangerSignDeliveryNo=chaid.DangerSignMotherDelivery.count();
  totalNumber=totalNumber+dangerSignDeliveryNo
  %>
  <td>${formatAmountString(name: (int)dangerSignDeliveryNo)}</td>
  </tr>
<tr>
<td>6. Jumla ya rufaa zilizotolewa (3+4+5)</td>
<td>${formatAmountString(name: (int)totalNumber)}</td>
</tr>
<tr>
<td>7. Jumla ya rufaa zilizofanikiwa</td>
<%
def referrals=chaid.MkChaid.executeQuery("from MkChaid where emergence_status=2 and deleted=false").size()
%>
<td>${formatAmountString(name: (int)referrals)}</td>
</tr>

<tr>
<td colspan="16" class="text-bold text-center"> TAARIFA ZA UFUATILIAJI WA WAJAWAZITO NA WATOTO WENYE UTAPIAMLO </td>
</tr>
<tr>
<td>8. Idadi ya wajawazito walioanza kliniki ndani ya mwezi huu </td>
<%
 def clinicNo=chaid.PreginantDetails.executeQuery("from  PreginantDetails where date_part('month', clinic_first_date) = date_part('month', CURRENT_DATE)").size();
%>
<td>${formatAmountString(name: (int)clinicNo)}</td>
<td style="background:black"></td>
<td style="background:black"></td>
<%
 def clinicNoAge=chaid.PreginantDetails.executeQuery("from  PreginantDetails where (age between 10 and 19) and date_part('month', clinic_first_date) = date_part('month', CURRENT_DATE)").size();

%>
<td>${formatAmountString(name: (int)clinicNoAge)}</td>
<%
 def clinicNoAge24=chaid.PreginantDetails.executeQuery("from  PreginantDetails where (age between 19 and 24) and date_part('month', clinic_first_date) = date_part('month', CURRENT_DATE)").size();

%>
<td style="background:black"></td>
<td>${formatAmountString(name: (int)clinicNoAge24)}</td>
<td style="background:black"></td>

</tr>

<tr>
<td>9. Idadi ya wajawazito waliokamilisha walau mahudhurio 4 au Zaidi ya kliniki </td>
<%
 def clinicMoreNo=chaid.PreginantDetails.executeQuery("from PreginantDetails where  clinic_first_date is not null and clinic_second_date is not null and clinic_third_date is not null and clinic_fourth_date is not null ").size();
%>
<td>${formatAmountString(name: (int)clinicMoreNo)}</td>
</tr>

<tr>
<td>10. Idadi ya wajawazito waliotegemewa kujifungua ndani ya mwezi huu </td>

<%
def deliveryNoMonth=view.PregnantDelivery.count()
%>
<td>${formatAmountString(name: (int)deliveryNoMonth)}</td>
<td style="background:black"></td>
<td style="background:black"></td>
<%
def deliveryNoMonth3=view.PregnantDelivery.executeQuery("from PregnantDelivery where age between 10 and 19").size()
%>
<td>${formatAmountString(name: (int)deliveryNoMonth3)}</td>
<td style="background:black"></td>

<%
def deliveryNoMonth4=view.PregnantDelivery.executeQuery("from PregnantDelivery where age between 19 and 24").size()
%>
<td>${formatAmountString(name: (int)deliveryNoMonth4)}</td>
<td style="background:black"></td>

</tr>

<tr>
<td>11. Idadi ya wajawazito waliojifungua kwenye kituo ndani ya eneo husika </td>
<%
def dictionaryInstance5=admin.DictionaryItem.findByCode("CHAD23E1");
def delivery5=chaid.PostDelivery.countByDelivery_place(dictionaryInstance5)
%>
<td>${formatAmountString(name: (int)delivery5)}</td>
</tr>

<tr>
<td>12. Idadi ya wajawazito waliojifungua kwenye vituo vingine vya afya </td>
<%
def dictionaryInstance4=admin.DictionaryItem.findByCode("CHAD23E4");
def delivery4=chaid.PostDelivery.countByDelivery_place(dictionaryInstance4)
%>
<td>${formatAmountString(name: (int)delivery4)}</td>
</tr>

<tr>
<td>13. Idadi ya wajawazito waliojifungulia nyumbani  </td>
<%
def dictionaryInstance3=admin.DictionaryItem.findByCode("CHAD23E3");
def delivery3=chaid.PostDelivery.countByDelivery_place(dictionaryInstance3)
%>
<td>${formatAmountString(name: (int)delivery3)}</td>
</tr>

<tr>
<td>14. Idadi ya wajawazito waliojifungua kwa wakunga wa jadi </td>
<%
def dictionaryInstance2=admin.DictionaryItem.findByCode("CHAD23E5");
def delivery2=chaid.PostDelivery.countByDelivery_place(dictionaryInstance2)
%>
<td>${formatAmountString(name: (int)delivery2)}</td>
</tr>

<tr>
<td>15. Idadi ya wajawazito waliojifungua njiani </td>
<%
def dictionaryInstance1=admin.DictionaryItem.findByCode("CHAD23E2");
def delivery1=chaid.PostDelivery.countByDelivery_place(dictionaryInstance1)
%>
<td>${formatAmountString(name: (int)delivery1)}</td>
</tr>

<tr>
<td>16. Idadi ya wajawazito waliojifungua ndani ya mwezi huu  </td>
<%
 def deliveryNo=chaid.PostDelivery.executeQuery("from PostDelivery where  date_part('month', delivery_date) = date_part('month', CURRENT_DATE)").size();
%>
<td>${formatAmountString(name: (int)deliveryNo)}</td>
</tr>

<tr>
<td>17. Idadi ya akina mama waliojifungua nje ya kituo na wakahudhuria kliniki ndani ya saa 24 baada ya kujifungua  </td>
<td>0</td>
</tr>

<tr>
<td>18. Idadi ya watoto wenye utapiamlo wanaofuatiliwa  </td>
<td>0</td>
</tr>

<tr>
<td colspan="16" class="text-bold text-center"> TAARIFA ZA VIFO VYA WAZAZI NA WATOTO CHINI YA MIAKA 5 ZILIZOTOKEA KWENYE JAMII </td>
</tr>

<tr>
<td>19. Idadi ya vifo vilivyotakana na uzazi  </td>
<%
 def deliveryOutCome=chaid.PostDelivery.executeQuery("from PostDelivery where  outcome_type.code='CHAD23B2'").size();
%>
<td>${formatAmountString(name: (int)deliveryOutCome)}</td>
</tr>

<tr>
<td>20. Idadi ya vifo vya watoto chini ya siku 28   </td>
<%
 def deliveryCondition=chaid.PostDelivery.executeQuery("from PostDelivery where  outcome_type.code='CHAD23B1' and  baby_condition.code='CHAD23C2'").size();
%>
<td>${formatAmountString(name: (int)deliveryCondition)}</td>
</tr>
</tr>


<tr>
<td>21. Idadi ya vifo vya watoto mwezi 1 hadi miaka 5   </td>
<td>0</td>
</tr>

<tr>
<td colspan="16" class="text-bold text-center"> TAARIFA YA UKATILI WA KIJINSIA, MFUKO WA BIMA YA AFYA YA JAMII ULIOBORESHWA, MIKUTANO YA KAMATI YA AFYA YA KIJIJI NA MIKUTANO YA HADHARA ULIYOHUDHURIA </td>
</tr>

<tr>
<td>22. Idadi ya kaya zilizohamasishwa kujiunga na mfuko wa Bima ya afya ya jamii ulioboreshwa (iCHF)  </td>
<td></td>
</tr>


<tr>
<td>23. Idadi ya kaya zilizojiunga na mfuko wa Bima ya afya ya jamii ulioboreshwa (iCHF)  </td>
<td></td>
</tr>


<tr>
<td>24. Idadi ya wateja waliofanyiwa ukatili wa kijinsia (Eleza aina ya ukatili aliofanyiwa na hatua zilizochukuliwa)  </td>
<td></td>
</tr>

</table>
</div>