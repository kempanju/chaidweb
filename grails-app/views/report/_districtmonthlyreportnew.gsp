<%@ page import="materialize.view.DangerSign;chaid.DangerSignPregnant; chaid.ReferalAdolescent; admin.DictionaryItem; chaid.HealthEducation; chaid.Survey; chaid.MkChaid; chaid.AdolescentAbuse; materialize.view.ViewHealthEducation; chaid.Household; chaid.AvailableMemberHouse" %>
<%
    def memberCategoryList = DictionaryItem.findAllByDictionary_idAndDisplayReport(admin.Dictionary.findByCode("CHAD17"), true, [sort: 'displayOrder', order: 'asc']);
%>

<div style=" overflow-x: auto;">
    <table class="table  table-bordered nowrap" border="1">

        <tr style="white-space:nowrap;"><th></th>

            <g:each in="${memberCategoryList}" var="categoryListInstance">
                <th class="success">${categoryListInstance.abbreviation}</th>

            </g:each></tr>
        <tr>
            <td colspan="16"
                class="text-bold text-center">PROVISION OF HEALTH EDUCATION AND FOLLOW UP AT HOUSEHOLD LEVEL</td>
        </tr>
        <tr>
            <%
                def houseHoldNo = 0;
                if (end_date && from_date) {
                    houseHoldNo = Household.executeQuery("from Household where created_at between '" + from_date + "' and '" + end_date + "' and district_id=:districtInstance", [districtInstance: districtInstance]).size()

                } else {
                    houseHoldNo = Household.executeQuery("from Household where deleted=false and district_id=:districtInstance", [districtInstance: districtInstance]).size()

                }
            %>
            <td class="info">Total household</td><td>${formatAmountString(name: (int) houseHoldNo)}</td>
        </tr>
        <tr>
            <td class="info">Total number of Girls and Boys in the adoloscent group ages (10-24) reached</td>
            <g:each in="${memberCategoryList}" var="categorysListInstance">
                <g:if test="${categorysListInstance.code == "CHAD17F" || categorysListInstance.code == "CHAD17E"}">
                    <td style="background:black"></td>
                </g:if>
                <g:else>
                    <%
                        def groupAgeBetweenNo = 0;

                        if (end_date && from_date) {
                            groupAgeBetweenNo = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and arrival_time between '" + from_date + "' and '" + end_date + "' and chaid.distric=:districtInstance", [categoryType: categorysListInstance, districtInstance: districtInstance])[0]

                        } else {
                            groupAgeBetweenNo = AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.distric=:districtInstance", [categoryType: categorysListInstance, districtInstance: districtInstance])[0]

                        }
                        if (!groupAgeBetweenNo) {
                            groupAgeBetweenNo = 0
                        }

                    %>
                    <td>${formatAmountString(name: (int) groupAgeBetweenNo)}</td>
                </g:else>
            </g:each>

        </tr>

        <tr>
            <td colspan="16"
                class="text-bold text-left">HEALTH EDUCATION:TYPE OF HEALTH EDUCATION PROVIDED FOR GIRLS AND BOYS IN THE ADOLESCENT GROUP AGES 10 -24 YEARS</td>
        </tr>
        <tr><td></td><td>Male</td><td>Female</td><td>Total</td></tr>
        <g:each in="${DictionaryItem.findAllByDictionary_id(admin.Dictionary.findByCode("EDYTYVA123"))}"
                status="i" var="educationListInstance">

            <tr>
                <td class="info">
                    <ul class="myUL">

                        <li><span class="caret">${educationListInstance.name}</span>
            <g:if test="${type == 'file'}">

                <ul class="nested">
                                <g:each in="${DictionaryItem.findAllByCategory(educationListInstance)}"
                                        status="ii" var="categoryListInstance">
                                    <li>${categoryListInstance.name}</li>
                                </g:each>

                            </ul>
            </g:if>
                        </li>
                    </ul>

                </td>

                <%
                    //def visitTypeInstance=admin.DictionaryItem.findByCode("CHAD4A")
                    def noHoldMember = 0
                    def noHoldMemberMale = 0
                    def noHoldMemberFemale = 0

                    def noHoldMemberData
                    if (end_date && from_date) {
                        noHoldMemberData = HealthEducation.executeQuery("select sum(h.chaid.members_male),sum(h.chaid.members_female) from HealthEducation h where type.category=:education_type  and created_at between '" + from_date + "' and '" + end_date + "' and h.chaid.distric=:districtInstance", [education_type: educationListInstance, districtInstance: districtInstance])[0]

                    } else {
                        noHoldMemberData = HealthEducation.executeQuery("select sum(h.chaid.members_male),sum(h.chaid.members_female) from HealthEducation h where type.category=:education_type  and  h.chaid.distric=:districtInstance", [education_type: educationListInstance, districtInstance: districtInstance])[0]

                    }
                    noHoldMemberMale = noHoldMemberData[0]
                    noHoldMemberFemale = noHoldMemberData[1]
                    if (!noHoldMemberMale) {
                        noHoldMemberMale = 0
                    }
                    if (!noHoldMemberFemale) {
                        noHoldMemberFemale = 0
                    }
                    noHoldMember = noHoldMemberMale + noHoldMemberFemale;
                    if (!noHoldMember) {
                        noHoldMember = 0
                    }
                %>
                <td>${formatAmountString(name: (int) noHoldMemberMale)}</td>

                <td>${formatAmountString(name: (int) noHoldMemberFemale)}</td>

                <td>${formatAmountString(name: (int) noHoldMember)}</td>


                <td></td>
            </tr>
        </g:each>


        <tr>
            <td colspan="16"
                class="text-bold text-center">REFERRALS CONDUCTED FROM THE COMMUNITY :-TOTAL NUMBER OF GIRLS AND BOYS IN THE ADOLLENCENT GROUP Who (10-19 YRS) WERE REFERRED DUE TO:-</td>
        </tr>
        <tr><td></td><td>Male</td><td>Female</td><td>Unknown</td><td>Total</td></tr>
        <tr><td>Vijana waliopewa rufaa ya afya ya uzazi</td>
            <%
                def ukatiliWaJinsioa = DictionaryItem.findByCode("CHAD55B3")
                def countReferrals, countReferralsMale, countReferralsFemale
                if (end_date && from_date) {
                    countReferrals = ReferalAdolescent.executeQuery("select id from ReferalAdolescent where type=:referralsListInstance and arrival_time between '" + from_date + "' and '" + end_date + "' and chaid.distric=:districtInstance ", [referralsListInstance: ukatiliWaJinsioa, districtInstance: districtInstance]).size()

                } else {
                    countReferrals = ReferalAdolescent.executeQuery("select id from ReferalAdolescent where type=:referralsListInstance and chaid.distric=:districtInstance ", [referralsListInstance: ukatiliWaJinsioa, districtInstance: districtInstance]).size()

                }

                if (end_date && from_date) {
                    countReferralsFemale = ReferalAdolescent.executeQuery("select id from ReferalAdolescent where adolescent.gender in ('ke','Ke')  and type=:referralsListInstance and arrival_time between '" + from_date + "' and '" + end_date + "' and chaid.distric=:districtInstance ", [referralsListInstance: ukatiliWaJinsioa, districtInstance: districtInstance]).size()

                } else {
                    countReferralsFemale = ReferalAdolescent.executeQuery("select id from ReferalAdolescent where adolescent.gender in ('ke','Ke')  and type=:referralsListInstance and chaid.distric=:districtInstance ", [referralsListInstance: ukatiliWaJinsioa,districtInstance: districtInstance]).size()

                }

                if (end_date && from_date) {
                    countReferralsMale = ReferalAdolescent.executeQuery("select id from ReferalAdolescent where adolescent.gender in ('me','Me')  and type=:referralsListInstance and arrival_time between '" + from_date + "' and '" + end_date + "' and chaid.distric=:districtInstance ", [referralsListInstance: ukatiliWaJinsioa, districtInstance: districtInstance]).size()

                } else {
                    countReferralsMale = ReferalAdolescent.executeQuery("select id from ReferalAdolescent where adolescent.gender in ('me','Me')  and type=:referralsListInstance and chaid.distric=:districtInstance ", [referralsListInstance: ukatiliWaJinsioa, districtInstance: districtInstance]).size()

                }
                def countReferalsFemale = 0;
                if (end_date && from_date) {
                    countReferalsFemale = DangerSignPregnant.executeQuery("select id from DangerSignPregnant where preginantDetails.age between 10 and 19 and chaid.deleted=false and arrival_time between '" + from_date + "' and '" + end_date + "' and chaid.distric=:districtInstance", [districtInstance: districtInstance]).size()

                } else {
                    countReferalsFemale = DangerSignPregnant.executeQuery("select id from DangerSignPregnant where preginantDetails.age between 10 and 19 and chaid.deleted=false and chaid.distric=:districtInstance", [districtInstance: districtInstance]).size()

                }

                if (!countReferrals) {
                    countReferrals = 0
                }
                if (!countReferralsMale) {
                    countReferralsMale = 0
                }
                if (!countReferralsFemale) {
                    countReferralsFemale = 0
                }

                countReferralsFemale = countReferalsFemale + countReferralsFemale

                def unknownGender = countReferrals - (countReferralsFemale + countReferralsMale) + countReferalsFemale
            %>
            <td>${formatAmountString(name: (int) countReferralsMale)}</td>
            <td>${formatAmountString(name: (int) countReferralsFemale)}</td>
            <td>${formatAmountString(name: (int) unknownGender)}</td>

            <td>${formatAmountString(name: (int) countReferrals)}</td>
        </tr>
        <tr><td>Vijana waliopewa rufaa ya lishe</td>
            <%
                ukatiliWaJinsioa = DictionaryItem.findByCode("CHAD55B3")
                countReferrals = 0;
                countReferralsMale = 0;
                countReferralsFemale = 0
                if (end_date && from_date) {
                    countReferrals = ReferalAdolescent.executeQuery("select id from ReferalAdolescent where type=:referralsListInstance and arrival_time between '" + from_date + "' and '" + end_date + "' and chaid.distric=:districtInstance ", [referralsListInstance: ukatiliWaJinsioa, districtInstance: districtInstance]).size()

                } else {
                    countReferrals = ReferalAdolescent.executeQuery("select id from ReferalAdolescent where type=:referralsListInstance and chaid.distric=:districtInstance", [referralsListInstance: ukatiliWaJinsioa, districtInstance: districtInstance]).size()
                }

                if (end_date && from_date) {
                    countReferralsFemale = ReferalAdolescent.executeQuery("select id from ReferalAdolescent where adolescent.gender in ('ke','Ke')  and type=:referralsListInstance and arrival_time between '" + from_date + "' and '" + end_date + "' and chaid.distric=:districtInstance ", [referralsListInstance: ukatiliWaJinsioa, districtInstance: districtInstance]).size()

                } else {
                    countReferralsFemale = ReferalAdolescent.executeQuery("select id from ReferalAdolescent where adolescent.gender in ('ke','Ke')  and type=:referralsListInstance and chaid.distric=:districtInstance", [referralsListInstance: ukatiliWaJinsioa, districtInstance: districtInstance]).size()

                }

                if (end_date && from_date) {
                    countReferralsMale = ReferalAdolescent.executeQuery("select id from ReferalAdolescent where adolescent.gender in ('me','Me')  and type=:referralsListInstance and arrival_time between '" + from_date + "' and '" + end_date + "' and chaid.distric=:districtInstance ", [referralsListInstance: ukatiliWaJinsioa, districtInstance: districtInstance]).size()

                } else {
                    countReferralsMale = ReferalAdolescent.executeQuery("select id from ReferalAdolescent where adolescent.gender in ('me','Me')  and type=:referralsListInstance and chaid.distric=:districtInstance", [referralsListInstance: ukatiliWaJinsioa, districtInstance: districtInstance]).size()

                }


                if (!countReferrals) {
                    countReferrals = 0
                }
                if (!countReferralsMale) {
                    countReferralsMale = 0
                }
                if (!countReferralsFemale) {
                    countReferralsFemale = 0
                }

                unknownGender = countReferrals - (countReferralsFemale + countReferralsMale)
            %>
            <td>${formatAmountString(name: (int) countReferralsMale)}</td>
            <td>${formatAmountString(name: (int) countReferralsFemale)}</td>
            <td>${formatAmountString(name: (int) unknownGender)}</td>

            <td>${formatAmountString(name: (int) countReferrals)}</td>

        </tr>


        <%
            ukatiliWaJinsioa = DictionaryItem.findByCode("CHAD55B2")
            countReferrals = 0;
            countReferralsMale = 0;
            countReferralsFemale = 0;
            if (end_date && from_date) {
                countReferrals = ReferalAdolescent.executeQuery("select id from ReferalAdolescent where type=:referralsListInstance and arrival_time between '" + from_date + "' and '" + end_date + "' and chaid.distric=:districtInstance ", [referralsListInstance: ukatiliWaJinsioa, districtInstance: districtInstance]).size()

            } else {
                countReferrals = ReferalAdolescent.executeQuery("select id from ReferalAdolescent where type=:referralsListInstance and chaid.distric=:districtInstance", [referralsListInstance: ukatiliWaJinsioa, districtInstance: districtInstance]).size()

            }

            if (end_date && from_date) {
                countReferralsFemale = ReferalAdolescent.executeQuery("select id from ReferalAdolescent where adolescent.gender in ('ke','Ke')  and type=:referralsListInstance and arrival_time between '" + from_date + "' and '" + end_date + "' and chaid.distric=:districtInstance ", [referralsListInstance: ukatiliWaJinsioa, districtInstance: districtInstance]).size()

            } else {
                countReferralsFemale = ReferalAdolescent.executeQuery("select id from ReferalAdolescent where adolescent.gender in ('ke','Ke')  and type=:referralsListInstance and chaid.distric=:districtInstance", [referralsListInstance: ukatiliWaJinsioa, districtInstance: districtInstance]).size()

            }

            if (end_date && from_date) {
                countReferralsMale = ReferalAdolescent.executeQuery("select id from ReferalAdolescent where adolescent.gender in ('me','Me')  and type=:referralsListInstance and arrival_time between '" + from_date + "' and '" + end_date + "' and chaid.distric=:districtInstance ", [referralsListInstance: ukatiliWaJinsioa, districtInstance: districtInstance]).size()

            } else {
                countReferralsMale = ReferalAdolescent.executeQuery("select id from ReferalAdolescent where adolescent.gender in ('me','Me')  and type=:referralsListInstance and chaid.distric=:districtInstance ", [referralsListInstance: ukatiliWaJinsioa, districtInstance: districtInstance]).size()

            }


            if (!countReferrals) {
                countReferrals = 0
            }
            if (!countReferralsMale) {
                countReferralsMale = 0
            }
            if (!countReferralsFemale) {
                countReferralsFemale = 0
            }

            unknownGender = countReferrals - (countReferralsFemale + countReferralsMale)
        %>

        <tr><td>Vijana waliopewa rufaa ya ukatili wa kijinsia</td>
            <td>${formatAmountString(name: (int) countReferralsMale)}</td>
            <td>${formatAmountString(name: (int) countReferralsFemale)}</td>
            <td>${formatAmountString(name: (int) unknownGender)}</td>

            <td>${formatAmountString(name: (int) countReferrals)}</td>
        </tr>


        <tr>
            <td colspan="3">1.Idadi ya wavulana na wasichana kundi balehe umri 10-24 waliotoa ripoti na kupata huduma katika vituodhidi ya unyanyasaji wa kingono (Ukatili wa kijinsia- GBV)</td>
            <td>${AdolescentAbuse.count()}</td>
        </tr>
        <tr>
            <td colspan="3">2-Idadi ya wavulana na wasichana umri 10-24 waliopewa ushauri juu ya  Virusi vya Ukimwi</td>
            <td>
                <%
                    def healthEducationMale
                    def eduInstance1 = DictionaryItem.findByCode('CHAD33F2')
                    if (end_date && from_date) {
                        healthEducationMale = ViewHealthEducation.executeQuery("select member_no from ViewHealthEducation where arrival_time between '" + from_date + "' and '" + end_date + "' and education_type =:educationType and chaid.distric=:districtInstance ", [educationType: eduInstance1, districtInstance: districtInstance]).size()
                    } else {
                        healthEducationMale = ViewHealthEducation.executeQuery("select member_no from ViewHealthEducation where  education_type =:educationType and chaid.distric=:districtInstance ", [educationType: eduInstance1, districtInstance: districtInstance]).size()
                    }

                %>
                ${formatAmountString(name: (int) healthEducationMale)}
            </td>
        </tr>
        <tr>
            <td colspan="3">3-Idadi ya wavulana na wasichana umri 10-24 waliopewa ushauri juu ya kufua kikuu</td>
            <td>
                <%
                    def healthEducationFemale1
                    def eduInstance2 = DictionaryItem.findByCode('CHAD6H')
                    if (end_date && from_date) {
                        healthEducationFemale1 = ViewHealthEducation.executeQuery("select member_no from ViewHealthEducation where arrival_time between '" + from_date + "' and '" + end_date + "' and education_type =:educationType and chaid.distric=:districtInstance ", [educationType: eduInstance2, districtInstance: districtInstance]).size()
                    } else {
                        healthEducationFemale1 = ViewHealthEducation.executeQuery("select member_no from ViewHealthEducation where education_type =:educationType and chaid.distric=:districtInstance ", [educationType: eduInstance2, districtInstance: districtInstance]).size()
                    }

                %>
                ${formatAmountString(name: (int) healthEducationFemale1)}
            </td>
        </tr>


        <tr>
            <td colspan="16" class="text-bold text-center">PROVISION OF HEALTH EDUCATION IN CONGREGATE SETTING/MASS</td>
        </tr>
        <tr><td colspan="2">Place Visited</td><td colspan="3">Total number reached during health education session</td>
            <td colspan="3">Total number of Girls and Boys in the adolescent group who have received health education</td>
        </tr>
        <g:each in="${DictionaryItem.findAllByDictionary_idAndDisplayReport(admin.Dictionary.findByCode("CHAD5"), true)}"
                status="i" var="gatheringTypeListInstance">
            <tr>
                <td colspan="2">${gatheringTypeListInstance.name}</td>
                <%
                    def totalCountData = null
                    if (end_date && from_date) {
                        totalCountData = MkChaid.executeQuery("select sum(total_members),sum(members_male),sum(members_female)  from MkChaid where deleted=false and meeting_type=:meeting_type and arrival_time between '" + from_date + "' and '" + end_date + "' " +

                                "and distric=:districtInstance", [meeting_type: gatheringTypeListInstance, districtInstance: districtInstance])[0]
                    } else {

                        totalCountData = MkChaid.executeQuery("select sum(total_members),sum(members_male),sum(members_female)  from MkChaid where deleted=false and meeting_type=:meeting_type " +

                                "and distric=:districtInstance", [meeting_type: gatheringTypeListInstance, districtInstance: districtInstance])[0]
                    }

                    def totalCount = totalCountData[0];
                    def totalMaleN = totalCountData[1];
                    def totalFemaleN = totalCountData[2];

                    if (!totalCount) {
                        totalCount = 0
                    }

                    if (!totalMaleN) {
                        totalMaleN = 0;
                    }

                    if (!totalFemaleN) {
                        totalFemaleN = 0;
                    }
                %>
                <td colspan="3">${formatAmountString(name: (int) totalCount)},
                Male : ${formatAmountString(name: (int) totalMaleN)} ,
                Female : ${formatAmountString(name: (int) totalFemaleN)}
                </td>
                <td colspan="3">

                </td>
            </tr>
        </g:each>


        <tr>
            <td colspan="16"
                class="text-bold text-left">TYPE OF HEALTH EDUCATION PROVIDED TO GIRLS AND BOYS IN THE ADOLESCENT GROUP DURING GATHERINGS</td>
        </tr>

        <g:each in="${DictionaryItem.findAllByDictionary_id(admin.Dictionary.findByCode("EDUGATHER01"))}"
                status="i" var="educationListInstance">

            <tr>
                <td class="info" colspan="3">

                    <ul class="myUL">

                        <li><span class="caret">${educationListInstance.name}</span>
            <g:if test="${type == 'file'}">

                <ul class="nested">
                                <g:each in="${DictionaryItem.findAllByCategory(educationListInstance)}"
                                        status="iiiI" var="categoryEdUListInstance">
                                    <li>${categoryEdUListInstance.name}</li>
                                </g:each>

                            </ul>
            </g:if>
                        </li>
                    </ul>
                </td>

                <%
                    def noHoldMember1 = 0
                    def visitTypeInstance = DictionaryItem.findByCode("CHAD4B")
                    def noHoldMemberData1;
                    if (end_date && from_date) {
                        noHoldMemberData1 = HealthEducation.executeQuery("select sum(chaid.total_members),sum(chaid.members_male),sum(chaid.members_female) from HealthEducation where  type.category=:education_type and chaid.visit_type=:visitTypeInstance " +

                                "and created_at between '" + from_date + "' and '" + end_date + "' and chaid.distric=:districtInstance", [education_type: educationListInstance, visitTypeInstance: visitTypeInstance, districtInstance: districtInstance])[0]

                    } else {
                        noHoldMemberData1 = HealthEducation.executeQuery("select sum(chaid.total_members),sum(chaid.members_male),sum(chaid.members_female) from HealthEducation  " +

                                "where  type.category=:education_type and chaid.visit_type=:visitTypeInstance and chaid.distric=:districtInstance", [education_type: educationListInstance, visitTypeInstance: visitTypeInstance, districtInstance: districtInstance])[0]

                    }
                    noHoldMember1 = noHoldMemberData1[0];
                    noHoldMemberMale = noHoldMemberData1[1];
                    noHoldMemberFemale = noHoldMemberData1[2];

                    if (!noHoldMember1) {
                        noHoldMember1 = 0
                    }
                    if (!noHoldMemberMale) {
                        noHoldMemberMale = 0
                    }
                    if (!noHoldMemberFemale) {
                        noHoldMemberFemale = 0
                    }
                %>
                <td>${formatAmountString(name: (int) noHoldMember1)}</td>
                <td>
                    <table>
                        <tr><td>Male</td><td>${formatAmountString(name: (int) noHoldMemberMale)}</td></tr>
                        <tr><td>Female</td><td>${formatAmountString(name: (int) noHoldMemberFemale)}</td></tr>
                    </table>
                </td>

            </tr>
        </g:each>

        <tr>
            <td colspan="16" class="text-bold text-center">UHAMASISHAJI WA MFUKO WA BIMA YA AFYA ULIOBORESHA (iCHF)</td>
            <td></td>
        </tr>


        <tr>
            <%
                def surveyInstance1 = admin.Dictionary.findByCode("CHAD59")
                def survey1 = 0
                if (end_date && from_date) {
                    survey1 = Survey.executeQuery(" select sum(survey_no) from Survey h where  type=:surveyInstance1  and arrival_time between '" + from_date + "' and '" + end_date + "' and chaid.distric=:districtInstance", [surveyInstance1: surveyInstance1, districtInstance: districtInstance]).size()

                } else {
                    survey1 = Survey.executeQuery("select sum(survey_no) from Survey where  type=:surveyInstance1 and chaid.distric=:districtInstance", [surveyInstance1: surveyInstance1, districtInstance: districtInstance])[0]

                }

                def surveyInstance2 = admin.Dictionary.findByCode("CHAD60")
                def survey2 = 0
                if (end_date && from_date) {
                    survey2 = Survey.executeQuery(" select sum(survey_no)  from Survey h where  type=:surveyInstance1  and arrival_time between '" + from_date + "' and '" + end_date + "' and chaid.distric=:districtInstance", [surveyInstance1: surveyInstance2, districtInstance: districtInstance])[0]

                } else {
                    survey2 = Survey.executeQuery("select sum(survey_no) from Survey where  type=:surveyInstance1 and chaid.distric=:districtInstance", [surveyInstance1: surveyInstance2, districtInstance: districtInstance])[0]

                }
            %>
            <td colspan="3">1-Idadi ya kaya walio hamasishwa kujiunga na mfuko wa Bima ya Afya iliyoboreshwa (iCHF)</td>
            <td>${survey1}</td>
        </tr>
        <tr>
            <td colspan="3">2-Idadi ya watu waliohamasishwa na kujiunga katika mfuko wa Bima ya Afya iliyoboeshwa</td>
            <td>0</td>
        </tr>
        <tr>
            <td colspan="3">3-Idadi ya kaya ambao kadi zao za Bima ya Afya zimeisha wakahamasishwa na kujiunga tena katika Mfuko wa Bima ya Afya Ulioboreshwa</td>
            <td>${survey2}</td>
        </tr>
        <tr>
            <td colspan="3">1.Idadi ya watoto na watu wazima walio ripoti kupata huduma za  uchunguzi wa magonjwa ya ngono na unyanyasaji kijinsia</td>
            <td>

                <%
                    def adolescentNo
                    if (end_date && from_date) {
                        adolescentNo = AdolescentAbuse.executeQuery("select id from AdolescentAbuse where arrival_time between '" + from_date + "' and '" + end_date + "' and chaid.distric=:districtInstance", [districtInstance: districtInstance]).size()
                    } else {
                        adolescentNo = AdolescentAbuse.executeQuery("select id from AdolescentAbuse where  chaid.distric=:districtInstance", [districtInstance: districtInstance]).size()
                    }
                %>
                ${formatAmountString(name: adolescentNo)}

            </td>
        </tr>

        <tr>
            <td colspan="16" class="text-bold text-center">ELIMU YA COVID-19</td>
            <td></td>
        </tr>
        <tr>
            <%
                def educationListInstance = DictionaryItem.findByCode("CHAD33F5")

                def covidNoMale = 0
                def covidNoFemale = 0

                def covidMale1
                def covidFemale
                if (end_date && from_date) {
                    noHoldMember = ViewHealthEducation.executeQuery("select sum(h.chaid.members_male), sum(h.chaid.members_female)  from ViewHealthEducation h where  education_type=:education_type  and arrival_time between '" + from_date + "' and '" + end_date + "' and chaid.distric=:districtInstance", [education_type: educationListInstance, districtInstance: districtInstance])[0]

                } else {
                    noHoldMember = ViewHealthEducation.executeQuery("select sum(h.chaid.members_male), sum(h.chaid.members_female) from ViewHealthEducation h where  education_type=:education_type and chaid.distric=:districtInstance", [education_type: educationListInstance, districtInstance: districtInstance])[0]

                }

                if (!noHoldMember[0]) {
                    covidNoMale = 0
                } else {
                    covidNoMale = noHoldMember[0]
                }

                if (!noHoldMember[1]) {
                    covidNoFemale = 0
                } else {
                    covidNoFemale = noHoldMember[1]
                }

            %>
            <td colspan="3">1. Idadi ya wanaume waliopatiwa elimu ya COVID 19</td>
            <td>${covidNoMale}</td>
        </tr>
        <tr>
            <td colspan="3">2. Idadi ya wanawake waliopatiwa elimu ya COVID 19</td>
            <td>${covidNoFemale}</td>
        </tr>
        <tr>
            <td colspan="3">3. Jumla ya watu waliopatiwa elimu ya COVID 19</td>
            <td>${covidNoMale + covidNoFemale}</td>
        </tr>


    </table>
</div>
<g:if test="${type == 'file'}">

<script type="text/javascript">

    var toggler = document.getElementsByClassName("caret");
    var i;
    for (i = 0; i < toggler.length; i++) {
        toggler[i].addEventListener("click", function () {
            this.parentElement.querySelector(".nested").classList.toggle("activee");
            this.classList.toggle("caret-down");
        });
    }
</script>
    </g:if>