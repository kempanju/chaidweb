<%@ page import="chaid.CategoryAvailableChildren;view.HouseHoldStat; chaid.AvailableMemberHouse; chaid.Household; chaid.MkChaid; admin.Street" %>
<table class="table" border="1">
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
    <g:each in="${Street.findAllByDistrict_id(districtInstance, [order: 'asc', sort: 'name'])}" status="i"
            var="villageListInstance">
        <%

            def houseHoldNo = 0;
            def chadNo = 0;
            def visitedNewHouseHold = 0;
            def repeatHouse = 0;
            if (end_date && from_date) {
                chadNo = MkChaid.executeQuery("select id from MkChaid where street=:village and deleted=false and arrival_time between '" + from_date + "' and '" + end_date + "'", [village: villageListInstance]).size()

                visitedNewHouseHold = Household.executeQuery("select id from Household where village_id=:village and deleted=false and created_at between '" + from_date + "' and '" + end_date + "'", [village: villageListInstance]).size()
                houseHoldNo = MkChaid.executeQuery("select household.id from MkChaid where street=:village and deleted=false and arrival_time between '" + from_date + "' and '" + end_date + "' group by household.id", [village: villageListInstance]).size()

                repeatHouse = houseHoldNo - visitedNewHouseHold;
            } else {
                chadNo = MkChaid.countByStreetAndDeleted(villageListInstance, false)

                visitedNewHouseHold = Household.executeQuery("select id from Household where village_id=:village and deleted=false ", [village: villageListInstance]).size()
                houseHoldNo = MkChaid.executeQuery("select household.id from MkChaid where street=:village and deleted=false  group by household.id", [village: villageListInstance]).size()

                repeatHouse = houseHoldNo - visitedNewHouseHold;
            }
        %>

        <g:if test="${houseHoldNo > 0 || chadNo > 0}">

            <tr class="${(countNo % 2) == 0 ? 'even' : 'odd'} ">
                <td>${countNo}</td>
                <td><span class="text-bold">${villageListInstance.name}</span></td>
                <td class="info"><span>${chadNo}</span></td>

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
                        houseHoldMember = MkChaid.executeQuery("select sum(household.total_members),sum(household.male_no),sum(household.female_no) from MkChaid  where   deleted=false and created_at between '" + from_date + "' and '" + end_date + "' and  village_id=:street",[street: villageListInstance])

                        visitedNewHouseHoldMember = HouseHoldStat.executeQuery("select sum(household.total_members),sum(household.male_no),sum(household.female_no) from HouseHoldStat where village_id=:street and  household.created_at between '" + from_date + "' and '" + end_date + "' and number_of_orders=1 and  village_id=:street", [street: villageListInstance])
                        // repeatHouseMember = houseHoldNoMember - visitedNewHouseHoldMember;


                    } else {
                        houseHoldMember = MkChaid.executeQuery("select sum(household.total_members),sum(household.male_no),sum(household.female_no) from MkChaid  where   deleted=false  and  village_id=:street",[street: villageListInstance])

                        visitedNewHouseHoldMember = HouseHoldStat.executeQuery("select sum(household.total_members),sum(household.male_no),sum(household.female_no) from HouseHoldStat where street=:street and  number_of_orders=1 and   village_id=:street", [street: villageListInstance])

                    }
                    def itemNo3 =0
                    try{
                        itemNo3 = houseHoldMember[0][0]-visitedNewHouseHoldMember[0][0]
                    }catch (Exception e){

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
                            <td>Repeat</td><td>${}</td>
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
                        <%
                        def itemNo =0
                            try{
                                itemNo = houseHoldMember[0][1] - visitedNewHouseHoldMember[0][1]

                            }catch(Exception e){

                            }
                        %>
                        <tr>
                            <td>Repeat</td><td>${itemNo}</td>
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
                            <%
                                def itemNo1 =0
                                try{
                                    itemNo1 = houseHoldMember[0][2]-visitedNewHouseHoldMember[0][2]

                                }catch(Exception e){

                                }
                            %>
                            <td>Repeat</td><td>${itemNo1}</td>
                        </tr>
                    </table>
                </td>




                <td>
                    <%
                        def womenAgeBetweenNo = 0;
                        if (end_date && from_date) {
                            womenAgeBetweenNo = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.street=:village and arrival_time between '" + from_date + "' and '" + end_date + "'", [categoryType: admin.DictionaryItem.findByCode("CHAD17G"), village: villageListInstance])

                        } else {
                            womenAgeBetweenNo = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.street=:village ", [categoryType: admin.DictionaryItem.findByCode("CHAD17G"), village: villageListInstance])

                        }
                    %>
                    ${womenAgeBetweenNo[0]}
                </td>


                <td>
                    <%

                        def maleAgeBetweenNo = 0;
                        if (end_date && from_date) {
                            maleAgeBetweenNo = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.street=:village and arrival_time between '" + from_date + "' and '" + end_date + "' ", [categoryType: admin.DictionaryItem.findByCode("CHAD17H"), village: villageListInstance])
                        } else {
                            maleAgeBetweenNo = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.street=:village ", [categoryType: admin.DictionaryItem.findByCode("CHAD17H"), village: villageListInstance])

                        }
                    %>
                    ${maleAgeBetweenNo[0]}
                </td>

                <td>
                    <%
                        def neonates = 0;
                        if (end_date && from_date) {
                            neonates = CategoryAvailableChildren.executeQuery("select sum(member_no) from CategoryAvailableChildren where categoryType=:categoryType  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.street=:village and created_at between '" + from_date + "' and '" + end_date + "' ", [categoryType: admin.DictionaryItem.findByCode("CHAD17D"), village: villageListInstance])

                        } else {
                            neonates = CategoryAvailableChildren.executeQuery("select sum(member_no) from CategoryAvailableChildren where categoryType=:categoryType  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.street=:village ", [categoryType: admin.DictionaryItem.findByCode("CHAD17D"), village: villageListInstance])

                        }

                    %>

                    ${neonates[0]}
                </td>

                <td>
                    <%
                        def infants = 0
                        if (end_date && from_date) {
                            infants = CategoryAvailableChildren.executeQuery("select sum(member_no)  from CategoryAvailableChildren where categoryType=:categoryType  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.street=:village and created_at between '" + from_date + "' and '" + end_date + "'", [categoryType: admin.DictionaryItem.findByCode("CHAD17E"), village: villageListInstance])
                        } else {
                            infants = CategoryAvailableChildren.executeQuery("select sum(member_no)  from CategoryAvailableChildren where categoryType=:categoryType  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.street=:village ", [categoryType: admin.DictionaryItem.findByCode("CHAD17E"), village: villageListInstance])

                        }

                    %>

                    ${infants[0]}
                </td>
                <td>

                    <%

                        def pregnantWomen = 0
                        if (end_date && from_date) {
                            pregnantWomen = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.street=:village and arrival_time between '" + from_date + "' and '" + end_date + "'", [categoryType: admin.DictionaryItem.findByCode("CHAD17A"), village: villageListInstance])

                        } else {
                            pregnantWomen = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.street=:village ", [categoryType: admin.DictionaryItem.findByCode("CHAD17A"), village: villageListInstance])

                        }



                    %>
                    ${pregnantWomen[0]}

                </td>
                <td>
                    <%
                        def breastFeedingWomen = 0;
                        if (end_date && from_date) {
                            breastFeedingWomen = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.street=:village and arrival_time between '" + from_date + "' and '" + end_date + "'", [categoryType: admin.DictionaryItem.findByCode("CHAD17B"), village: villageListInstance])

                        } else {
                            breastFeedingWomen = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.street=:village ", [categoryType: admin.DictionaryItem.findByCode("CHAD17B"), village: villageListInstance])

                        }
                    %>
                    ${breastFeedingWomen[0]}

                </td>

            </tr>
            <%
                if (houseHoldMember[0][0]) {
                    totalMember = totalMember + houseHoldMember[0][0];
                }

                if (houseHoldMember[0][2]) {
                    totalMemberMale = totalMemberMale + houseHoldMember[0][2];
                }

                if (houseHoldMember[0][1]) {
                    totalMemberWomen = totalMemberMale + houseHoldMember[0][1];
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