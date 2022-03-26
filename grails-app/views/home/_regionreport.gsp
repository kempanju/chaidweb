<%@ page import="admin.DictionaryItem; chaid.CategoryAvailableChildren; chaid.AvailableMemberHouse; chaid.Household; view.HouseHoldStat; chaid.MkChaid; admin.District" %>
<table class="table">
    <thead>
    <tr class="active">
        <th>No</th>
        <th>Village Name</th>
        <th>Visits</th>
        <th>Households</th>
        <th>Population reached</th>
        <th>Women</th>
        <th>Men</th>
        <th>Adolescents Girls (10-19)</th>
        <th style="width25%; ">Adolescents Boys (10-19)</th>
        <th>Neonates</th>
        <th>Infants</th>
        <th>Pregnant Women</th>
        <th>Breastfeeding Women</th>
    </tr>
    </thead>
    <tbody>
    <%
        def countNo = 1;
        def totalHouseHold = 0;
        def totalMember = 0;
        def totalMemberMale = 0;
        def totalMemberWomen = 0;
        def totalWomenAgeBetweenNo = 0;
        def totalMaleAgeBetweenNo = 0;
        def totalNeonates = 0;
        def totalInfants = 0;
        def totalPregnantWomen = 0;
        def totalBreastFeedingWomen = 0;
        def totalVisit = 0;

    %>
    <g:each in="${District.findAllByRegion_idAndD_deleted(regionInstance, false, [order: 'asc', sort: 'name'])}"
            status="i" var="districtListInstance">
        <%
            def houseHoldNo = 0;
            def chadNo = 0;
            def visitedNewHouseHold = 0;
            def repeatHouse = 0;
            if (end_date && from_date) {
                chadNo = MkChaid.executeQuery("select id from MkChaid where distric=:district and deleted=false and arrival_time between '" + from_date + "' and '" + end_date + "'", [district: districtListInstance]).size()
                houseHoldNo = HouseHoldStat.executeQuery("select number_of_orders from HouseHoldStat where district_id=:district and chaid.arrival_time between '" + from_date + "' and '" + end_date + "' ", [district: districtListInstance]).size()
                visitedNewHouseHold = HouseHoldStat.executeQuery("select number_of_orders from HouseHoldStat where  district_id=:district and  chaid.arrival_time between '" + from_date + "' and '" + end_date + "' and number_of_orders=1", [district: districtListInstance]).size()

                repeatHouse = houseHoldNo - visitedNewHouseHold;
            } else {
                chadNo = MkChaid.executeQuery("select id from MkChaid where distric=:district and deleted=false ", [district: districtListInstance]).size()
                houseHoldNo = HouseHoldStat.executeQuery("select number_of_orders from HouseHoldStat where district_id=:district  ", [district: districtListInstance]).size()
                visitedNewHouseHold = HouseHoldStat.executeQuery("select number_of_orders from HouseHoldStat where  district_id=:district and  number_of_orders=1", [district: districtListInstance]).size()

                repeatHouse = houseHoldNo - visitedNewHouseHold;
            }
        %>

        <g:if test="${houseHoldNo > 0 || chadNo > 0}">

            <tr class="${(countNo % 2) == 0 ? 'even' : 'odd'} ">
                <td>${countNo}</td>
                <td><span class="text-bold">${districtListInstance.name}</span></td>
                <td class="info"><span>${formatAmountString(name: (int) chadNo)}</span></td>

                <%
                    totalHouseHold = totalHouseHold + houseHoldNo;
                    totalVisit = totalVisit + chadNo;
                %>
                <td>
                    <table>
                        <tr>
                            <td>Total</td><td>${houseHoldNo}</td>
                        </tr>
                        <tr>
                            <td>New</td><td>${visitedNewHouseHold}</td>
                        </tr>
                        <tr>
                            <td>Repeat</td><td>${repeatHouse}</td>
                        </tr>
                    </table>
                </td>

                <%
                    def houseHoldMember = 0
                    def houseHoldNoMember = 0
                    def visitedNewHouseHoldMember = 0
                    def repeatHouseMember = 0

                    if (end_date && from_date) {
                        houseHoldMember = MkChaid.executeQuery("select sum(household.total_members),sum(household.male_no),sum(household.female_no) from MkChaid  where   deleted=false and created_at between '" + from_date + "' and '" + end_date + "' and  distric=:district",[district: districtListInstance])

                        visitedNewHouseHoldMember = HouseHoldStat.executeQuery("select sum(household.total_members),sum(household.male_no),sum(household.female_no) from HouseHoldStat where district=:district and  household.created_at between '" + from_date + "' and '" + end_date + "' and number_of_orders=1 and  distric=:district", [district: districtListInstance])
                        // repeatHouseMember = houseHoldNoMember - visitedNewHouseHoldMember;


                    } else {
                        houseHoldMember = MkChaid.executeQuery("select sum(household.total_members),sum(household.male_no),sum(household.female_no) from MkChaid  where   deleted=false  and  distric=:district",[district: districtListInstance])

                        visitedNewHouseHoldMember = HouseHoldStat.executeQuery("select sum(household.total_members),sum(household.male_no),sum(household.female_no) from HouseHoldStat where district=:district and  number_of_orders=1 and  district=:district", [district: districtListInstance])

                    }

                %>
                <td>
                    <table>
                        <tr>
                            <td>Total</td><td>${houseHoldMember[0][0]}</td>
                        </tr>
                        <tr>
                            <td>New</td><td>${visitedNewHouseHoldMember[0][0]}</td>
                        </tr>
                        <tr>
                            <td>Repeat</td><td>${houseHoldMember[0][0]-visitedNewHouseHoldMember[0][0]}</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table>
                        <tr>
                            <td>Total</td><td>${houseHoldMember[0][1]}</td>
                        </tr>
                        <tr>
                            <td>New</td><td>${visitedNewHouseHoldMember[0][1]}</td>
                        </tr>
                        <tr>
                            <td>Repeat</td><td>${houseHoldMember[0][1]-visitedNewHouseHoldMember[0][1]}</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table>
                        <tr>
                            <td>Total</td><td>${houseHoldMember[0][2]}</td>
                        </tr>
                        <tr>
                            <td>New</td><td>${visitedNewHouseHoldMember[0][2]}</td>
                        </tr>
                        <tr>
                            <td>Repeat</td><td>${houseHoldMember[0][2]-visitedNewHouseHoldMember[0][2]}</td>
                        </tr>
                    </table>
                </td>


                <td>
                    <%
                        def womenAgeBetweenNo = 0;
                        if (end_date && from_date) {
                            womenAgeBetweenNo = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:district and arrival_time between '" + from_date + "' and '" + end_date + "'", [categoryType: admin.DictionaryItem.findByCode("CHAD17G"), district: districtListInstance])

                        } else {
                            womenAgeBetweenNo = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:district ", [categoryType: admin.DictionaryItem.findByCode("CHAD17G"), district: districtListInstance])

                        }

                    %>
                    ${womenAgeBetweenNo[0]}
                </td>


                <td>
                    <%
                        def maleAgeBetweenNo = 0;
                        if (end_date && from_date) {
                            maleAgeBetweenNo = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:district and arrival_time between '" + from_date + "' and '" + end_date + "' ", [categoryType: admin.DictionaryItem.findByCode("CHAD17H"), district: districtListInstance])
                        } else {
                            maleAgeBetweenNo = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:district ", [categoryType: admin.DictionaryItem.findByCode("CHAD17H"), district: districtListInstance])
                        }
                    %>
                    ${maleAgeBetweenNo[0]}
                </td>

                <td>
                    <%
                        def neonates = 0;
                        if (end_date && from_date) {
                            neonates = CategoryAvailableChildren.executeQuery("select sum(member_no) from CategoryAvailableChildren where categoryType=:categoryType  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.distric=:district and created_at between '" + from_date + "' and '" + end_date + "' ", [categoryType: admin.DictionaryItem.findByCode("CHAD17D"), district: districtListInstance])

                        } else {
                            neonates = CategoryAvailableChildren.executeQuery("select sum(member_no) from CategoryAvailableChildren where categoryType=:categoryType  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.distric=:district ", [categoryType: admin.DictionaryItem.findByCode("CHAD17D"), district: districtListInstance])

                        }
                    %>

                    ${neonates[0]}
                </td>

                <td>
                    <%
                        def infants = 0
                        if (end_date && from_date) {
                            infants = CategoryAvailableChildren.executeQuery("select sum(member_no)  from CategoryAvailableChildren where categoryType=:categoryType  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.distric=:district and created_at between '" + from_date + "' and '" + end_date + "'", [categoryType: admin.DictionaryItem.findByCode("CHAD17E"), district: districtListInstance])
                        } else {
                            infants = CategoryAvailableChildren.executeQuery("select sum(member_no)  from CategoryAvailableChildren where categoryType=:categoryType  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.distric=:district ", [categoryType: admin.DictionaryItem.findByCode("CHAD17E"), district: districtListInstance])

                        }
                    %>

                    ${infants[0]}
                </td>
                <td>

                    <%
                        def pregnantWomen = 0
                        if (end_date && from_date) {
                            pregnantWomen = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:district and arrival_time between '" + from_date + "' and '" + end_date + "'", [categoryType: admin.DictionaryItem.findByCode("CHAD17A"), district: districtListInstance])

                        } else {
                            pregnantWomen = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:district ", [categoryType: admin.DictionaryItem.findByCode("CHAD17A"), district: districtListInstance])

                        }

                    %>
                    ${pregnantWomen[0]}

                </td>
                <td>
                    <%
                        def breastFeedingWomen = 0;
                        if (end_date && from_date) {
                            breastFeedingWomen = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:district and arrival_time between '" + from_date + "' and '" + end_date + "'", [categoryType: admin.DictionaryItem.findByCode("CHAD17B"), district: districtListInstance])

                        } else {
                            breastFeedingWomen = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:district ", [categoryType: admin.DictionaryItem.findByCode("CHAD17B"), district: districtListInstance])
                        }
                    %>
                    ${breastFeedingWomen[0]}

                </td>

            </tr>

            <g:each in="${DictionaryItem.findAllByDictionary_id(admin.Dictionary.findByCode("CHAD4"))}"
                    var="visitDataInstance">

                <tr>
                    <td></td>
                    <td>${visitDataInstance.name}</td>

                    <%
                        def chadNoH = 0;
                        if (end_date && from_date) {
                            chadNoH = chaid.MkChaid.executeQuery("select id from MkChaid where distric=:district and deleted=false and visit_type=:visit_type and arrival_time between '" + from_date + "' and '" + end_date + "'", [district: districtListInstance, visit_type: visitDataInstance]).size()

                        } else {
                            chadNoH = chaid.MkChaid.countByDistricAndDeletedAndVisit_type(districtListInstance, false, visitDataInstance)
                        }
                    %>
                    <td>${chadNoH}</td>
                    <td></td>

                    <%
                        def houseHoldMemberH = 0;
                        if (end_date && from_date) {
                            houseHoldMemberH = Household.executeQuery("select sum(household.total_members),sum(household.male_no),sum(household.female_no) from MkChaid  where distric=:district and visit_type=:visit_type and deleted=false and created_at between '" + from_date + "' and '" + end_date + "'", [district: districtListInstance, visit_type: visitDataInstance])
                        } else {
                            houseHoldMemberH = Household.executeQuery("select sum(household.total_members),sum(household.male_no),sum(household.female_no) from MkChaid  where distric=:district and visit_type=:visit_type and deleted=false", [district: districtListInstance, visit_type: visitDataInstance])

                        }
                    %>
                    <td>${houseHoldMemberH[0][0]}</td>
                    <td>${houseHoldMemberH[0][1]}</td>
                    <td>${houseHoldMemberH[0][2]}</td>

                </tr>
            </g:each>
            <%
                if (houseHoldMember[0][0]) {
                    totalMember = totalMember + houseHoldMember[0][0];
                }

                if (houseHoldMember[0][2]) {
                    totalMemberMale = totalMemberMale + houseHoldMember[0][2];
                }

                if (houseHoldMember[0][1]) {
                    totalMemberWomen = totalMemberWomen + houseHoldMember[0][1];
                }
                if (womenAgeBetweenNo[0]) {
                    totalWomenAgeBetweenNo = totalWomenAgeBetweenNo + womenAgeBetweenNo[0];
                }
                if (maleAgeBetweenNo[0]) {
                    totalMaleAgeBetweenNo = totalMaleAgeBetweenNo + maleAgeBetweenNo[0];
                }
                if (neonates[0]) {
                    totalNeonates = totalNeonates + neonates[0];
                }
                if (infants[0]) {
                    totalInfants = totalInfants + infants[0]
                }
                if (pregnantWomen[0]) {
                    totalPregnantWomen = totalPregnantWomen + pregnantWomen[0];
                }
                if (breastFeedingWomen[0]) {
                    totalBreastFeedingWomen = totalBreastFeedingWomen + breastFeedingWomen[0];
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
        <td>${formatAmountString(name: (int) totalVisit)}</td>
        <td>${formatAmountString(name: (int) totalHouseHold)}</td>
        <td>${formatAmountString(name: (int) totalMember)}</td>
        <td>${formatAmountString(name: (int) totalMemberWomen)}</td>
        <td>${formatAmountString(name: (int) totalMemberMale)}</td>
        <td>${formatAmountString(name: (int) totalWomenAgeBetweenNo)}</td>
        <td>${formatAmountString(name: (int) totalMaleAgeBetweenNo)}</td>
        <td>${formatAmountString(name: (int) totalNeonates)}</td>
        <td>${formatAmountString(name: (int) totalInfants)}</td>
        <td>${formatAmountString(name: (int) totalPregnantWomen)}</td>
        <td>${formatAmountString(name: (int) totalBreastFeedingWomen)}</td>
    </tr>
    </tfoot>
</table>