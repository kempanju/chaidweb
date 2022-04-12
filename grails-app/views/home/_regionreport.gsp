<%@ page import="admin.Dictionary; admin.District; admin.DictionaryItem; chaid.CategoryAvailableChildren; chaid.AvailableMemberHouse; chaid.Household; view.HouseHoldStat; chaid.MkChaid" %>

<%
    def visitTypeInstance = DictionaryItem.findByCode("CHAD4A")
%>
<table class="table" border="1">
    <thead>
    <tr class="active">
        <th>No</th>
        <th>Name</th>
        <td></td>
        <th>Visits</th>
        <th>Households</th>
        <th>Reached</th>
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


        def totalHouseHoldNew = 0;
        def totalMemberNew = 0;
        def totalMemberMaleNew = 0;
        def totalMemberWomenNew = 0;
        def totalWomenAgeBetweenNoNew = 0;
        def totalMaleAgeBetweenNoNew = 0;
        def totalNeonatesNew = 0;
        def totalInfantsNew = 0;
        def totalPregnantWomenNew = 0;
        def totalBreastFeedingWomenNew = 0;

        def totalHouseHoldRepeat = 0;
        def totalMemberRepeat = 0;
        def totalMemberMaleRepeat = 0;
        def totalMemberWomenRepeat = 0;
        def totalWomenAgeBetweenNoRepeat = 0;
        def totalMaleAgeBetweenNoRepeat = 0;
        def totalNeonatesRepeat = 0;
        def totalInfantsRepeat= 0;
        def totalPregnantWomenRepeat= 0;
        def totalBreastFeedingWomenRepeat = 0;

    %>
    <g:each  in="${District.findAllByRegion_idAndD_deleted(regionInstance, false, [order: 'asc', sort: 'name'])}"
             status="i" var="districtListInstance">
        <%
            def houseHoldNo = 0;
            def chadNo = 0;
            def visitedNewHouseHold = 0;
            def repeatHouse = 0;
            if (end_date && from_date) {
                // repeatHouse =view.HouseHoldStat.executeQuery("select number_of_orders from HouseHoldStat where region_id=:region and  chaid.arrival_time between '"+from_date+"' and '"+end_date+"' and number_of_orders>1",[region:regionListInstance]).size()
                chadNo = MkChaid.executeQuery("select id from MkChaid where distric=:district and deleted=false and arrival_time between '" + from_date + "' and '" + end_date + "'", [district: districtListInstance]).size()


            } else {
                chadNo = MkChaid.executeQuery("select id from MkChaid where distric=:district and deleted=false ", [district: districtListInstance]).size()

            }
        %>

        <g:if test="${chadNo > 0}">

            <tr class="${(countNo % 2) == 0 ? 'even' : 'odd'} ">
                <td>${countNo}</td>
                <td><span class="text-bold">${districtListInstance?.name}</span></td>
                <td>
                    <table class="table" border="1">
                        <tr><td>New</td></tr>
                        <tr><td>Repeat</td></tr>
                        <tr><td>Total</td></tr>

                    </table>
                </td>
                <td class="info">
                    <table class="table" border="1">
                        <tr class="${(countNo % 2) == 0 ? 'even' : 'odd'} ">
                            <%
                                def chadNo1 = 0;
                                if (end_date && from_date) {
                                    chadNo1 = MkChaid.executeQuery("select id from MkChaid where distric=:district and deleted=false and arrival_time between '" + from_date + "' and '" + end_date + "' ", [district: districtListInstance]).size()

                                } else {
                                    chadNo1 = MkChaid.executeQuery("select id from MkChaid where distric=:district and deleted=false ", [district: districtListInstance]).size()

                                }
                                totalVisit = totalVisit+chadNo1

                            %>
                            <td class="info"><span>${formatAmountString(name: (int) chadNo1)}</span></td>
                        </tr>
                    </table>

                </td>


                <td>
                    <table class="table" border="1">
                        <%
                            def houseHoldNo1 = 0;
                            def totalHouseHoldNo = 0
                            if (end_date && from_date) {
                                houseHoldNo1 = MkChaid.executeQuery("select household.id from MkChaid where distric=:district and deleted=false and arrival_time between '" + from_date + "' and '" + end_date + "'  and visit_type=:visitTypeInstance and repeated=false", [district: districtListInstance, visitTypeInstance: visitTypeInstance]).size()

                            } else {
                                houseHoldNo1 = MkChaid.executeQuery("select household.id from MkChaid where distric=:district and deleted=false  and visit_type=:visitTypeInstance and repeated=false", [district: districtListInstance, visitTypeInstance: visitTypeInstance]).size()

                            }

                            def houseHoldNo2 = 0;
                            if (end_date && from_date) {
                                houseHoldNo2 = MkChaid.executeQuery("select household.id from MkChaid where distric=:district and deleted=false and arrival_time between '" + from_date + "' and '" + end_date + "'  and visit_type=:visitTypeInstance and repeated=true", [district: districtListInstance, visitTypeInstance: visitTypeInstance]).size()

                            } else {
                                houseHoldNo2 = MkChaid.executeQuery("select household.id from MkChaid where distric=:district and deleted=false  and visit_type=:visitTypeInstance and repeated=true", [district: districtListInstance, visitTypeInstance: visitTypeInstance]).size()

                            }
                            totalHouseHoldNo = houseHoldNo1 + houseHoldNo2;

                            totalHouseHold = totalHouseHold+totalHouseHoldNo

                            totalHouseHoldNew = totalHouseHoldNew + houseHoldNo1
                            totalHouseHoldRepeat = totalHouseHoldRepeat + houseHoldNo2

                        %>
                        <tr><td>${formatAmountString(name: (int) houseHoldNo1)}</td></tr>
                        <tr><td>${formatAmountString(name: (int) houseHoldNo2)}</td></tr>
                        <tr><td>${formatAmountString(name: (int) totalHouseHoldNo)}</td></tr>

                    </table>
                </td>


                <td colspan="3">
                    <table class="table" border="1">
                        <%
                            def houseHoldMember = 0
                            def houseHoldMemberTotal = 0

                            def houseHoldMale = 0
                            def houseHoldMaleFemale = 0

                            if (end_date && from_date) {
                                houseHoldMember = MkChaid.executeQuery("select sum(household.total_members),sum(household.male_no),sum(household.female_no) from MkChaid  where   deleted=false and created_at between '" + from_date + "' and '" + end_date + "' and distric=:district and visit_type=:visitTypeInstance and repeated=false", [district: districtListInstance, visitTypeInstance: visitTypeInstance])

                                // repeatHouseMember = houseHoldNoMember - visitedNewHouseHoldMember;


                            } else {
                                houseHoldMember = MkChaid.executeQuery("select sum(household.total_members),sum(household.male_no),sum(household.female_no) from MkChaid  where  deleted=false and visit_type=:visitTypeInstance and repeated=false and distric=:district", [visitTypeInstance: visitTypeInstance, district: districtListInstance])

                            }

                            if (houseHoldMember[0][0]) {
                                houseHoldMemberTotal = houseHoldMember[0][0]
                            }

                            if (houseHoldMember[0][1]) {
                                houseHoldMale = houseHoldMember[0][1]
                            }
                            if (houseHoldMember[0][2]) {
                                houseHoldMaleFemale = houseHoldMember[0][2]
                            }


                            def houseHoldMember1 = 0
                            def houseHoldMemberTotal1 = 0

                            def houseHoldMale1 = 0
                            def houseHoldMaleFemale1 = 0

                            if (end_date && from_date) {
                                houseHoldMember1 = MkChaid.executeQuery("select sum(household.total_members),sum(household.male_no),sum(household.female_no) from MkChaid  where   deleted=true and created_at between '" + from_date + "' and '" + end_date + "' and distric=:district and visit_type=:visitTypeInstance and repeated=true", [district: districtListInstance, visitTypeInstance: visitTypeInstance])

                                // repeatHouseMember = houseHoldNoMember - visitedNewHouseHoldMember;


                            } else {
                                houseHoldMember1 = MkChaid.executeQuery("select sum(household.total_members),sum(household.male_no),sum(household.female_no) from MkChaid  where  deleted=false and visit_type=:visitTypeInstance and repeated=true and distric=:district", [visitTypeInstance: visitTypeInstance, district: districtListInstance])

                            }

                            if (houseHoldMember1[0][0]) {
                                houseHoldMemberTotal1 = houseHoldMember1[0][0]
                            }

                            if (houseHoldMember1[0][1]) {
                                houseHoldMale1 = houseHoldMember1[0][1]
                            }
                            if (houseHoldMember1[0][2]) {
                                houseHoldMaleFemale1 = houseHoldMember1[0][2]
                            }


                            def houseHoldMemberTotal2 = houseHoldMemberTotal1 + houseHoldMemberTotal

                            totalMember = totalMember + houseHoldMemberTotal2

                            totalMemberNew = totalMemberNew+ houseHoldMemberTotal

                            totalMemberRepeat = totalMemberRepeat+ houseHoldMemberTotal1

                            def houseHoldMale2 = houseHoldMale1 + houseHoldMale

                            totalMemberMale = totalMemberMale + houseHoldMale2
                            totalMemberMaleNew = totalMemberMaleNew + houseHoldMale
                            totalMemberMaleRepeat =  totalMemberMaleRepeat + houseHoldMale1


                            def houseHoldMaleFemale2 = houseHoldMaleFemale1 + houseHoldMaleFemale
                            totalMemberWomen = totalMemberWomen + houseHoldMaleFemale2

                            totalMemberWomenNew = totalMemberWomenNew + houseHoldMaleFemale
                            totalMemberWomenRepeat = totalMemberWomenRepeat + houseHoldMaleFemale1


                        %>

                        <tr><td>${formatAmountString(name: (int) houseHoldMemberTotal)}</td>
                            <td>${formatAmountString(name: (int) houseHoldMale)}</td>
                            <td>${formatAmountString(name: (int) houseHoldMaleFemale)}</td></tr>

                        <tr><td>${formatAmountString(name: (int) houseHoldMemberTotal1)}</td>
                            <td>${formatAmountString(name: (int) houseHoldMale1)}</td>
                            <td>${formatAmountString(name: (int) houseHoldMaleFemale1)}</td></tr>

                        <tr><td>${formatAmountString(name: (int) houseHoldMemberTotal2)}</td>
                            <td>${formatAmountString(name: (int) houseHoldMale2)}</td>
                            <td>${formatAmountString(name: (int) houseHoldMaleFemale2)}</td></tr>

                    </table>
                </td>

                <td>
                    <table class="table" border="1">
                        <%
                            def womenAgeBetweenNo = 0;
                            def womenAgeBetweenNo1 = 0;

                            if (end_date && from_date) {
                                womenAgeBetweenNo = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:district and arrival_time between '" + from_date + "' and '" + end_date + "' and chaid.visit_type=:visitTypeInstance and chaid.repeated=false", [categoryType: DictionaryItem.findByCode("CHAD17G"), district: districtListInstance, visitTypeInstance: visitTypeInstance])

                            } else {
                                womenAgeBetweenNo = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:district and chaid.visit_type=:visitTypeInstance and chaid.repeated=false", [categoryType: DictionaryItem.findByCode("CHAD17G"),district: districtListInstance, visitTypeInstance: visitTypeInstance])

                            }
                            if (womenAgeBetweenNo[0]) {
                                womenAgeBetweenNo1 = womenAgeBetweenNo[0]
                            }


                            def womenAgeBetweenNo2 = 0;
                            def womenAgeBetweenNoTotal = 0;


                            if (end_date && from_date) {
                                womenAgeBetweenNo2 = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:district and arrival_time between '" + from_date + "' and '" + end_date + "' and chaid.visit_type=:visitTypeInstance and chaid.repeated=true", [categoryType: DictionaryItem.findByCode("CHAD17G"), district: districtListInstance, visitTypeInstance: visitTypeInstance])

                            } else {
                                womenAgeBetweenNo2 = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:district and chaid.visit_type=:visitTypeInstance and chaid.repeated=true", [categoryType: DictionaryItem.findByCode("CHAD17G"), district: districtListInstance, visitTypeInstance: visitTypeInstance])

                            }
                            if (womenAgeBetweenNo2[0]) {
                                womenAgeBetweenNoTotal = womenAgeBetweenNo2[0]
                            }

                            def totalWABN = womenAgeBetweenNo1 + womenAgeBetweenNoTotal
                            totalWomenAgeBetweenNo = totalWomenAgeBetweenNo + totalWABN

                            totalWomenAgeBetweenNoNew = totalWomenAgeBetweenNoNew + womenAgeBetweenNo1
                            totalWomenAgeBetweenNoRepeat = totalWomenAgeBetweenNoRepeat + womenAgeBetweenNoTotal


                        %>
                        <tr><td>${formatAmountString(name: (int) womenAgeBetweenNo1)}</td></tr>
                        <tr><td>${formatAmountString(name: (int) womenAgeBetweenNoTotal)}</td></tr>
                        <tr><td>${formatAmountString(name: (int) totalWABN)}</td></tr>

                    </table>
                </td>


                <td>

                    <table class="table" border="1">

                        <%
                            def maleAgeBetweenNo = 0;
                            def maleAgeBetweenNo1 = 0;

                            if (end_date && from_date) {
                                maleAgeBetweenNo = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:district and arrival_time between '" + from_date + "' and '" + end_date + "' and chaid.visit_type=:visitTypeInstance and chaid.repeated=false", [categoryType: DictionaryItem.findByCode("CHAD17H"), district: districtListInstance, visitTypeInstance: visitTypeInstance])
                            } else {
                                maleAgeBetweenNo = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:district and chaid.visit_type=:visitTypeInstance and chaid.repeated=false", [categoryType: DictionaryItem.findByCode("CHAD17H"), district: districtListInstance, visitTypeInstance: visitTypeInstance])
                            }

                            if (maleAgeBetweenNo[0]) {
                                maleAgeBetweenNo1 = maleAgeBetweenNo[0]
                            }

                            def maleAgeBetweenInstance = 0;
                            def maleAgeBetweenNo11 = 0;

                            if (end_date && from_date) {
                                maleAgeBetweenInstance = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:district and arrival_time between '" + from_date + "' and '" + end_date + "' and chaid.visit_type=:visitTypeInstance and chaid.repeated=true", [categoryType: DictionaryItem.findByCode("CHAD17H"), district: districtListInstance, visitTypeInstance: visitTypeInstance])
                            } else {
                                maleAgeBetweenInstance = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:district and chaid.visit_type=:visitTypeInstance and chaid.repeated=true", [categoryType: DictionaryItem.findByCode("CHAD17H"), district: districtListInstance, visitTypeInstance: visitTypeInstance])
                            }

                            if (maleAgeBetweenInstance[0]) {
                                maleAgeBetweenNo11 = maleAgeBetweenInstance[0]
                            }

                            def maleAgeBetweenInstanceTotal = maleAgeBetweenNo1 + maleAgeBetweenNo11
                            totalMaleAgeBetweenNo = totalMaleAgeBetweenNo + maleAgeBetweenInstanceTotal

                            totalMaleAgeBetweenNoNew = totalMaleAgeBetweenNoNew + maleAgeBetweenNo1
                            totalMaleAgeBetweenNoRepeat = totalMaleAgeBetweenNoRepeat + maleAgeBetweenNo11


                        %>

                        <tr><td>${formatAmountString(name: (int) maleAgeBetweenNo1)}</td></tr>
                        <tr><td>${formatAmountString(name: (int) maleAgeBetweenNo11)}</td></tr>
                        <tr><td>${formatAmountString(name: (int) maleAgeBetweenInstanceTotal)}</td></tr>

                    </table>
                </td>

                <td>

                    <table class="table" border="1">

                        <%
                            def neonatesInstance = 0;
                            def neonates1 = 0;

                            if (end_date && from_date) {
                                neonatesInstance = CategoryAvailableChildren.executeQuery("select sum(member_no) from CategoryAvailableChildren where categoryType=:categoryType  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.distric=:district and created_at between '" + from_date + "' and '" + end_date + "'  and availableMemberHouse.chaid.visit_type=:visitTypeInstance and availableMemberHouse.chaid.repeated=false", [categoryType: DictionaryItem.findByCode("CHAD17D"), district: districtListInstance, visitTypeInstance: visitTypeInstance])

                            } else {
                                neonatesInstance = CategoryAvailableChildren.executeQuery("select sum(member_no) from CategoryAvailableChildren where categoryType=:categoryType  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.distric=:district  and availableMemberHouse.chaid.visit_type=:visitTypeInstance and availableMemberHouse.chaid.repeated=false", [categoryType: DictionaryItem.findByCode("CHAD17D"), district: districtListInstance, visitTypeInstance: visitTypeInstance])

                            }

                            if (neonatesInstance[0]) {
                                neonates1 = neonatesInstance[0]
                            }


                            def neonatesInstance1 = 0;
                            def neonates11 = 0;

                            if (end_date && from_date) {
                                neonatesInstance1 = CategoryAvailableChildren.executeQuery("select sum(member_no) from CategoryAvailableChildren where categoryType=:categoryType  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.distric=:district and created_at between '" + from_date + "' and '" + end_date + "'  and availableMemberHouse.chaid.visit_type=:visitTypeInstance and availableMemberHouse.chaid.repeated=true", [categoryType: DictionaryItem.findByCode("CHAD17D"), district: districtListInstance, visitTypeInstance: visitTypeInstance])

                            } else {
                                neonatesInstance1 = CategoryAvailableChildren.executeQuery("select sum(member_no) from CategoryAvailableChildren where categoryType=:categoryType  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.distric=:district  and availableMemberHouse.chaid.visit_type=:visitTypeInstance and availableMemberHouse.chaid.repeated=true", [categoryType: DictionaryItem.findByCode("CHAD17D"), district: districtListInstance, visitTypeInstance: visitTypeInstance])

                            }

                            if (neonatesInstance1[0]) {
                                neonates11 = neonatesInstance1[0]
                            }

                            def totalNeonates1 = neonates1 + neonates11
                            totalNeonates = totalNeonates1 + totalNeonates

                            totalNeonatesNew = totalNeonatesNew + neonates1
                            totalNeonatesRepeat = totalNeonatesRepeat + neonates11


                        %>
                        <tr><td>${formatAmountString(name: (int) neonates1)}</td></tr>
                        <tr><td>${formatAmountString(name: (int) neonates11)}</td></tr>
                        <tr><td>${formatAmountString(name: (int) totalNeonates1)}</td></tr>

                    </table>

                </td>

                <td>

                    <table class="table" border="1">

                        <%
                            def infantsInstance = 0
                            def infants1 = 0

                            if (end_date && from_date) {
                                infantsInstance = CategoryAvailableChildren.executeQuery("select sum(member_no)  from CategoryAvailableChildren where categoryType=:categoryType  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.distric=:district and created_at between '" + from_date + "' and '" + end_date + "'  and availableMemberHouse.chaid.visit_type=:visitTypeInstance and availableMemberHouse.chaid.repeated=false", [categoryType: DictionaryItem.findByCode("CHAD17E"), district: districtListInstance, visitTypeInstance: visitTypeInstance])
                            } else {
                                infantsInstance = CategoryAvailableChildren.executeQuery("select sum(member_no)  from CategoryAvailableChildren where categoryType=:categoryType  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.distric=:district and availableMemberHouse.chaid.visit_type=:visitTypeInstance and availableMemberHouse.chaid.repeated=false", [categoryType: DictionaryItem.findByCode("CHAD17E"), district: districtListInstance, visitTypeInstance: visitTypeInstance])

                            }

                            if (infantsInstance[0]) {
                                infants1 = infantsInstance[0]
                            }


                            def infantsInstance1 = 0
                            def infants11 = 0

                            if (end_date && from_date) {
                                infantsInstance1 = CategoryAvailableChildren.executeQuery("select sum(member_no)  from CategoryAvailableChildren where categoryType=:categoryType  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.distric=:district and created_at between '" + from_date + "' and '" + end_date + "'  and availableMemberHouse.chaid.visit_type=:visitTypeInstance and availableMemberHouse.chaid.repeated=true", [categoryType: DictionaryItem.findByCode("CHAD17E"), district: districtListInstance, visitTypeInstance: visitTypeInstance])
                            } else {
                                infantsInstance1 = CategoryAvailableChildren.executeQuery("select sum(member_no)  from CategoryAvailableChildren where categoryType=:categoryType  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.distric=:district and availableMemberHouse.chaid.visit_type=:visitTypeInstance and availableMemberHouse.chaid.repeated=true", [categoryType: DictionaryItem.findByCode("CHAD17E"), district: districtListInstance, visitTypeInstance: visitTypeInstance])

                            }

                            if (infantsInstance1[0]) {
                                infants11 = infantsInstance1[0]
                            }

                            def totalInfantsInstance = infants1 + infants11

                            totalInfants = totalInfantsInstance + totalInfants

                            totalInfantsNew = totalInfantsNew + infants1

                            totalInfantsRepeat = totalInfantsRepeat + infants11

                        %>
                        <tr><td>${formatAmountString(name: (int) infants1)}</td></tr>

                        <tr><td>${formatAmountString(name: (int) infants11)}</td></tr>

                        <tr><td>${formatAmountString(name: (int) totalInfantsInstance)}</td></tr>

                    </table>

                </td>
                <td>

                    <table class="table" border="1">

                        <%
                            def pregnantWomenInstance = 0
                            def pregnantWomen1 = 0

                            if (end_date && from_date) {
                                pregnantWomenInstance = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:district and arrival_time between '" + from_date + "' and '" + end_date + "' and  chaid.visit_type=:visitTypeInstance and chaid.repeated=false", [categoryType: DictionaryItem.findByCode("CHAD17A"), district: districtListInstance, visitTypeInstance: visitTypeInstance])

                            } else {
                                pregnantWomenInstance = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:district and chaid.visit_type=:visitTypeInstance and chaid.repeated=false", [categoryType: DictionaryItem.findByCode("CHAD17A"), district: districtListInstance, visitTypeInstance: visitTypeInstance])

                            }
                            if (pregnantWomenInstance[0]) {
                                pregnantWomen1 = pregnantWomenInstance[0]
                            }


                            def pregnantWomenInstance1 = 0
                            def pregnantWomen11 = 0

                            if (end_date && from_date) {
                                pregnantWomenInstance1 = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:district and arrival_time between '" + from_date + "' and '" + end_date + "' and  chaid.visit_type=:visitTypeInstance and chaid.repeated=true", [categoryType: DictionaryItem.findByCode("CHAD17A"), district: districtListInstance, visitTypeInstance: visitTypeInstance])

                            } else {
                                pregnantWomenInstance1 = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:district and chaid.visit_type=:visitTypeInstance and chaid.repeated=true", [categoryType: DictionaryItem.findByCode("CHAD17A"), district: districtListInstance, visitTypeInstance: visitTypeInstance])

                            }
                            if (pregnantWomenInstance1[0]) {
                                pregnantWomen11 = pregnantWomenInstance1[0]
                            }
                            def totalWomenInstance = pregnantWomen11 + pregnantWomen1

                            totalPregnantWomen = totalPregnantWomen + totalWomenInstance

                            totalPregnantWomenNew = totalPregnantWomenNew + pregnantWomen1
                            totalPregnantWomenRepeat = totalPregnantWomenRepeat + pregnantWomen11

                        %>
                        <tr><td>${formatAmountString(name: (int) pregnantWomen1)}</td></tr>
                        <tr><td>${formatAmountString(name: (int) pregnantWomen11)}</td></tr>
                        <tr><td>${formatAmountString(name: (int) totalWomenInstance)}</td></tr>

                    </table>

                </td>
                <td>

                    <table class="table" border="1">
                        <%
                            def breastFeedingWomenInstance = 0;
                            def breastFeedingWomen1 = 0;

                            if (end_date && from_date) {
                                breastFeedingWomenInstance = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:district and arrival_time between '" + from_date + "' and '" + end_date + "' and chaid.visit_type=:visitTypeInstance and chaid.repeated=false", [categoryType: DictionaryItem.findByCode("CHAD17B"), district: districtListInstance, visitTypeInstance: visitTypeInstance])

                            } else {
                                breastFeedingWomenInstance = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:district and chaid.visit_type=:visitTypeInstance and chaid.repeated=false", [categoryType: DictionaryItem.findByCode("CHAD17B"), district: districtListInstance, visitTypeInstance: visitTypeInstance])
                            }

                            if (breastFeedingWomenInstance[0]) {
                                breastFeedingWomen1 = breastFeedingWomenInstance[0]
                            }

                            def breastFeedingWomenInstance1 = 0;
                            def breastFeedingWomen11 = 0;

                            if (end_date && from_date) {
                                breastFeedingWomenInstance1 = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:district and arrival_time between '" + from_date + "' and '" + end_date + "' and chaid.visit_type=:visitTypeInstance and chaid.repeated=true", [categoryType: DictionaryItem.findByCode("CHAD17B"), district: districtListInstance, visitTypeInstance: visitTypeInstance])

                            } else {
                                breastFeedingWomenInstance1 = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:district and chaid.visit_type=:visitTypeInstance and chaid.repeated=true", [categoryType: DictionaryItem.findByCode("CHAD17B"), district: districtListInstance, visitTypeInstance: visitTypeInstance])
                            }

                            if (breastFeedingWomenInstance1[0]) {
                                breastFeedingWomen11 = breastFeedingWomenInstance1[0]
                            }

                            def breastFeedingWomenTotal2 = breastFeedingWomen11 + breastFeedingWomen1
                            totalBreastFeedingWomen = totalBreastFeedingWomen + breastFeedingWomenTotal2

                            totalBreastFeedingWomenNew = totalBreastFeedingWomenNew + breastFeedingWomen1
                            totalBreastFeedingWomenRepeat = totalBreastFeedingWomenRepeat + breastFeedingWomen11


                        %>
                        <tr><td>${formatAmountString(name: (int) breastFeedingWomen1)}</td></tr>
                        <tr><td>${formatAmountString(name: (int) breastFeedingWomen11)}</td></tr>
                        <tr><td>${formatAmountString(name: (int) breastFeedingWomenTotal2)}</td></tr>

                    </table>

                </td>

            </tr>

            <g:each in="${DictionaryItem.findAllByDictionary_id(Dictionary.findByCode("CHAD4"))}"
                    var="visitDataInstance">

                <tr>
                    <td></td>

                    <td>${visitDataInstance.name}</td>
                    <td></td>
                    <%
                        def chadNoH = 0;
                        if (end_date && from_date) {
                            chadNoH = MkChaid.executeQuery("select id from MkChaid where  deleted=false and visit_type=:visit_type and distric=:district and arrival_time between '" + from_date + "' and '" + end_date + "'", [visit_type: visitDataInstance, district: districtListInstance]).size()

                        } else {
                            chadNoH = MkChaid.executeQuery("select id from MkChaid where  deleted=false and visit_type=:visit_type and distric=:district ", [visit_type: visitDataInstance, district: districtListInstance]).size()

                        }
                    %>
                    <td>${formatAmountString(name: (int) chadNoH)}</td>
                    <td></td>

                    <%
                        def houseHoldMemberH = 0;
                        def totalPopulation = 0
                        def maleTotal = 0
                        def femaleTotal = 0

                        if (end_date && from_date) {
                            houseHoldMemberH = MkChaid.executeQuery("select sum(household.total_members),sum(household.male_no),sum(household.female_no) from MkChaid  where  visit_type=:visit_type and distric=:district and deleted=false  and created_at between '" + from_date + "' and '" + end_date + "'", [visit_type: visitDataInstance, district: districtListInstance])
                        } else {
                            houseHoldMemberH = MkChaid.executeQuery("select sum(household.total_members),sum(household.male_no),sum(household.female_no) from MkChaid  where  visit_type=:visit_type and distric=:district and deleted=false", [visit_type: visitDataInstance, district: districtListInstance])

                        }
                        if (houseHoldMemberH[0][0]) {
                            totalPopulation = houseHoldMemberH[0][0]
                        }

                        if (houseHoldMemberH[0][1]) {
                            maleTotal = houseHoldMemberH[0][1]
                        }

                        if (houseHoldMemberH[0][2]) {
                            femaleTotal = houseHoldMemberH[0][2]
                        }

                    %>
                    <td>${formatAmountString(name: (int) maleTotal)}</td>
                    <td>${formatAmountString(name: (int) femaleTotal)}</td>
                    <td>${formatAmountString(name: (int) totalPopulation)}</td>

                </tr>
            </g:each>
            <%
                /*   if (houseHoldMember[0][0]) {
                       totalMember = totalMember + houseHoldMember[0][0];
                   }

                   if (houseHoldMember[0][2]) {
                       totalMemberMale = totalMemberMale + houseHoldMember[0][2];
                   }

                   if (houseHoldMember[0][1]) {
                       totalMemberWomen = totalMemberMale + houseHoldMember[0][1];
                   }*/
                /* if (womenAgeBetweenNo[0]) {
                     totalWomenAgeBetweenNo = totalWomenAgeBetweenNo + womenAgeBetweenNo[0];
                 }*/
                /* if (maleAgeBetweenNo[0]) {
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
                 }*/
                countNo++;
            %>
        </g:if>
    </g:each>
    </tbody>
    <tfoot>
    <tr class="success">
        <td></td>
        <td></td>
        <td class="semi-bold">New</td>
        <td></td>
        <td>${formatAmountString(name: (int) totalHouseHoldNew)}</td>
        <td>${formatAmountString(name: (int) totalMemberNew)}</td>
        <td>${formatAmountString(name: (int) totalMemberWomenNew)}</td>
        <td>${formatAmountString(name: (int) totalMemberMaleNew)}</td>
        <td>${formatAmountString(name: (int) totalWomenAgeBetweenNoNew)}</td>
        <td>${formatAmountString(name: (int) totalMaleAgeBetweenNoNew)}</td>
        <td>${formatAmountString(name: (int) totalNeonatesNew)}</td>
        <td>${formatAmountString(name: (int) totalInfantsNew)}</td>
        <td>${formatAmountString(name: (int) totalPregnantWomenNew)}</td>
        <td>${formatAmountString(name: (int) totalBreastFeedingWomenNew)}</td>
    </tr>
    <tr class="success">
        <td></td>
        <td></td>
        <td class="semi-bold">Repeat</td>
        <td></td>
        <td>${formatAmountString(name: (int) totalHouseHoldRepeat)}</td>
        <td>${formatAmountString(name: (int) totalMemberRepeat)}</td>
        <td>${formatAmountString(name: (int) totalMemberWomenRepeat)}</td>
        <td>${formatAmountString(name: (int) totalMemberMaleRepeat)}</td>
        <td>${formatAmountString(name: (int) totalWomenAgeBetweenNoRepeat)}</td>
        <td>${formatAmountString(name: (int) totalMaleAgeBetweenNoRepeat)}</td>
        <td>${formatAmountString(name: (int) totalNeonatesRepeat)}</td>
        <td>${formatAmountString(name: (int) totalInfantsRepeat)}</td>
        <td>${formatAmountString(name: (int) totalPregnantWomenRepeat)}</td>
        <td>${formatAmountString(name: (int) totalBreastFeedingWomenRepeat)}</td>
    </tr>
    <tr class="success">
        <td></td>
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