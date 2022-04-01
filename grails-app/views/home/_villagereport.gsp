<%@ page import="admin.Dictionary; admin.Street; admin.DictionaryItem; chaid.CategoryAvailableChildren; chaid.AvailableMemberHouse; chaid.Household; view.HouseHoldStat; chaid.MkChaid" %>

<%
    def objectiveTypeList = DictionaryItem.findAllByDictionary_id(Dictionary.findByCode("CHAD11"))
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

    %>
    <g:each  in="${Street.findAllByDistrict_id(districtInstance, [order: 'asc', sort: 'name'])}" status="i"
             var="villageListInstance" >
        <%
            def houseHoldNo = 0;
            def chadNo = 0;
            def visitedNewHouseHold = 0;
            def repeatHouse = 0;
            if (end_date && from_date) {
                // repeatHouse =view.HouseHoldStat.executeQuery("select number_of_orders from HouseHoldStat where region_id=:region and  chaid.arrival_time between '"+from_date+"' and '"+end_date+"' and number_of_orders>1",[region:regionListInstance]).size()
                chadNo = MkChaid.executeQuery("select id from MkChaid where street=:village and deleted=false and arrival_time between '" + from_date + "' and '" + end_date + "'", [village: villageListInstance]).size()


            } else {
                chadNo = MkChaid.executeQuery("select id from MkChaid where street=:village and deleted=false ", [village: villageListInstance]).size()

            }
        %>

        <g:if test="${chadNo > 0}">

            <tr class="${(countNo % 2) == 0 ? 'even' : 'odd'} ">
                <td>${countNo}</td>
                <td><span class="text-bold">${districtListInstance?.name}</span></td>
                <td>
                    <table class="table" border="1">
                        <g:each in="${objectiveTypeList}" var="objectiveType1">
                            <tr class="${(countNo % 2) == 0 ? 'even' : 'odd'} ">
                                <td>${objectiveType1.name}</td>
                            </tr>
                        </g:each>
                    </table>
                </td>
                <td class="info">
                    <table class="table" border="1">
                        <g:each in="${objectiveTypeList}" var="objectiveType9">
                            <tr class="${(countNo % 2) == 0 ? 'even' : 'odd'} ">
                                <%
                                    def chadNo1 = 0;
                                    if (end_date && from_date) {
                                        chadNo1 = MkChaid.executeQuery("select id from MkChaid where street=:village and deleted=false and arrival_time between '" + from_date + "' and '" + end_date + "' and objective_type=:objectiveType", [village: villageListInstance, objectiveType: objectiveType9]).size()

                                    } else {
                                        chadNo1 = MkChaid.executeQuery("select id from MkChaid where street=:village and deleted=false and objective_type=:objectiveType", [village: villageListInstance, objectiveType: objectiveType9]).size()

                                    }

                                %>
                                <td class="info"> <span>${formatAmountString(name: (int) chadNo1)}</span></td>
                            </tr>
                        </g:each>
                    </table>



                </td>


                <td>
                    <table class="table" border="1">
                        <g:each in="${objectiveTypeList}" var="objectiveType9">
                            <tr class="${(countNo % 2) == 0 ? 'even' : 'odd'} ">
                                <%
                                    def houseHoldNo1 = 0;
                                    if (end_date && from_date) {
                                        houseHoldNo1 = MkChaid.executeQuery("select household.id from MkChaid where street=:village and deleted=false and arrival_time between '" + from_date + "' and '" + end_date + "' and objective_type=:objectiveType group by household.id", [village: villageListInstance, objectiveType: objectiveType9]).size()

                                    } else {
                                        houseHoldNo1 = MkChaid.executeQuery("select household.id from MkChaid where street=:village and deleted=false and objective_type=:objectiveType group by household.id", [village: villageListInstance, objectiveType: objectiveType9]).size()

                                    }

                                %>
                                <td>${formatAmountString(name: (int) houseHoldNo1)}</td></tr>
                        </g:each>
                    </table>
                </td>


                <td colspan="3">
                    <table class="table" border="1">
                        <g:each in="${objectiveTypeList}" var="objectiveType">
                            <%
                                def houseHoldMember = 0
                                def houseHoldMemberTotal = 0

                                def houseHoldMale = 0
                                def houseHoldMaleFemale = 0

                                if (end_date && from_date) {
                                    houseHoldMember = MkChaid.executeQuery("select sum(household.total_members),sum(household.male_no),sum(household.female_no) from MkChaid  where   deleted=false and created_at between '" + from_date + "' and '" + end_date + "' and street=:village and objective_type=:objectiveType", [village: villageListInstance, objectiveType: objectiveType])

                                    // repeatHouseMember = houseHoldNoMember - visitedNewHouseHoldMember;


                                } else {
                                    houseHoldMember = MkChaid.executeQuery("select sum(household.total_members),sum(household.male_no),sum(household.female_no) from MkChaid  where  deleted=false and objective_type=:objectiveType  and street=:village", [objectiveType: objectiveType,village: villageListInstance])

                                }

                                if(houseHoldMember[0][0]){
                                    houseHoldMemberTotal = houseHoldMember[0][0]
                                }

                                if(houseHoldMember[0][1]){
                                    houseHoldMale = houseHoldMember[0][1]
                                }
                                if(houseHoldMember[0][2]){
                                    houseHoldMaleFemale = houseHoldMember[0][2]
                                }

                            %>
                            <tr class="${(countNo % 2) == 0 ? 'even' : 'odd'} "><td>${formatAmountString(name: (int) houseHoldMemberTotal)}</td>
                                <td>${formatAmountString(name: (int) houseHoldMale)}</td>
                                <td>${formatAmountString(name: (int) houseHoldMaleFemale)}</td></tr>

                        </g:each>
                    </table>
                </td>

                <td>
                    <table class="table" border="1">
                        <g:each in="${objectiveTypeList}" var="objectiveType2">
                            <tr class="${(countNo % 2) == 0 ? 'even' : 'odd'} ">
                                <%
                                    def womenAgeBetweenNo = 0;
                                    def womenAgeBetweenNo1 = 0;

                                    if (end_date && from_date) {
                                        womenAgeBetweenNo = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.street=:village and arrival_time between '" + from_date + "' and '" + end_date + "' and chaid.objective_type=:objectiveType", [categoryType: DictionaryItem.findByCode("CHAD17G"), village: villageListInstance, objectiveType: objectiveType2])

                                    } else {
                                        womenAgeBetweenNo = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.street=:village and chaid.objective_type=:objectiveType", [categoryType: DictionaryItem.findByCode("CHAD17G"),village: villageListInstance, objectiveType: objectiveType2])

                                    }
                                    if(womenAgeBetweenNo[0]){
                                        womenAgeBetweenNo1 = womenAgeBetweenNo[0]
                                    }

                                %>
                                <td>${formatAmountString(name: (int) womenAgeBetweenNo1)}</td></tr>
                        </g:each>
                    </table>
                </td>


                <td>


                    <table class="table" border="1">
                        <g:each in="${objectiveTypeList}" var="objectiveType3">
                            <tr class="${(countNo % 2) == 0 ? 'even' : 'odd'} ">
                                <%
                                    def maleAgeBetweenNo = 0;
                                    def maleAgeBetweenNo1 = 0;

                                    if (end_date && from_date) {
                                        maleAgeBetweenNo = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.street=:village and arrival_time between '" + from_date + "' and '" + end_date + "' and chaid.objective_type=:objectiveType", [categoryType: DictionaryItem.findByCode("CHAD17H"), village: villageListInstance,objectiveType: objectiveType3])
                                    } else {
                                        maleAgeBetweenNo = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.street=:village and chaid.objective_type=:objectiveType", [categoryType: DictionaryItem.findByCode("CHAD17H"), village: villageListInstance,objectiveType: objectiveType3])
                                    }

                                    if(maleAgeBetweenNo[0]){
                                        maleAgeBetweenNo1 = maleAgeBetweenNo[0]
                                    }
                                %>
                                <td>${formatAmountString(name: (int) maleAgeBetweenNo1)}</td></tr>
                        </g:each>
                    </table>
                </td>

                <td>


                    <table class="table" border="1">
                        <g:each in="${objectiveTypeList}" var="objectiveType4">
                            <tr class="${(countNo % 2) == 0 ? 'even' : 'odd'} ">
                                <%
                                    def neonates = 0;
                                    def neonates1 = 0;

                                    if (end_date && from_date) {
                                        neonates = CategoryAvailableChildren.executeQuery("select sum(member_no) from CategoryAvailableChildren where categoryType=:categoryType  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.street=:village and created_at between '" + from_date + "' and '" + end_date + "'  and availableMemberHouse.chaid.objective_type=:objectiveType", [categoryType: DictionaryItem.findByCode("CHAD17D"), village: villageListInstance,objectiveType: objectiveType4])

                                    } else {
                                        neonates = CategoryAvailableChildren.executeQuery("select sum(member_no) from CategoryAvailableChildren where categoryType=:categoryType  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.street=:village  and availableMemberHouse.chaid.objective_type=:objectiveType", [categoryType: DictionaryItem.findByCode("CHAD17D"), village: villageListInstance,objectiveType: objectiveType4])

                                    }

                                    if(neonates[0]){
                                        neonates1 = neonates[0]
                                    }
                                %>
                                <td>${formatAmountString(name: (int) neonates1)}</td></tr>
                        </g:each>
                    </table>

                </td>

                <td>

                    <table class="table" border="1">
                        <g:each in="${objectiveTypeList}" var="objectiveType5">
                            <tr class="${(countNo % 2) == 0 ? 'even' : 'odd'} ">
                                <%
                                    def infants = 0
                                    def infants1 = 0

                                    if (end_date && from_date) {
                                        infants = CategoryAvailableChildren.executeQuery("select sum(member_no)  from CategoryAvailableChildren where categoryType=:categoryType  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.street=:village and created_at between '" + from_date + "' and '" + end_date + "'  and availableMemberHouse.chaid.objective_type=:objectiveType", [categoryType: DictionaryItem.findByCode("CHAD17E"),village: villageListInstance,objectiveType: objectiveType5])
                                    } else {
                                        infants = CategoryAvailableChildren.executeQuery("select sum(member_no)  from CategoryAvailableChildren where categoryType=:categoryType  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.street=:village  and availableMemberHouse.chaid.objective_type=:objectiveType", [categoryType: DictionaryItem.findByCode("CHAD17E"), village: villageListInstance,objectiveType: objectiveType5])

                                    }

                                    if(infants[0]){
                                        infants1 = infants[0]
                                    }

                                %>
                                <td>${formatAmountString(name: (int) infants1)}</td></tr>
                        </g:each>
                    </table>

                </td>
                <td>


                    <table class="table" border="1">
                        <g:each in="${objectiveTypeList}" var="objectiveType6">
                            <tr class="${(countNo % 2) == 0 ? 'even' : 'odd'} ">
                                <%
                                    def pregnantWomen = 0
                                    def pregnantWomen1 = 0

                                    if (end_date && from_date) {
                                        pregnantWomen = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.street=:village and arrival_time between '" + from_date + "' and '" + end_date + "' and chaid.objective_type=:objectiveType", [categoryType: DictionaryItem.findByCode("CHAD17A"), village: villageListInstance,objectiveType: objectiveType6])

                                    } else {
                                        pregnantWomen = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.street=:village and chaid.objective_type=:objectiveType", [categoryType: DictionaryItem.findByCode("CHAD17A"), village: villageListInstance,objectiveType: objectiveType6])

                                    }
                                    if(pregnantWomen[0]){
                                        pregnantWomen1 = pregnantWomen[0]
                                    }
                                %>
                                <td>${formatAmountString(name: (int) pregnantWomen1) }</td></tr>
                        </g:each>
                    </table>

                </td>
                <td>

                    <table class="table" border="1">
                        <g:each in="${objectiveTypeList}" var="objectiveType7">
                            <tr class="${(countNo % 2) == 0 ? 'even' : 'odd'} ">
                                <%
                                    def breastFeedingWomen = 0;
                                    def breastFeedingWomen1 = 0;

                                    if (end_date && from_date) {
                                        breastFeedingWomen = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.street=:village and arrival_time between '" + from_date + "' and '" + end_date + "' and chaid.objective_type=:objectiveType", [categoryType: DictionaryItem.findByCode("CHAD17B"), village: villageListInstance,objectiveType: objectiveType7])

                                    } else {
                                        breastFeedingWomen = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.street=:village and chaid.objective_type=:objectiveType", [categoryType: DictionaryItem.findByCode("CHAD17B"), village: villageListInstance,objectiveType: objectiveType7])
                                    }

                                    if(breastFeedingWomen[0]){
                                        breastFeedingWomen1 = breastFeedingWomen[0]
                                    }
                                %>
                                <td>${formatAmountString(name: (int) breastFeedingWomen1)}</td></tr>
                        </g:each>
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
                            chadNoH = MkChaid.executeQuery("select id from MkChaid where  deleted=false and visit_type=:visit_type and street=:village and arrival_time between '" + from_date + "' and '" + end_date + "'", [visit_type: visitDataInstance, village: villageListInstance]).size()

                        } else {
                            chadNoH = MkChaid.executeQuery("select id from MkChaid where  deleted=false and visit_type=:visit_type and street=:village ", [visit_type: visitDataInstance, village: villageListInstance]).size()

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
                            houseHoldMemberH = MkChaid.executeQuery("select sum(household.total_members),sum(household.male_no),sum(household.female_no) from MkChaid  where  visit_type=:visit_type and street=:village and deleted=false  and created_at between '" + from_date + "' and '" + end_date + "'", [visit_type: visitDataInstance, village: villageListInstance])
                        } else {
                            houseHoldMemberH = MkChaid.executeQuery("select sum(household.total_members),sum(household.male_no),sum(household.female_no) from MkChaid  where  visit_type=:visit_type and street=:village and deleted=false", [visit_type: visitDataInstance, village: villageListInstance])

                        }
                        if(houseHoldMemberH[0][0]){
                            totalPopulation  = houseHoldMemberH[0][0]
                        }

                        if(houseHoldMemberH[0][1]){
                            maleTotal  = houseHoldMemberH[0][1]
                        }

                        if(houseHoldMemberH[0][2]){
                            femaleTotal  = houseHoldMemberH[0][2]
                        }

                    %>
                    <td>${formatAmountString(name: (int) totalPopulation)}</td>
                    <td>${formatAmountString(name: (int) maleTotal)}</td>
                    <td>${formatAmountString(name: (int) femaleTotal)}</td>

                </tr>
            </g:each>
            <%

                countNo++;
            %>
        </g:if>
    </g:each>
    </tbody>

</table>