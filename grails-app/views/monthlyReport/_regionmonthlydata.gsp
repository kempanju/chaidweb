<%@ page import="chaid.PostDelivery; view.PregnantDelivery; chaid.PreginantDetails; chaid.DangerSignMotherDelivery; chaid.DangerSignChildDelivery; chaid.DangerSignPregnant; chaid.MkChaid; admin.DictionaryItem" %>
<%
    def memberCategoryList = DictionaryItem.findAllByDictionary_idAndDisplayReport(admin.Dictionary.findByCode("CHAD17"), true, [sort: 'displayOrder', order: 'asc']);
%>

<div class="col-lg-12" style=" overflow-x: auto">
    <table class="table  table-bordered nowrap">

        <tr style="white-space:nowrap;"><th></th><th></th>

            <g:each in="${memberCategoryList}" var="categoryListInstance">
                <th class="success">${categoryListInstance.abbreviation}</th>

            </g:each></tr>
        <tr>
            <td colspan="16" class="text-bold text-center">TAARIFA ZA KUTEMBELEA MAJUMBANI</td>
        </tr>
        <tr>
            <td colspan="3">1. Idadi ya kaya zilizotembelewa</td>
            <%
                def visitType = DictionaryItem.findByCode("CHAD4A")

                def visitedHouseHold
                if (end_date && from_date) {
                    visitedHouseHold = MkChaid.executeQuery("select id from MkChaid where deleted=false and visit_type=:visitType and arrival_time between '" + from_date + "' and '" + end_date + "' and distric.region_id=:regionInstance", [visitType: visitType, regionInstance: regionInstance]).size()
                } else {
                    visitedHouseHold = MkChaid.executeQuery("select id from MkChaid where deleted=false and visit_type=:visitType  and distric.region_id=:regionInstance", [visitType: visitType, regionInstance: regionInstance]).size()
                }

            %>
            <td>${formatAmountString(name: (int) visitedHouseHold)}</td>
        </tr>
        <tr>
            <td colspan="3">2. Idadi ya kaya zilizotembelewa ndani ya muda huu</td>
            <%
                def visitedNewHouseHold = 0
                if (end_date && from_date) {
                    visitedNewHouseHold = MkChaid.executeQuery("select id from MkChaid where deleted=false and visit_type=:visitType and  household.created_at between '" + from_date + "' and '" + end_date + "' and distric.region_id=:regionInstance", [visitType: visitType, regionInstance: regionInstance]).size()

                } else {
                    visitedNewHouseHold = MkChaid.executeQuery("select id from MkChaid where deleted=false and visit_type=:visitType and  household.created_at >= date_trunc('month', CURRENT_DATE) and distric.region_id=:regionInstance", [visitType: visitType, regionInstance: regionInstance]).size()

                }
            %>
            <td>${formatAmountString(name: (int) visitedNewHouseHold)}</td>
        </tr>
        <tr>
            <td colspan="16" class="text-bold text-center">TAARIFA ZA RUFAA ZILIZOTOLEWA</td>
        </tr>
        <tr>
            <td>3. Idadi ya wajawazito waliopewa rufaa kwenda kuanza huduma za kliniki</td>
            <%
                def dangerSignNo = 0
                if (end_date && from_date) {
                    dangerSignNo = DangerSignPregnant.executeQuery("select id from DangerSignPregnant where created_at between '" + from_date + "' and '" + end_date + "' and chaid.distric.region_id=:regionInstance", [regionInstance: regionInstance]).size()
                } else {
                    dangerSignNo = DangerSignPregnant.executeQuery("select id from DangerSignPregnant where  chaid.distric.region_id=:regionInstance", [regionInstance: regionInstance]).size()

                }

                def totalNumber = dangerSignNo
            %>
            <td>${formatAmountString(name: (int) dangerSignNo)}</td>
            <td style="background:black"></td>
            <td style="background:black"></td>
            <%
                def dangerSignNo1 = 0
                if (end_date && from_date) {
                    dangerSignNo1 = DangerSignPregnant.executeQuery("select id from  DangerSignPregnant where (preginantDetails.age between 10 and 19) and created_at between '" + from_date + "' and '" + end_date + "' and chaid.distric.region_id=:regionInstance", [regionInstance: regionInstance]).size();
                } else {
                    dangerSignNo1 = DangerSignPregnant.executeQuery("select id from  DangerSignPregnant where preginantDetails.age between 10 and 19 and chaid.distric.region_id=:regionInstance", [regionInstance: regionInstance]).size();
                }
            %>
            <td>${formatAmountString(name: (int) dangerSignNo1)}</td>
            <td style="background:black"></td>
            <%
                def dangerSignNo2 = 0
                if (end_date && from_date) {
                    dangerSignNo2 = DangerSignPregnant.executeQuery("select id from  DangerSignPregnant where (preginantDetails.age between 19 and 24) and created_at between '" + from_date + "' and '" + end_date + "' and chaid.distric.region_id=:regionInstance", [regionInstance: regionInstance]).size();
                } else {
                    dangerSignNo2 = DangerSignPregnant.executeQuery("select id from  DangerSignPregnant where (preginantDetails.age between 19 and 24) and chaid.distric.region_id=:regionInstance", [regionInstance: regionInstance]).size();
                }
            %>
            <td>${formatAmountString(name: (int) dangerSignNo2)}</td>
            <td style="background:black"></td>

        </tr>

        <tr>
            <td>4. Idadi ya Watoto chini ya miaka 5 wenye utapiamlo waliopewa rufaa kwa matibabu zaidi</td>
            <%
                def dangerSignChildNo = 0
                if (end_date && from_date) {
                    dangerSignChildNo = DangerSignChildDelivery.executeQuery("select id from DangerSignChildDelivery where  created_at between '" + from_date + "' and '" + end_date + "' and chaid.distric.region_id=:regionInstance", [regionInstance: regionInstance]).size();
                } else {
                    dangerSignChildNo = DangerSignChildDelivery.executeQuery("select id from DangerSignChildDelivery where   chaid.distric.region_id=:regionInstance", [regionInstance: regionInstance]).size();
                }
                totalNumber = totalNumber + dangerSignChildNo
            %>
            <td>${formatAmountString(name: (int) dangerSignChildNo)}</td>
        </tr>

        <tr>
            <td>5. Idadi ya wateja waliopewa rufaa kwa sababu zingine za kiafya mbali na ujauzito na utapiamlo</td>
            <%
                def dangerSignDeliveryNo = 0
                if (end_date && from_date) {
                    dangerSignDeliveryNo = DangerSignMotherDelivery.executeQuery("select id from DangerSignMotherDelivery where  created_at between '" + from_date + "' and '" + end_date + "' and chaid.distric.region_id=:regionInstance", [regionInstance: regionInstance]).size();
                } else {
                    dangerSignDeliveryNo = DangerSignMotherDelivery.executeQuery("select id from DangerSignMotherDelivery where   chaid.distric.region_id=:regionInstance", [regionInstance: regionInstance]).size();

                }
                totalNumber = totalNumber + dangerSignDeliveryNo
            %>
            <td>${formatAmountString(name: (int) dangerSignDeliveryNo)}</td>
        </tr>
        <tr>
            <td>6. Jumla ya rufaa zilizotolewa (3+4+5)</td>
            <td>${formatAmountString(name: (int) totalNumber)}</td>
        </tr>
        <tr>
            <td>7. Jumla ya rufaa zilizofanikiwa</td>
            <%
                def referrals = 0
                if (end_date && from_date) {
                    referrals = MkChaid.executeQuery("select id from MkChaid where emergence_status=2 and deleted=false and  arrival_time between '" + from_date + "' and '" + end_date + "' and distric.region_id=:regionInstance", [regionInstance: regionInstance]).size()

                } else {
                    referrals = MkChaid.executeQuery("select id from MkChaid where emergence_status=2 and deleted=false and distric.region_id=:regionInstance", [regionInstance: regionInstance]).size()
                }
            %>
            <td>${formatAmountString(name: (int) referrals)}</td>
        </tr>

        <tr>
            <td colspan="16"
                class="text-bold text-center">TAARIFA ZA UFUATILIAJI WA WAJAWAZITO NA WATOTO WENYE UTAPIAMLO</td>
        </tr>
        <tr>
            <td>8. Idadi ya wajawazito walioanza kliniki ndani ya mwezi huu</td>
            <%
                def clinicNo = 0
                if (end_date && from_date) {
                    clinicNo = PreginantDetails.executeQuery("select id from  PreginantDetails where clinic_first_date between '" + from_date + "' and '" + end_date + "' and chaid.distric.region_id=:regionInstance", [regionInstance: regionInstance]).size();
                } else {
                    clinicNo = PreginantDetails.executeQuery("select id from  PreginantDetails where date_part('month', clinic_first_date) = date_part('month', CURRENT_DATE) and chaid.distric.region_id=:regionInstance", [regionInstance: regionInstance]).size();
                }
            %>
            <td>${formatAmountString(name: (int) clinicNo)}</td>
            <td style="background:black"></td>
            <td style="background:black"></td>
            <%
                def clinicNoAge = 0
                if (end_date && from_date) {
                    clinicNoAge = PreginantDetails.executeQuery("select id from  PreginantDetails where (age between 10 and 19) and clinic_first_date between '" + from_date + "' and '" + end_date + "' and chaid.distric.region_id=:regionInstance", [regionInstance: regionInstance]).size();
                } else {
                    clinicNoAge = PreginantDetails.executeQuery("select id from  PreginantDetails where (age between 10 and 19) and date_part('month', clinic_first_date) = date_part('month', CURRENT_DATE) and chaid.distric.region_id=:regionInstance", [regionInstance: regionInstance]).size();

                }

            %>
            <td>${formatAmountString(name: (int) clinicNoAge)}</td>
            <%
                def clinicNoAge24 = 0
                if (end_date && from_date) {
                    clinicNoAge24 = PreginantDetails.executeQuery("select id from  PreginantDetails where (age between 19 and 24) and clinic_first_date between '" + from_date + "' and '" + end_date + "' and chaid.distric.region_id=:regionInstance", [regionInstance: regionInstance]).size();
                } else {
                    clinicNoAge24 = PreginantDetails.executeQuery("select id from  PreginantDetails where (age between 19 and 24) and date_part('month', clinic_first_date) = date_part('month', CURRENT_DATE) and chaid.distric.region_id=:regionInstance", [regionInstance: regionInstance]).size();

                }

            %>
            <td style="background:black"></td>
            <td>${formatAmountString(name: (int) clinicNoAge24)}</td>
            <td style="background:black"></td>

        </tr>

        <tr>
            <td>9. Idadi ya wajawazito waliokamilisha walau mahudhurio 4 au Zaidi ya kliniki</td>
            <%
                def clinicMoreNo = 0
                if (end_date && from_date) {
                    clinicMoreNo = PreginantDetails.executeQuery("select id from PreginantDetails where  (clinic_first_date is not null and clinic_second_date is not null and clinic_third_date is not null and clinic_fourth_date is not null) " +

                            "and created_at between '" + from_date + "' and '" + end_date + "' and chaid.distric.region_id=:regionInstance", [regionInstance: regionInstance]).size();
                } else {
                    clinicMoreNo = PreginantDetails.executeQuery("select id from PreginantDetails where  clinic_first_date is not null and clinic_second_date is not null and clinic_third_date is not null and clinic_fourth_date is not null and chaid.distric.region_id=:regionInstance", [regionInstance: regionInstance]).size();

                }
            %>
            <td>${formatAmountString(name: (int) clinicMoreNo)}</td>
        </tr>

        <tr>
            <td>10. Idadi ya wajawazito waliotegemewa kujifungua ndani ya mwezi huu</td>

            <%

                def deliveryNoMonth = PregnantDelivery.count()
            %>
            <td>${formatAmountString(name: (int) deliveryNoMonth)}</td>
            <td style="background:black"></td>
            <td style="background:black"></td>
            <%
                def deliveryNoMonth3 = PregnantDelivery.executeQuery("from PregnantDelivery where age between 10 and 19").size()
            %>
            <td>${formatAmountString(name: (int) deliveryNoMonth3)}</td>
            <td style="background:black"></td>

            <%
                def deliveryNoMonth4 = PregnantDelivery.executeQuery("from PregnantDelivery where age between 19 and 24").size()
            %>
            <td>${formatAmountString(name: (int) deliveryNoMonth4)}</td>
            <td style="background:black"></td>

        </tr>

        <tr>
            <td>11. Idadi ya wajawazito waliojifungua kwenye kituo ndani ya eneo husika</td>
            <%
                def dictionaryInstance5 = DictionaryItem.findByCode("CHAD23E1");
                def delivery5 = 0
                if (end_date && from_date) {
                    delivery5 = PostDelivery.executeQuery("select id from PostDelivery where delivery_place=:delivery_place " +

                            "and created_at between '" + from_date + "' and '" + end_date + "' and chaid.distric.region_id=:regionInstance", [delivery_place: dictionaryInstance5, regionInstance: regionInstance]).size()
                } else {
                    delivery5 = PostDelivery.executeQuery("select id from PostDelivery where delivery_place=:delivery_place " +

                            "and  chaid.distric.region_id=:regionInstance", [delivery_place: dictionaryInstance5, regionInstance: regionInstance]).size()

                }
            %>
            <td>${formatAmountString(name: (int) delivery5)}</td>
        </tr>

        <tr>
            <td>12. Idadi ya wajawazito waliojifungua kwenye vituo vingine vya afya</td>
            <%
                def dictionaryInstance4 = DictionaryItem.findByCode("CHAD23E4");
                def delivery4 = 0
                if (end_date && from_date) {
                    delivery4 = PostDelivery.executeQuery("select id from PostDelivery where delivery_place=:delivery_place and" +

                            " created_at between '" + from_date + "' and '" + end_date + "' and  chaid.distric.region_id=:regionInstance", [delivery_place: dictionaryInstance4, regionInstance: regionInstance]).size()
                } else {
                    delivery4 = PostDelivery.executeQuery("select id from PostDelivery where delivery_place=:delivery_place and" +

                            "   chaid.distric.region_id=:regionInstance", [delivery_place: dictionaryInstance4, regionInstance: regionInstance]).size()

                }
            %>
            <td>${formatAmountString(name: (int) delivery4)}</td>
        </tr>

        <tr>
            <td>13. Idadi ya wajawazito waliojifungulia nyumbani</td>
            <%
                def dictionaryInstance3 = DictionaryItem.findByCode("CHAD23E3");
                def delivery3 = 0
                if (end_date && from_date) {
                    delivery3 = PostDelivery.executeQuery("select id from PostDelivery where delivery_place=:delivery_place and created_at between" +

                            " '" + from_date + "' and '" + end_date + "' and  chaid.distric.region_id=:regionInstance", [delivery_place: dictionaryInstance3, regionInstance: regionInstance]).size()
                } else {
                    delivery3 = PostDelivery.executeQuery("select id from PostDelivery where delivery_place=:delivery_place " +

                            "  and  chaid.distric.region_id=:regionInstance", [delivery_place: dictionaryInstance3, regionInstance: regionInstance]).size()

                }
            %>
            <td>${formatAmountString(name: (int) delivery3)}</td>
        </tr>

        <tr>
            <td>14. Idadi ya wajawazito waliojifungua kwa wakunga wa jadi</td>
            <%
                def dictionaryInstance2 = DictionaryItem.findByCode("CHAD23E5");
                def delivery2 = 0

                if (end_date && from_date) {
                    delivery2 = PostDelivery.executeQuery("select id from PostDelivery where delivery_place=:delivery_place and created_at between '" + from_date + "' and '" + end_date + "' and  chaid.distric.region_id=:regionInstance", [delivery_place: dictionaryInstance2, regionInstance: regionInstance]).size()
                } else {
                    delivery2 = PostDelivery.executeQuery("select id from PostDelivery where delivery_place=:delivery_place and   chaid.distric.region_id=:regionInstance", [delivery_place: dictionaryInstance2, regionInstance: regionInstance]).size()

                }
            %>
            <td>${formatAmountString(name: (int) delivery2)}</td>
        </tr>

        <tr>
            <td>15. Idadi ya wajawazito waliojifungua njiani</td>
            <%
                def dictionaryInstance1 = DictionaryItem.findByCode("CHAD23E2");
                def delivery1 = 0

                if (end_date && from_date) {
                    delivery1 = PostDelivery.executeQuery("select id from PostDelivery where delivery_place=:delivery_place and created_at between '" + from_date + "' and '" + end_date + "' and  chaid.distric.region_id=:regionInstance", [delivery_place: dictionaryInstance1, regionInstance: regionInstance]).size()
                } else {
                    delivery1 = PostDelivery.executeQuery("select id from PostDelivery where delivery_place=:delivery_place and   chaid.distric.region_id=:regionInstance", [delivery_place: dictionaryInstance1, regionInstance: regionInstance]).size()

                }
            %>
            <td>${formatAmountString(name: (int) delivery1)}</td>
        </tr>

        <tr>
            <td>16. Idadi ya wajawazito waliojifungua ndani ya mwezi huu</td>
            <%
                def deliveryNo = 0
                if (end_date && from_date) {
                    deliveryNo = PostDelivery.executeQuery("select id from PostDelivery where delivery_date  between '" + from_date + "' and '" + end_date + "' and  chaid.distric.region_id=:regionInstance", [regionInstance: regionInstance]).size();
                } else {
                    deliveryNo = PostDelivery.executeQuery("select id from PostDelivery where  date_part('month', delivery_date) = date_part('month', CURRENT_DATE) and  chaid.distric.region_id=:regionInstance", [regionInstance: regionInstance]).size();

                }
            %>
            <td>${formatAmountString(name: (int) deliveryNo)}</td>
        </tr>

        <tr>
            <td>17. Idadi ya akina mama waliojifungua nje ya kituo na wakahudhuria kliniki ndani ya saa 24 baada ya kujifungua</td>
            <td>0</td>
        </tr>

        <tr>
            <td>18. Idadi ya watoto wenye utapiamlo wanaofuatiliwa</td>
            <td>0</td>
        </tr>

        <tr>
            <td colspan="16"
                class="text-bold text-center">TAARIFA ZA VIFO VYA WAZAZI NA WATOTO CHINI YA MIAKA 5 ZILIZOTOKEA KWENYE JAMII</td>
        </tr>

        <tr>
            <td>19. Idadi ya vifo vilivyotakana na uzazi</td>
            <%
                def deliveryOutCome = 0
                if (end_date && from_date) {
                    deliveryOutCome = PostDelivery.executeQuery("select id from PostDelivery where  outcome_type.code='CHAD23B2' and delivery_date  between '" + from_date + "' and '" + end_date + "' and  chaid.distric.region_id=:regionInstance", [regionInstance: regionInstance]).size();

                } else {
                    deliveryOutCome = PostDelivery.executeQuery("select id from PostDelivery where  outcome_type.code='CHAD23B2' and  chaid.distric.region_id=:regionInstance", [regionInstance: regionInstance]).size();

                }
            %>
            <td>${formatAmountString(name: (int) deliveryOutCome)}</td>
        </tr>

        <tr>
            <td>20. Idadi ya vifo vya watoto chini ya siku 28</td>
            <%
                def deliveryCondition = 0
                if (end_date && from_date) {
                    deliveryCondition = PostDelivery.executeQuery("select id from PostDelivery where  outcome_type.code='CHAD23B1' and  baby_condition.code='CHAD23C2' and " +

                            "delivery_date  between '" + from_date + "' and '" + end_date + "' and  chaid.distric.region_id=:regionInstance", [regionInstance: regionInstance]).size();

                } else {
                    deliveryCondition = PostDelivery.executeQuery("select id from PostDelivery where  outcome_type.code='CHAD23B1' and  baby_condition.code='CHAD23C2' and  chaid.distric.region_id=:regionInstance", [regionInstance: regionInstance]).size();

                }
            %>
            <td>${formatAmountString(name: (int) deliveryCondition)}</td>
        </tr>
    </tr>


        <tr>
            <td>21. Idadi ya vifo vya watoto mwezi 1 hadi miaka 5</td>
            <td>0</td>
        </tr>

        <tr>
            <td colspan="16"
                class="text-bold text-center">TAARIFA YA UKATILI WA KIJINSIA, MFUKO WA BIMA YA AFYA YA JAMII ULIOBORESHWA, MIKUTANO YA KAMATI YA AFYA YA KIJIJI NA MIKUTANO YA HADHARA ULIYOHUDHURIA</td>
        </tr>

        <tr>
            <td>22. Idadi ya kaya zilizohamasishwa kujiunga na mfuko wa Bima ya afya ya jamii ulioboreshwa (iCHF)</td>
            <td></td>
        </tr>


        <tr>
            <td>23. Idadi ya kaya zilizojiunga na mfuko wa Bima ya afya ya jamii ulioboreshwa (iCHF)</td>
            <td></td>
        </tr>


        <tr>
            <td>24. Idadi ya wateja waliofanyiwa ukatili wa kijinsia (Eleza aina ya ukatili aliofanyiwa na hatua zilizochukuliwa)</td>
            <td></td>
        </tr>

    </table>
</div>