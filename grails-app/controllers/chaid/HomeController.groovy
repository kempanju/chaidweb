package chaid

import admin.Dictionary
import admin.DictionaryItem
import admin.District
import admin.Street
import admin.Region
import admin.SubStreet
import admin.Wards
import com.chaid.security.MkpRole
import com.chaid.security.MkpUser
import com.chaid.security.MkpUserMkpRole
import grails.converters.JSON
import grails.gorm.transactions.Transactional
import grails.plugin.springsecurity.annotation.Secured
import org.grails.web.json.JSONArray
import org.grails.web.json.JSONObject

@Secured("isAuthenticated()")
class HomeController {
ApplicationService applicationService
    def springSecurityService

    def index() { }

    @Secured(['ROLE_CORE_WEB','ROLE_ADMIN','ROLE_REGION','ROLE_DISTRICT'])
    def dashboard(){
        session["activePage"] = "dashboard"
        def currentUser=springSecurityService.getCurrentUser()
        def houseHoldMember=materialize.view.HouseHoldData.executeQuery("select sum(totalcount),sum(male_no),sum(female_no) from HouseHoldData ")

        render view:'dashboard',model: [houseHoldMember:houseHoldMember,currentUser:currentUser]
    }
    @Secured(['ROLE_CORE_WEB','ROLE_ADMIN','ROLE_REGION','ROLE_DISTRICT'])
    def dashboardFilter(){
        def selectedOption=params.selectedOption
        if(selectedOption.equals("region")){
            def regionInstance=Region.read(params.region_id)
            def houseHoldMember=materialize.view.HouseHoldData.executeQuery("select sum(totalcount),sum(male_no),sum(female_no) from HouseHoldData where region=:regionInstance ",[regionInstance:regionInstance])

            render template: 'dashboardregion',model: [regionInstance:regionInstance,houseHoldMember:houseHoldMember]
        }else if(selectedOption.equals("district")){

            def village_id=params.village_id
            if(village_id){
                def streetInstance=Street.read(village_id)

                def houseHoldMember=Household.executeQuery("select sum(total_members),sum(male_no),sum(female_no) from Household where village_id=:village_id ",[village_id:streetInstance])
                render template: 'dashboardvillage', model: [streetInstance: streetInstance, houseHoldMember: houseHoldMember]

            }else {
                def districtInstance = District.read(params.district_id)
                def houseHoldMember = materialize.view.HouseHoldData.executeQuery("select sum(totalcount),sum(male_no),sum(female_no) from HouseHoldData where district=:districtInstance ", [districtInstance: districtInstance])

                render template: 'dashboarddistrict', model: [districtInstance: districtInstance, houseHoldMember: houseHoldMember]
            }
        }else{
            def houseHoldMember=materialize.view.HouseHoldData.executeQuery("select sum(totalcount),sum(male_no),sum(female_no) from HouseHoldData ")

            render template: 'dashboardcountry',model: [houseHoldMember:houseHoldMember]

        }
       // render "Done"
    }

    def map(){
        session["activePage"] = "reports"

        render view: 'map'
    }

    def testHql(){
       def houseHoldMember=chaid.Household.executeQuery(" from Household where  subChaids.visit_type.id=7",[max:10])
        println(houseHoldMember.subChaids)
        render "Ok"
    }

    def reportTool(){
        session["activePage"] = "reports"
        render view: "reportTool"
    }

    def monthlyReport(){
        session["activePage"] = "reports"
        render view: "/report/monthlyreport"
    }

    def sendMessage(){
        applicationService.sendMessage("255766545878"," hello")
       // String url="https://apisms.bongolive.africa/v1/send"
       // applicationService.smsSendMessage("255766545878","hello there",url)
        render "Done"
    }
    @Transactional
    def saveChaidData(){
        JSONObject jsonObject=new JSONObject()
        jsonObject.put("user_id",13)
        jsonObject.put("house_hold_id",69)
        jsonObject.put("respondent","Herman Kempanju")
        jsonObject.put("gender","Male")
        jsonObject.put("age",24)
        jsonObject.put("relationship_status","CHAD13CA")
        jsonObject.put("unique_code","4109786759059")
        jsonObject.put("prefer_planning_method","gggghghgh ghghgh")


        jsonObject.put("house_hold_sick_person",1)
        jsonObject.put("house_hold_sick_person_age",35)
        jsonObject.put("care_giver",1)




        JSONObject preginantWomen=new JSONObject()
        preginantWomen.put("last_menstrual","2018-07-01")
        preginantWomen.put("attended_clinic",1)
        preginantWomen.put("child_aged_under_one",1)
        preginantWomen.put("used_planning_method",0)
        preginantWomen.put("prefer_planning_after_delivery",0)

        jsonObject.put("pregnant_woman",preginantWomen)


        JSONObject postDelivery=new JSONObject()
        postDelivery.put("delivery_date","2018-07-01")
        postDelivery.put("card_verification_facility","Dodoma Hospital")
        postDelivery.put("taken_baby_to_clinic",1)
        postDelivery.put("baby_provided_immunization",1)
        postDelivery.put("take_child_clinic",1)
        postDelivery.put("under_five_no",5)
        jsonObject.put("post_delivery",postDelivery)



        JSONObject childUnderFive=new JSONObject()
        childUnderFive.put("last_date","2018-07-01")
        childUnderFive.put("baby_provided_immunization",1)
        childUnderFive.put("take_child_clinic",1)
        childUnderFive.put("under_five_no",5)
        jsonObject.put("child_under_five",childUnderFive)




        JSONArray jsonArray=new JSONArray()

        JSONObject answersObject=new JSONObject()
        answersObject.put("code","CHAD4")
        answersObject.put("answer_code","CHAD4B")
        answersObject.put("comment"," None")
        jsonArray.put(answersObject)

      /*  JSONObject answersObject4=new JSONObject()
        answersObject4.put("code","CHAD4")
        answersObject4.put("answer_code","CHAD4B")
        answersObject4.put("comment"," None")
        jsonArray.put(answersObject4)*/

        JSONObject answersObject5=new JSONObject()
        answersObject5.put("code","CHAD5")
        answersObject5.put("answer_code","CHAD5C")
        answersObject5.put("comment"," None")
        jsonArray.put(answersObject5)


        JSONObject answersObject6=new JSONObject()
        answersObject6.put("code","CHAD6")
        answersObject6.put("answer_code","CHAD6C,CHAD6B")
        answersObject6.put("comment"," None")

        jsonArray.put(answersObject6)


        JSONObject answersObject7=new JSONObject()
        answersObject7.put("code","CHAD7")
        answersObject7.put("answer_code","CHAD7A,CHAD7B")
        answersObject7.put("comment"," None")
        jsonArray.put(answersObject7)

        JSONObject answersObject11=new JSONObject()
        answersObject11.put("code","CHAD11")
        answersObject11.put("answer_code","CHAD11A")
        answersObject11.put("comment"," None")
        jsonArray.put(answersObject11)

        JSONObject answersObject14=new JSONObject()
        answersObject14.put("code","CHAD14")
        answersObject14.put("answer_code","CHAD14A")
        answersObject14.put("comment"," None")
        jsonArray.put(answersObject14)

        JSONObject answersObject16=new JSONObject()
        answersObject16.put("code","CHAD16")

        JSONArray answers=new JSONArray()
        JSONObject houseCategory=new JSONObject()
        houseCategory.put("code","CHAD16A")
        houseCategory.put("member_no",4)
        answers.put(houseCategory)
        JSONObject houseCategory1=new JSONObject()
        houseCategory1.put("code","CHAD16B")
        houseCategory1.put("member_no",3)
        answers.put(houseCategory1)



        answersObject16.put("answer_code",answers)
        answersObject16.put("comment","John Alex")
        jsonArray.put(answersObject16)

        JSONObject answersObject17=new JSONObject()
        answersObject17.put("code","CHAD17")
        answersObject17.put("answer_code","CHAD17A,CHAD17B")
        answersObject17.put("comment","John Alex")
        jsonArray.put(answersObject17)


        JSONObject answersObject18=new JSONObject()
        answersObject18.put("code","CHAD18B")
        answersObject18.put("answer_code","CHAD18BA,CHAD18BB")
        answersObject18.put("comment","John Alex")
        jsonArray.put(answersObject18)


        JSONObject answersObject18D=new JSONObject()
        answersObject18D.put("code","CHAD18D")
        answersObject18D.put("answer_code","CHAD18DA")
        answersObject18D.put("comment","John Alex")
        jsonArray.put(answersObject18D)


        JSONObject answersObject18F=new JSONObject()
        answersObject18F.put("code","CHAD18F")
        answersObject18F.put("answer_code","CHAD18FA")
        answersObject18F.put("comment","John Alex")
        jsonArray.put(answersObject18F)

        JSONObject answersObject19=new JSONObject()
        answersObject19.put("code","CHAD19")
        answersObject19.put("answer_code","CHAD19A")
        answersObject19.put("comment","John Alex")
        jsonArray.put(answersObject19)

        JSONObject answersObject22=new JSONObject()
        answersObject22.put("code","CHAD22")
        answersObject22.put("answer_code","CHAD22B")
        answersObject22.put("comment","")
        jsonArray.put(answersObject22)


        JSONObject answersObject22B=new JSONObject()
        answersObject22B.put("code","CHAD22B")
        answersObject22B.put("answer_code","CHAD22BA")
        answersObject22B.put("comment","")
        jsonArray.put(answersObject22B)

        JSONObject answersObject23A=new JSONObject()
        answersObject23A.put("code","CHAD23A")
        answersObject23A.put("answer_code","CHAD23AB")
        answersObject23A.put("comment","")
        jsonArray.put(answersObject23A)

        JSONObject answersObject23B=new JSONObject()
        answersObject23B.put("code","CHAD23B")
        answersObject23B.put("answer_code","CHAD23BA")
        answersObject23B.put("comment","")
        jsonArray.put(answersObject23B)


        JSONObject answersObject23C=new JSONObject()
        answersObject23C.put("code","CHAD23C")
        answersObject23C.put("answer_code","CHAD23CA")
        answersObject23C.put("comment","")
        jsonArray.put(answersObject23C)


        JSONObject answersObject23D=new JSONObject()
        answersObject23D.put("code","CHAD23D")
        answersObject23D.put("answer_code","CHAD23DA")
        answersObject23D.put("comment","")
        jsonArray.put(answersObject23D)



        JSONObject answersObject25=new JSONObject()
        answersObject25.put("code","CHAD25")
        answersObject25.put("answer_code","CHAD25A,CHAD25B")
        answersObject25.put("comment"," None")
        jsonArray.put(answersObject25)



        JSONObject answersObject26=new JSONObject()
        answersObject26.put("code","CHAD26")
        answersObject26.put("answer_code","CHAD26A,CHAD26B")
        answersObject26.put("comment"," None")
        jsonArray.put(answersObject26)


        JSONObject answersObject27B=new JSONObject()
        answersObject27B.put("code","CHAD27B")
        answersObject27B.put("answer_code","CHAD27BA,CHAD27BB")
        answersObject27B.put("comment"," None")
        jsonArray.put(answersObject27B)

        JSONObject answersObject28=new JSONObject()
        answersObject28.put("code","CHAD28")
        answersObject28.put("answer_code","CHAD28A,CHAD28B")
        answersObject28.put("comment"," None")
        jsonArray.put(answersObject28)


        JSONObject answersObject29=new JSONObject()
        answersObject29.put("code","CHAD29")
        answersObject29.put("answer_code","CHAD29A,CHAD29B")
        answersObject29.put("comment"," None")
        jsonArray.put(answersObject29)


        JSONObject answersObject32A=new JSONObject()
        answersObject32A.put("code","CHAD32A")
        answersObject32A.put("answer_code","CHAD32AA,CHAD32AB")
        answersObject32A.put("comment"," None")
        jsonArray.put(answersObject32A)


        JSONObject answersObject32E=new JSONObject()
        answersObject32E.put("code","CHAD32E")
        answersObject32E.put("answer_code","CHAD32EA,CHAD32EB")
        answersObject32E.put("comment"," None")
        jsonArray.put(answersObject32E)

        JSONObject answersObject33C=new JSONObject()
        answersObject33C.put("code","CHAD33C")
        answersObject33C.put("answer_code","CHAD33CA")
        answersObject33C.put("comment"," None")
        jsonArray.put(answersObject33C)

        JSONObject answersObject33B=new JSONObject()
        answersObject33B.put("code","CHAD33B")
        answersObject33B.put("answer_code","CHAD33BA,CHAD33BB")
        answersObject33B.put("comment"," None")
        jsonArray.put(answersObject32E)


        JSONObject answersObject33D=new JSONObject()
        answersObject33D.put("code","CHAD33D")
        answersObject33D.put("answer_code","CHAD33DA,CHAD33DB")
        answersObject33D.put("comment"," None")
        jsonArray.put(answersObject33D)



        JSONObject answersObject34=new JSONObject()
        answersObject34.put("code","CHAD34")
        answersObject34.put("answer_code","CHAD34A,CHAD34B")
        answersObject34.put("comment"," None")
        jsonArray.put(answersObject34)



        jsonObject.put("results",jsonArray)

        applicationService.saveChaid(jsonObject.toString())

        println(jsonObject.toString())

    render(" Done")

    }

    @Transactional
    def chadStatusApi(){
        println(params)
        def userID=params.user_id
        def comment=params.comment
        def chaidCode=params.code
        def chaidID=params.chad_id

        def userInstance=MkpUser.get(userID)
        def chadInstanceMain=MkChaid.get(chaidID)
        def dictionaryInstance=DictionaryItem.findByCode(chaidCode)

        def chadInstance=new ChadStatus();
        chadInstance.createdBy=userInstance
        chadInstance.chaid=chadInstanceMain
        chadInstance.comment=comment
        chadInstance.status=dictionaryInstance
        if(chadInstance.save(failOnError:true)){
            String message="Name: "+chadInstanceMain.respondent_name+"\\nVillage: "+chadInstanceMain?.household?.village_id?.name+"\\n" +
                    "Hamlets: "+chadInstanceMain?.household?.street?.name+"\\nStatus: "+dictionaryInstance.name+"\\nReference: "+chadInstanceMain.reg_no+"\\nHousehold: "+chadInstanceMain.household.full_name+". "


            applicationService.saveSchedualLogs(chadInstanceMain.created_by,message)

            MkChaid.executeUpdate("update MkChaid set emergence_status=2 where id=:id",[id:chadInstanceMain.id])

        }
        render "Done"
    }

    def reportByRegistered(){
        session["activePage"] = "reports"

        render view: 'registered'
    }

    def reportByReached(){
        session["activePage"] = "reports"

        render view: 'reached'
    }

    def registeredReport(){
        String facility=params.facility
        def pregnantWomanNo=0


       // def breastFeedingLess=0
        def breastFeedingMother=0
        def neonates=0
        def infants=0
        def childrenUnder5=0
        def childTenToNinteenGirl=0
        def childTenToNinteenBoys=0
        def totalTenToNinteen=0

        def childYouthGirl=0
        def childYouthBoys=0

        def totalchildYouth=0

        def fifteenToFourtyGirl=0
        def fifteenToFourtyBoy=0
        def totalfifteenToFourty=0

        def above50Girl=0
        def above50Boy=0
        def totalAbove=50



        // def childrenUnderNotImmnunized=0



        //def childrenUnderNotImmnunized=CategoryAvailableChildren.countByBaby_provided_immunization(false)


        if(facility){
            def facilityInstance=Facility.get(params.facility)
            if(facilityInstance) {
                pregnantWomanNo = HouseholdDetails.executeQuery("select sum(member_no)   from HouseholdDetails where detailsType=:detailsType and  household.deleted=false and household.facility=:facility ",[detailsType:DictionaryItem.findByCode("CHAD16A"),facility:facilityInstance])[0]
                breastFeedingMother = HouseholdDetails.executeQuery("select sum(member_no) from HouseholdDetails where detailsType=:detailsType and household.deleted=false and household.facility=:facility",[detailsType:DictionaryItem.findByCode("CHAD16B"),facility:facilityInstance])[0]


                neonates = HouseholdDetails.executeQuery("select sum(member_no) from HouseholdDetails where detailsType=:detailsType   and  household.deleted=false and household.facility=:facility  ",[detailsType:DictionaryItem.findByCode("CHAD16C"),facility:facilityInstance])[0]
                infants = HouseholdDetails.executeQuery("select sum(member_no) from HouseholdDetails where detailsType=:detailsType and  household.deleted=false and household.facility=:facility ",[detailsType:DictionaryItem.findByCode("CHAD16D"),facility:facilityInstance])[0]
                childrenUnder5 = HouseholdDetails.executeQuery("select sum(member_no) from HouseholdDetails where detailsType=:detailsType and  household.deleted=false and household.facility=:facility  ",[detailsType:DictionaryItem.findByCode("CHAD16E"),facility:facilityInstance])[0]
                childTenToNinteenGirl = HouseholdDetails.executeQuery("select sum(member_no) from HouseholdDetails where detailsType=:detailsType and  household.deleted=false and household.facility=:facility ",[detailsType:DictionaryItem.findByCode("CHAD16F"),facility:facilityInstance])[0]
                childTenToNinteenBoys = HouseholdDetails.executeQuery("select sum(member_no) from HouseholdDetails where detailsType=:detailsType and  household.deleted=false and household.facility=:facility ",[detailsType:DictionaryItem.findByCode("CHAD16G"),facility:facilityInstance])[0]
                if(!childTenToNinteenGirl){
                    childTenToNinteenGirl=0
                }
                if(!childTenToNinteenBoys){
                    childTenToNinteenBoys=0
                }
                totalTenToNinteen=childTenToNinteenGirl+childTenToNinteenBoys

                childYouthGirl = HouseholdDetails.executeQuery("select sum(member_no) from HouseholdDetails where detailsType=:detailsType and  household.deleted=false and household.facility=:facility ",[detailsType:DictionaryItem.findByCode("CHAD16H"),facility:facilityInstance])[0]
                childYouthBoys = HouseholdDetails.executeQuery("select sum(member_no) from HouseholdDetails where detailsType=:detailsType and  household.deleted=false and household.facility=:facility ",[detailsType:DictionaryItem.findByCode("CHAD16I"),facility:facilityInstance])[0]

                if(!childYouthGirl){
                    childYouthGirl=0
                }
                if(!childYouthBoys){
                    childYouthBoys=0
                }

                totalchildYouth=childYouthGirl+childYouthBoys

                fifteenToFourtyGirl = HouseholdDetails.executeQuery("select sum(member_no) from HouseholdDetails where detailsType=:detailsType and  household.deleted=false and household.facility=:facility ",[detailsType:DictionaryItem.findByCode("CHAD16J"),facility:facilityInstance])[0]
                fifteenToFourtyBoy = HouseholdDetails.executeQuery("select sum(member_no) from HouseholdDetails where detailsType=:detailsType and  household.deleted=false and household.facility=:facility ",[detailsType:DictionaryItem.findByCode("CHAD16K"),facility:facilityInstance])[0]

                if(!fifteenToFourtyGirl){
                    fifteenToFourtyGirl=0
                }
                if(!fifteenToFourtyBoy){
                    fifteenToFourtyBoy=0
                }

                totalfifteenToFourty=fifteenToFourtyGirl+fifteenToFourtyBoy

                above50Girl = HouseholdDetails.executeQuery("select sum(member_no) from HouseholdDetails where detailsType=:detailsType and  household.deleted=false and household.facility=:facility ",[detailsType:DictionaryItem.findByCode("CHAD16M"),facility:facilityInstance])[0]
                above50Boy = HouseholdDetails.executeQuery("select sum(member_no) from HouseholdDetails where detailsType=:detailsType and  household.deleted=false and household.facility=:facility ",[detailsType:DictionaryItem.findByCode("CHAD16L"),facility:facilityInstance])[0]
                if(!above50Girl){
                    above50Girl=0
                }
                if(!above50Boy){
                    above50Boy=0
                }

                totalAbove=above50Girl+above50Boy


            }
        }else {
            pregnantWomanNo = HouseholdDetails.executeQuery("select sum(member_no)   from HouseholdDetails where detailsType=:detailsType and  household.deleted=false  ",[detailsType:DictionaryItem.findByCode("CHAD16A")])[0]
            breastFeedingMother = HouseholdDetails.executeQuery("select sum(member_no) from HouseholdDetails where detailsType=:detailsType and household.deleted=false ",[detailsType:DictionaryItem.findByCode("CHAD16B")])[0]


            neonates = HouseholdDetails.executeQuery("select sum(member_no) from HouseholdDetails where detailsType=:detailsType   and  household.deleted=false  ",[detailsType:DictionaryItem.findByCode("CHAD16C")])[0]
            infants = HouseholdDetails.executeQuery("select sum(member_no) from HouseholdDetails where detailsType=:detailsType and  household.deleted=false  ",[detailsType:DictionaryItem.findByCode("CHAD16D")])[0]
            childrenUnder5 = HouseholdDetails.executeQuery("select sum(member_no) from HouseholdDetails where detailsType=:detailsType and  household.deleted=false   ",[detailsType:DictionaryItem.findByCode("CHAD16E")])[0]
            childTenToNinteenGirl = HouseholdDetails.executeQuery("select sum(member_no) from HouseholdDetails where detailsType=:detailsType and  household.deleted=false  ",[detailsType:DictionaryItem.findByCode("CHAD16F")])[0]
            childTenToNinteenBoys = HouseholdDetails.executeQuery("select sum(member_no) from HouseholdDetails where detailsType=:detailsType and  household.deleted=false  ",[detailsType:DictionaryItem.findByCode("CHAD16G")])[0]

            if(!childTenToNinteenGirl){
                childTenToNinteenGirl=0
            }
            if(!childTenToNinteenBoys){
                childTenToNinteenBoys=0
            }
            totalTenToNinteen=childTenToNinteenGirl+childTenToNinteenBoys

            childYouthGirl = HouseholdDetails.executeQuery("select sum(member_no) from HouseholdDetails where detailsType=:detailsType and  household.deleted=false ",[detailsType:DictionaryItem.findByCode("CHAD16H")])[0]
            childYouthBoys = HouseholdDetails.executeQuery("select sum(member_no) from HouseholdDetails where detailsType=:detailsType and  household.deleted=false  ",[detailsType:DictionaryItem.findByCode("CHAD16I")])[0]
            if(!childYouthGirl){
                childYouthGirl=0
            }
            if(!childYouthBoys){
                childYouthBoys=0
            }

            totalchildYouth=childYouthGirl+childYouthBoys


            fifteenToFourtyGirl = HouseholdDetails.executeQuery("select sum(member_no) from HouseholdDetails where detailsType=:detailsType and  household.deleted=false  ",[detailsType:DictionaryItem.findByCode("CHAD16J")])[0]
            fifteenToFourtyBoy = HouseholdDetails.executeQuery("select sum(member_no) from HouseholdDetails where detailsType=:detailsType and  household.deleted=false  ",[detailsType:DictionaryItem.findByCode("CHAD16K")])[0]
            if(!fifteenToFourtyGirl){
                fifteenToFourtyGirl=0
            }
            if(!fifteenToFourtyBoy){
                fifteenToFourtyBoy=0
            }
            totalfifteenToFourty=fifteenToFourtyGirl+fifteenToFourtyBoy


            above50Girl = HouseholdDetails.executeQuery("select sum(member_no) from HouseholdDetails where detailsType=:detailsType and  household.deleted=false  ",[detailsType:DictionaryItem.findByCode("CHAD16M")])[0]
            above50Boy = HouseholdDetails.executeQuery("select sum(member_no) from HouseholdDetails where detailsType=:detailsType and  household.deleted=false  ",[detailsType:DictionaryItem.findByCode("CHAD16L")])[0]

            if(!above50Girl){
                above50Girl=0
            }
            if(!above50Boy){
                above50Boy=0
            }

            totalAbove=above50Girl+above50Boy


        }


        JSONObject jsonObject=new JSONObject()
        jsonObject.put("pregnant_no",pregnantWomanNo)
        jsonObject.put("breast_feeding",breastFeedingMother)
        jsonObject.put("neonates_no",neonates)
        jsonObject.put("infants_no",infants)
        jsonObject.put("children_under_five_no",childrenUnder5)
        jsonObject.put("breastFeedingMother",breastFeedingMother)
        jsonObject.put("totalTenToNinteen",totalTenToNinteen)
        jsonObject.put("totalchildYouth",totalchildYouth)
        jsonObject.put("totalfifteenToFourty",totalfifteenToFourty)
        jsonObject.put("totalAbove",totalAbove)

        JSONObject outPutObject=new JSONObject()
        outPutObject.put("registered",jsonObject)
        render outPutObject as JSON
    }

    def reachedReport(){

        String facility=params.facility
        def start_date=params.start_date
        def end_date=params.end_date


        def pregnantWomanNo=0
         def breastFeedingMotherLess=0
        def breastFeedingMotherAbove=0
        def neonates=0
        def infants=0
        def childrenUnder5=0
        def childTenToNinteenGirl=0
        def childTenToNinteenBoys=0
        def totalTenToNinteen=0

        def childYouthGirl=0
        def childYouthBoys=0

        def totalchildYouth=0

        def fifteenToFourtyGirl=0
        def fifteenToFourtyBoy=0
        def totalfifteenToFourty=0

        def above50Girl=0
        def above50Boy=0
        def totalAbove=50



        def childrenUnderNotImmnunized=0



        //def childrenUnderNotImmnunized=CategoryAvailableChildren.countByBaby_provided_immunization(false)


        if(facility){
            def facilityInstance=Facility.get(params.facility)
            if(facilityInstance) {
                pregnantWomanNo = AvailableMemberHouse.executeQuery("select sum(member_no)   from AvailableMemberHouse where type_id=:detailsType and  chaid.deleted=false and chaid.facility=:facility ",[detailsType:DictionaryItem.findByCode("CHAD17A"),facility:facilityInstance])[0]
                breastFeedingMotherLess = AvailableMemberHouse.executeQuery("select sum(member_no) from AvailableMemberHouse where type_id=:detailsType and chaid.deleted=false and chaid.facility=:facility",[detailsType:DictionaryItem.findByCode("CHAD17B"),facility:facilityInstance])[0]
                breastFeedingMotherAbove = AvailableMemberHouse.executeQuery("select sum(member_no) from AvailableMemberHouse where type_id=:detailsType and chaid.deleted=false and chaid.facility=:facility",[detailsType:DictionaryItem.findByCode("CHAD17C"),facility:facilityInstance])[0]



                neonates = CategoryAvailableChildren.executeQuery("from CategoryAvailableChildren where categoryType=:categoryType  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.facility=:facility ",[categoryType:DictionaryItem.findByCode("CHAD17D"),facility:facilityInstance]).size()
                infants = CategoryAvailableChildren.executeQuery("from CategoryAvailableChildren where categoryType=:categoryType  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.facility=:facility ",[categoryType:DictionaryItem.findByCode("CHAD17E"),facility:facilityInstance]).size()
                childrenUnder5 = CategoryAvailableChildren.executeQuery("from CategoryAvailableChildren where categoryType=:categoryType  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.facility=:facility ",[categoryType:DictionaryItem.findByCode("CHAD17F"),facility:facilityInstance]).size()
                childrenUnderNotImmnunized = CategoryAvailableChildren.executeQuery("from CategoryAvailableChildren where baby_provided_immunization=false  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.facility=:facility ",[facility:facilityInstance]).size()


                childTenToNinteenGirl = AvailableMemberHouse.executeQuery("select sum(member_no) from AvailableMemberHouse where type_id=:detailsType and  chaid.deleted=false and chaid.facility=:facility ",[detailsType:DictionaryItem.findByCode("CHAD17G"),facility:facilityInstance])[0]
                childTenToNinteenBoys = AvailableMemberHouse.executeQuery("select sum(member_no) from AvailableMemberHouse where type_id=:detailsType and  chaid.deleted=false and chaid.facility=:facility ",[detailsType:DictionaryItem.findByCode("CHAD17H"),facility:facilityInstance])[0]
                if(!childTenToNinteenGirl){
                    childTenToNinteenGirl=0
                }
                if(!childTenToNinteenBoys){
                    childTenToNinteenBoys=0
                }
                totalTenToNinteen=childTenToNinteenGirl+childTenToNinteenBoys

                childYouthGirl = AvailableMemberHouse.executeQuery("select sum(member_no) from AvailableMemberHouse where type_id=:detailsType and  chaid.deleted=false and chaid.facility=:facility ",[detailsType:DictionaryItem.findByCode("CHAD17I"),facility:facilityInstance])[0]
                childYouthBoys = AvailableMemberHouse.executeQuery("select sum(member_no) from AvailableMemberHouse where type_id=:detailsType and  chaid.deleted=false and chaid.facility=:facility ",[detailsType:DictionaryItem.findByCode("CHAD17J"),facility:facilityInstance])[0]

                if(!childYouthGirl){
                    childYouthGirl=0
                }
                if(!childYouthBoys){
                    childYouthBoys=0
                }

                totalchildYouth=childYouthGirl+childYouthBoys

                fifteenToFourtyGirl = AvailableMemberHouse.executeQuery("select sum(member_no) from AvailableMemberHouse where type_id=:detailsType and  chaid.deleted=false and chaid.facility=:facility ",[detailsType:DictionaryItem.findByCode("CHAD17K"),facility:facilityInstance])[0]
                fifteenToFourtyBoy = AvailableMemberHouse.executeQuery("select sum(member_no) from AvailableMemberHouse where type_id=:detailsType and  chaid.deleted=false and chaid.facility=:facility ",[detailsType:DictionaryItem.findByCode("CHAD17L"),facility:facilityInstance])[0]

                if(!fifteenToFourtyGirl){
                    fifteenToFourtyGirl=0
                }
                if(!fifteenToFourtyBoy){
                    fifteenToFourtyBoy=0
                }

                totalfifteenToFourty=fifteenToFourtyGirl+fifteenToFourtyBoy

                above50Girl = AvailableMemberHouse.executeQuery("select sum(member_no) from AvailableMemberHouse where type_id=:detailsType and  chaid.deleted=false and chaid.facility=:facility ",[detailsType:DictionaryItem.findByCode("CHAD16M"),facility:facilityInstance])[0]
                above50Boy = AvailableMemberHouse.executeQuery("select sum(member_no) from AvailableMemberHouse where type_id=:detailsType and  chaid.deleted=false and chaid.facility=:facility ",[detailsType:DictionaryItem.findByCode("CHAD16L"),facility:facilityInstance])[0]
                if(!above50Girl){
                    above50Girl=0
                }
                if(!above50Boy){
                    above50Boy=0
                }

                totalAbove=above50Girl+above50Boy


            }
        }else {
            pregnantWomanNo = AvailableMemberHouse.executeQuery("select sum(member_no)   from AvailableMemberHouse where type_id=:detailsType and  chaid.deleted=false  ",[detailsType:DictionaryItem.findByCode("CHAD17A")])[0]
            breastFeedingMotherLess = AvailableMemberHouse.executeQuery("select sum(member_no) from AvailableMemberHouse where type_id=:detailsType and chaid.deleted=false ",[detailsType:DictionaryItem.findByCode("CHAD17B")])[0]
            breastFeedingMotherAbove = AvailableMemberHouse.executeQuery("select sum(member_no) from AvailableMemberHouse where type_id=:detailsType and chaid.deleted=false ",[detailsType:DictionaryItem.findByCode("CHAD17C")])[0]


            neonates = CategoryAvailableChildren.countByCategoryType(DictionaryItem.findByCode("CHAD17D"))
            infants = CategoryAvailableChildren.countByCategoryType(DictionaryItem.findByCode("CHAD17E"))
            childrenUnder5 = CategoryAvailableChildren.countByCategoryType(DictionaryItem.findByCode("CHAD17F"))
            childrenUnderNotImmnunized = CategoryAvailableChildren.executeQuery("from CategoryAvailableChildren where baby_provided_immunization=false  and availableMemberHouse.chaid.deleted=false ").size()


            childTenToNinteenGirl = AvailableMemberHouse.executeQuery("select sum(member_no) from AvailableMemberHouse where type_id=:detailsType and  chaid.deleted=false  ",[detailsType:DictionaryItem.findByCode("CHAD17G")])[0]
            childTenToNinteenBoys = AvailableMemberHouse.executeQuery("select sum(member_no) from AvailableMemberHouse where type_id=:detailsType and  chaid.deleted=false  ",[detailsType:DictionaryItem.findByCode("CHAD17H")])[0]

            if(!childTenToNinteenGirl){
                childTenToNinteenGirl=0
            }
            if(!childTenToNinteenBoys){
                childTenToNinteenBoys=0
            }
            totalTenToNinteen=childTenToNinteenGirl+childTenToNinteenBoys

            childYouthGirl = AvailableMemberHouse.executeQuery("select sum(member_no) from AvailableMemberHouse where type_id=:detailsType and  chaid.deleted=false ",[detailsType:DictionaryItem.findByCode("CHAD17I")])[0]
            childYouthBoys = AvailableMemberHouse.executeQuery("select sum(member_no) from AvailableMemberHouse where type_id=:detailsType and  chaid.deleted=false  ",[detailsType:DictionaryItem.findByCode("CHAD17J")])[0]
            if(!childYouthGirl){
                childYouthGirl=0
            }
            if(!childYouthBoys){
                childYouthBoys=0
            }

            totalchildYouth=childYouthGirl+childYouthBoys


            fifteenToFourtyGirl = AvailableMemberHouse.executeQuery("select sum(member_no) from AvailableMemberHouse where type_id=:detailsType and  chaid.deleted=false  ",[detailsType:DictionaryItem.findByCode("CHAD17K")])[0]
            fifteenToFourtyBoy = AvailableMemberHouse.executeQuery("select sum(member_no) from AvailableMemberHouse where type_id=:detailsType and  chaid.deleted=false  ",[detailsType:DictionaryItem.findByCode("CHAD17L")])[0]
            if(!fifteenToFourtyGirl){
                fifteenToFourtyGirl=0
            }
            if(!fifteenToFourtyBoy){
                fifteenToFourtyBoy=0
            }
            totalfifteenToFourty=fifteenToFourtyGirl+fifteenToFourtyBoy


            above50Girl = AvailableMemberHouse.executeQuery("select sum(member_no) from AvailableMemberHouse where type_id=:detailsType and  chaid.deleted=false  ",[detailsType:DictionaryItem.findByCode("CHAD17N")])[0]
            above50Boy = AvailableMemberHouse.executeQuery("select sum(member_no) from AvailableMemberHouse where type_id=:detailsType and  chaid.deleted=false  ",[detailsType:DictionaryItem.findByCode("CHAD17M")])[0]

            if(!above50Girl){
                above50Girl=0
            }
            if(!above50Boy){
                above50Boy=0
            }

            totalAbove=above50Girl+above50Boy


        }


        JSONObject jsonObject=new JSONObject()
        jsonObject.put("pregnant_no",pregnantWomanNo)
        //jsonObject.put("breast_feeding",breastFeedingMother)
        jsonObject.put("neonates_no",neonates)
        jsonObject.put("infants_no",infants)
        jsonObject.put("children_under_five_no",childrenUnder5)
        jsonObject.put("breastFeedingMotherLess",breastFeedingMotherLess)
        jsonObject.put("breastFeedingMotherAbove",breastFeedingMotherAbove)
        jsonObject.put("childrenUnderNotImmnunized",childrenUnderNotImmnunized)
        jsonObject.put("totalTenToNinteen",totalTenToNinteen)
        jsonObject.put("totalchildYouth",totalchildYouth)
        jsonObject.put("totalfifteenToFourty",totalfifteenToFourty)
        jsonObject.put("totalAbove",totalAbove)

        JSONObject outPutObject=new JSONObject()
        outPutObject.put("registered",jsonObject)
        render outPutObject as JSON
    }



    def reachedReportOld(){
      //  childrenUnderNotImmnunized = HouseholdDetails.executeQuery("from CategoryAvailableChildren where baby_provided_immunization=false  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.facility=:facility ",[facility:facilityInstance]).size()

        String facility=params.facility
        def pregnantWomanNo=0
        def breastFeedingLess=0
        def breastFeedingAbove=0
        def neonates=0
        def infants=0
        def childrenUnder5=0
        def childrenUnderNotImmnunized=0



        //def childrenUnderNotImmnunized=CategoryAvailableChildren.countByBaby_provided_immunization(false)


        if(facility){
            def facilityInstance=Facility.get(params.facility)
            if(facilityInstance) {
                pregnantWomanNo = PreginantDetails.executeQuery("from PreginantDetails where   chaid.deleted=false and chaid.facility=:facility ",[facility:facilityInstance]).size()
                breastFeedingLess = PostDelivery.executeQuery("from PostDelivery where child_age_days<=42  and chaid.deleted=false and chaid.facility=:facility",[facility:facilityInstance]).size()
                breastFeedingAbove = PostDelivery.executeQuery("from PostDelivery where child_age_days>42  and chaid.deleted=false and chaid.facility=:facility",[facility:facilityInstance]).size()


                neonates = HouseholdDetails.executeQuery("from CategoryAvailableChildren where categoryType=:categoryType  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.facility=:facility ",[categoryType:DictionaryItem.findByCode("CHAD17D"),facility:facilityInstance]).size()
                infants = HouseholdDetails.executeQuery("from CategoryAvailableChildren where categoryType=:categoryType  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.facility=:facility ",[categoryType:DictionaryItem.findByCode("CHAD17E"),facility:facilityInstance]).size()
                childrenUnder5 = HouseholdDetails.executeQuery("from CategoryAvailableChildren where categoryType=:categoryType  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.facility=:facility ",[categoryType:DictionaryItem.findByCode("CHAD17F"),facility:facilityInstance]).size()
                childrenUnderNotImmnunized = HouseholdDetails.executeQuery("from CategoryAvailableChildren where baby_provided_immunization=false  and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.facility=:facility ",[facility:facilityInstance]).size()


            }
        }else {
            pregnantWomanNo = PreginantDetails.executeQuery("from PreginantDetails where  chaid.deleted=false").size()
            breastFeedingLess = PostDelivery.executeQuery("from PostDelivery where child_age_days<=42  and chaid.deleted=false").size()
            breastFeedingAbove = PostDelivery.executeQuery("from PostDelivery where child_age_days>42  and chaid.deleted=false").size()


            neonates = CategoryAvailableChildren.countByCategoryType(DictionaryItem.findByCode("CHAD17D"))
            infants = CategoryAvailableChildren.countByCategoryType(DictionaryItem.findByCode("CHAD17E"))
            childrenUnder5 = CategoryAvailableChildren.countByCategoryType(DictionaryItem.findByCode("CHAD17F"))
            childrenUnderNotImmnunized = CategoryAvailableChildren.executeQuery("from CategoryAvailableChildren where baby_provided_immunization=false  and availableMemberHouse.chaid.deleted=false ").size()


            //    def maleAgeBetweenNo=AvailableMemberHouse.executeQuery("select sum(member_no)  from AvailableMemberHouse where type_id=:categoryType  and chaid.deleted=false and chaid.street=:village ",[categoryType:admin.DictionaryItem.findByCode("CHAD17K"),village:villageListInstance])

        }


        JSONObject jsonObject=new JSONObject()
        jsonObject.put("pregnant_no",pregnantWomanNo)
        jsonObject.put("breast_feeding_less_no",breastFeedingLess)
        jsonObject.put("breast_feeding_above_no",breastFeedingAbove)
        jsonObject.put("neonates_no",neonates)
        jsonObject.put("infants_no",infants)
        jsonObject.put("children_under_five_no",childrenUnder5)
        jsonObject.put("children_under_five_not_immunized",childrenUnderNotImmnunized)

        JSONObject outPutObject=new JSONObject()
        outPutObject.put("registered",jsonObject)
        render outPutObject as JSON
    }

    def reachedReportByDate() {
        String start_date=params.start_date
        def end_date=params.end_date
        // def  startDate=Date.parse("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",start_date,TimeZone.getTimeZone("UTC"))
        //println(startDate.toString())
        def formatedStartDate=applicationService.changeTimeZOne(start_date)
        def formatedEndDate=applicationService.changeTimeZOne(end_date)
        def facility=params.facility
        def  outPutObject=applicationService.reachedReportByDate(facility,formatedStartDate,formatedEndDate)

        render outPutObject as JSON
    }

    def registeredReportByDate(){
        println(params)
        String start_date=params.start_date
        def end_date=params.end_date
       // def  startDate=Date.parse("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",start_date,TimeZone.getTimeZone("UTC"))
        //println(startDate.toString())
        def formatedStartDate=applicationService.changeTimeZOne(start_date)
        def formatedEndDate=applicationService.changeTimeZOne(end_date)
        def facility=params.facility
       def  outPutObject=applicationService.registeredReportByDate(facility,formatedStartDate,formatedEndDate)
        println(outPutObject)

        render outPutObject as JSON
    }

    def chwActivity(){
        session["activePage"] = "reports"
        def currentUser = springSecurityService.getCurrentUser()

        render view: 'chwactivity',model: [currentUser:currentUser]
    }
    def chwReferral(){
        session["activePage"] = "reports"
        def currentUser = springSecurityService.getCurrentUser()

        render view: 'chwreferral',model: [currentUser:currentUser]
    }
    def reportByCwaActivityJSON(){
        JSONArray jsonArray=new JSONArray()
        def roleInstance= MkpRole.findByAuthority("ROLE_CHW")
        def district=params.district
        def village=params.village
        if (springSecurityService.principal.authorities.any { it.authority == 'ROLE_DISTRICT'}){
            def currentUser=springSecurityService.getCurrentUser()
            district=currentUser?.district_id?.id
          //  println("DOne:"+district)
        }


        def start_date=params.start_date
        def end_date=params.end_date
        def userList=null
        if(district){
            if(village){
                def villageInstance=Street.read(village)
                userList = MkpUserMkpRole.executeQuery("from MkpUserMkpRole where mkpRole=:mkpRole and mkpUser.village_id=:villageInstance", [mkpRole: roleInstance, villageInstance: villageInstance])

            }else {
                def districtInstance = District.read(district)
                userList = MkpUserMkpRole.executeQuery("from MkpUserMkpRole where mkpRole=:mkpRole and mkpUser.district_id=:district", [mkpRole: roleInstance, district: districtInstance])
            }
        }else{
            if (springSecurityService.principal.authorities.any { it.authority == 'ROLE_REGION'}) {
                def currentUser=springSecurityService.getCurrentUser()

                userList=MkpUserMkpRole.executeQuery("from MkpUserMkpRole where mkpRole=:mkpRole and mkpUser.district_id.region_id=:region",[mkpRole:roleInstance,region:currentUser.region])

            }else{
                userList = MkpUserMkpRole.findAllByMkpRole(roleInstance)

            }
        }


        userList.each{
            def userInstance=it.mkpUser
            JSONObject jsonObject=new JSONObject()
            jsonObject.put("full_name",userInstance.full_name)
            jsonObject.put("id",userInstance.id)

            jsonObject.put("village",userInstance?.village_id?.name)
            jsonObject.put("facility",userInstance?.facility?.name)
            def chaidCount=0
            if(start_date&&end_date){
                def formatedStartDate=applicationService.changeTimeZOne(start_date)
                def formatedEndDate=applicationService.changeTimeZOne(end_date)

                chaidCount=MkChaid.executeQuery("from MkChaid where deleted=false and created_by=:createdBy and arrival_time>='"+formatedStartDate+"' and arrival_time<='"+formatedEndDate+"'",[createdBy:userInstance]).size()
            }else {
                chaidCount = MkChaid.countByDeletedAndCreated_by(false, userInstance)
            }
            jsonObject.put("report_no",chaidCount)
            jsonArray.put(jsonObject)
        }
        render jsonArray as JSON
    }

    def reportByCwaReferralsJSON(){
        JSONArray jsonArray=new JSONArray()
        def roleInstance= MkpRole.findByAuthority("ROLE_CHW")
        def district=params.district
        def village=params.village

        def start_date=params.start_date
        def end_date=params.end_date
        def region=null
        def userList=null
        if (springSecurityService.principal.authorities.any { it.authority == 'ROLE_DISTRICT'}){
            def currentUser=springSecurityService.getCurrentUser()
            district=currentUser?.district_id?.id
            //  println("DOne:"+district)
        }
        if(district){
            if(village){
                def villageInstance=Street.read(village)
                userList = MkpUserMkpRole.executeQuery("from MkpUserMkpRole where mkpRole=:mkpRole and mkpUser.village_id=:villageInstance", [mkpRole: roleInstance, villageInstance: villageInstance])

            }else {
                def districtInstance = District.get(district)
                userList = MkpUserMkpRole.executeQuery("from MkpUserMkpRole where mkpRole=:mkpRole and mkpUser.district_id=:district", [mkpRole: roleInstance, district: districtInstance])
            }
        }
        else{
            if (springSecurityService.principal.authorities.any { it.authority == 'ROLE_REGION'}) {
                def currentUser = springSecurityService.getCurrentUser()
                userList=MkpUserMkpRole.executeQuery("from MkpUserMkpRole where mkpRole=:mkpRole and mkpUser.district_id.region_id=:region",[mkpRole:roleInstance,region:currentUser.region])

            }else {
                userList = MkpUserMkpRole.findAllByMkpRole(roleInstance)
            }
        }


        userList.each{
            def userInstance=it.mkpUser
            JSONObject jsonObject=new JSONObject()
            jsonObject.put("full_name",userInstance.full_name)
            jsonObject.put("id",userInstance.id)
            jsonObject.put("village",userInstance?.village_id?.name)
            jsonObject.put("facility",userInstance?.facility?.name)
            def chaidCount=0
            if(start_date&&end_date){
                def formatedStartDate=applicationService.changeTimeZOne(start_date)
                def formatedEndDate=applicationService.changeTimeZOne(end_date)

                chaidCount=MkChaid.executeQuery("from MkChaid where emergence_status<>0 and deleted=false and created_by=:createdBy and arrival_time>='"+formatedStartDate+"' and arrival_time<='"+formatedEndDate+"'",[createdBy:userInstance]).size()
            }else {
                chaidCount=MkChaid.executeQuery("from MkChaid where emergence_status<>0 and deleted=false and created_by=:createdBy ",[createdBy:userInstance]).size()

            }



            jsonObject.put("referral_no",chaidCount)

            def referralStatus=0
            if(start_date&&end_date){
                def formatedStartDate=applicationService.changeTimeZOne(start_date)
                def formatedEndDate=applicationService.changeTimeZOne(end_date)

                referralStatus=MkChaid.executeQuery("from MkChaid where emergence_status=2 and deleted=false and created_by=:createdBy and arrival_time>='"+formatedStartDate+"' and arrival_time<='"+formatedEndDate+"'",[createdBy:userInstance]).size()
            }else {
                referralStatus=MkChaid.executeQuery("from MkChaid where emergence_status=2 and deleted=false and created_by=:createdBy ",[createdBy:userInstance]).size()

            }
            jsonObject.put("status_change_no",referralStatus)

            jsonArray.put(jsonObject)
        }
        render jsonArray as JSON
    }

    def referralsReportByDate(){
        String start_date=params.start_date
        def end_date=params.end_date
        // def  startDate=Date.parse("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",start_date,TimeZone.getTimeZone("UTC"))
        //println(startDate.toString())
        def formatedStartDate=applicationService.changeTimeZOne(start_date)
        def formatedEndDate=applicationService.changeTimeZOne(end_date)
        def facility=params.facility
        def  outPutObject=applicationService.referralsReportByDate(facility,formatedStartDate,formatedEndDate)
        println(outPutObject)

        render outPutObject as JSON
    }

    def reportByReferralsGenerated(){
        session["activePage"] = "reports"

        render view: 'referrals'
    }

    def reportByHealthEducation(){
        session["activePage"] = "reports"

        render view: 'reportbyhealthrducation'
    }

    def reportByReferralsGeneratedJSON(){
        String facility=params.facility
        def referrals_no=0
        def pregnantWomanNo=0
        def breastFeedingLess=0
        def breastFeedingAbove=0
        def neonates=0
        def infants=0
        def childrenUnder5=0

        if(facility){
            def facilityInstance=Facility.get(params.facility)
            if(facilityInstance) {
                referrals_no = MkChaid.executeQuery("from MkChaid where emergence_status<>0 and deleted=false and facility=:facility",[facility:facilityInstance]).size()
                pregnantWomanNo = PreginantDetails.executeQuery("from PreginantDetails where  is_referrals=true and chaid.deleted=false and chaid.facility=:facility ",[facility:facilityInstance]).size()
                breastFeedingLess = PostDelivery.executeQuery("from PostDelivery where child_age_days<=42 and is_referrals=true and chaid.deleted=false and chaid.facility=:facility",[facility:facilityInstance]).size()
                breastFeedingAbove = PostDelivery.executeQuery("from PostDelivery where child_age_days>42 and is_referrals=true and chaid.deleted=false and chaid.facility=:facility",[facility:facilityInstance]).size()


                neonates = CategoryAvailableChildren.executeQuery("from CategoryAvailableChildren where categoryType=:categoryType and is_referrals=true and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.facility=:facility ",[categoryType:DictionaryItem.findByCode("CHAD17D"),facility:facilityInstance]).size()
                infants = CategoryAvailableChildren.executeQuery("from CategoryAvailableChildren where categoryType=:categoryType and is_referrals=true and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.facility=:facility ",[categoryType:DictionaryItem.findByCode("CHAD17E"),facility:facilityInstance]).size()
                childrenUnder5 = CategoryAvailableChildren.executeQuery("from CategoryAvailableChildren where categoryType=:categoryType and is_referrals=true and availableMemberHouse.chaid.deleted=false and availableMemberHouse.chaid.facility=:facility ",[categoryType:DictionaryItem.findByCode("CHAD17F"),facility:facilityInstance]).size()


            }
        }else {
            referrals_no = MkChaid.executeQuery("from MkChaid where emergence_status<>0 and deleted=false").size()
            pregnantWomanNo = PreginantDetails.executeQuery("from PreginantDetails where  is_referrals=true and chaid.deleted=false").size()
            breastFeedingLess = PostDelivery.executeQuery("from PostDelivery where child_age_days<=42 and is_referrals=true and chaid.deleted=false").size()
            breastFeedingAbove = PostDelivery.executeQuery("from PostDelivery where child_age_days>42 and is_referrals=true and chaid.deleted=false").size()


            neonates = CategoryAvailableChildren.countByCategoryTypeAndIs_referrals(DictionaryItem.findByCode("CHAD17D"), true)
            infants = CategoryAvailableChildren.countByCategoryTypeAndIs_referrals(DictionaryItem.findByCode("CHAD17E"), true)
            childrenUnder5 = CategoryAvailableChildren.countByCategoryTypeAndIs_referrals(DictionaryItem.findByCode("CHAD17F"), true)

        }

        JSONObject jsonObject=new JSONObject()
        jsonObject.put("referrals_no",referrals_no)
        jsonObject.put("pregnant_no",pregnantWomanNo)
        jsonObject.put("breast_feeding_less_no",breastFeedingLess)
        jsonObject.put("breast_feeding_above_no",breastFeedingAbove)
        jsonObject.put("neonates_no",neonates)
        jsonObject.put("infants_no",infants)
        jsonObject.put("children_under_five_no",childrenUnder5)

        JSONObject outPutObject=new JSONObject()
        outPutObject.put("referrals",jsonObject)
        render outPutObject as JSON
    }

    def reportByVillage(){
        session["activePage"] = "reports"
        render view: 'reportbyvillage'
    }

    def reportByRegion(){
        session["activePage"] = "reports"
        def currentUser=springSecurityService.getCurrentUser()

        render view: 'reportbyregion',model: [currentUser:currentUser]
    }

    def reportByDistrict(){
        session["activePage"] = "reports"
        def currentUser=springSecurityService.getCurrentUser()

        render view: 'reportbydistrict',model: [currentUser:currentUser]
    }
    def searchVillageReport(){
        def districtInstance=District.get(params.id)
        render template: 'villagereport',model: [districtInstance:districtInstance]
    }
    def searchDistrictReport(){
        def regionInstance=Region.get(params.id)
        render template: 'regionreport',model: [regionInstance:regionInstance]
    }
    def searchReportByDate(){
        def  selectedOption= params.selectedOption
        def from_date=params.from_date
        def end_date=params.end_date

        if( selectedOption&& selectedOption.equals("region")){
            def regionInstance=Region.get(params.region_id)
            render template: 'regionreport',model: [regionInstance:regionInstance,from_date:from_date,end_date:end_date]
        }else if(selectedOption&& selectedOption.equals("district")){
            def districtInstance=District.get(params.district_id)
            render template: 'villagereport',model: [districtInstance:districtInstance,from_date:from_date,end_date:end_date]
        }else {
            render template: 'countryreport',model: [from_date:from_date,end_date:end_date]
        }
    }

    def reportByDate(){
        def  selectedOption= params.selectedOption
        def from_date=params.from_date
        def end_date=params.end_date
        println(params)
        if( selectedOption&& selectedOption.equals("region")){
            def regionInstance=Region.get(params.region_id)
            render template: '/report/regionreport',model: [regionInstance:regionInstance,from_date:from_date,end_date:end_date]
        }else if(selectedOption&& selectedOption.equals("district")){
            def districtInstance=District.get(params.district_id)
            render template: '/report/villagereport',model: [districtInstance:districtInstance,from_date:from_date,end_date:end_date]
        }else {
            render template: '/report/countryreport',model: [from_date:from_date,end_date:end_date]
        }
    }

    def reportByDateTool(){
        def  selectedOption= params.selectedOption
        def from_date=params.from_date
        def end_date=params.end_date
        if( selectedOption&& selectedOption.equals("region")){
            def regionInstance=Region.read(params.region_id)
            render template: '/report/regiontoolreport',model: [regionInstance:regionInstance,from_date:from_date,end_date:end_date]
        }else if(selectedOption&& selectedOption.equals("district")){
            def village_id=params.village_id
            if(village_id){
                def villageInstance=Street.read(village_id)
                render template: '/report/villagemonthlyreport', model: [villageInstance: villageInstance, from_date: from_date, end_date: end_date]

            }else {
                def districtInstance = District.read(params.district_id)
                render template: '/report/districtmonthlyreport', model: [districtInstance: districtInstance, from_date: from_date, end_date: end_date]
            }
        }else {
            render template: '/report/countrymonthlyreport',model: [from_date:from_date,end_date:end_date]
        }
    }

    def chadSaveData(){
        try {
            def response = request.JSON
            if (response) {
                String data=response.toString()
               // println(data)
                try {
                    applicationService.saveChaid(data)
                }catch(Exception e){
                 //   println("Failed: "+data)

                    e.printStackTrace()
                }
                render "Successfully "

            } else {
                render "Failed ", status: 404
            }
        }catch(Exception e){
            e.printStackTrace()
            render "Failed", status: 200
        }
    }
    def getReferralListUser(){
        def username=params.username
        //username="admin"
        params.max=30
        params.sort = 'id'
        params.order = 'desc'
        def userInstance= MkpUser.findByUsername(username)
        def visitInstanceList=MkChaid.findAllByCreated_by(userInstance,params)
        JSONArray jsonArray=new JSONArray()
        visitInstanceList.each{
            JSONObject jsonObject=new JSONObject()
            jsonObject.put("name",it.respondent_name)
            jsonObject.put("reg_no",it.reg_no)
            jsonObject.put("chad_id",it.id)
            jsonObject.put("village_name",it.street.name)
            jsonObject.put("house_hold",it?.household?.full_name)
            jsonObject.put("hamlet",it.household?.street?.name)
            jsonObject.put("id",it.id)
            jsonObject.put("arrival_time",it.arrival_time.toString())



            def chadStatusList=ChadStatus.findAllByChaid(it)
            JSONArray statusArray=new JSONArray()
            chadStatusList.each{
                JSONObject statusObject=new JSONObject()
                statusObject.put("name",it.status.name)
                statusObject.put("comment",it.comment)
                statusObject.put("created_at",it.created_at.toString())
                statusArray.put(statusObject)
            }

            jsonObject.put("statuses",statusArray)
            jsonArray.put(jsonObject)
        }
        render jsonArray as JSON
    }

    def getReferralList(){
        def username=params.username
        //username="admin"
        params.max=60
        params.sort = 'id'
        params.order = 'desc'
        def userInstance= MkpUser.findByUsername(username)
        def visitInstanceList=MkChaid.findAllByFacility(userInstance.facility,params)
        JSONArray jsonArray=new JSONArray()
        visitInstanceList.each{
           JSONObject jsonObject=new JSONObject()
            jsonObject.put("name",it.respondent_name)
            jsonObject.put("reg_no",it.reg_no)
            jsonObject.put("chad_id",it.id)
            jsonObject.put("village_name",it.street.name)
            jsonObject.put("house_hold",it?.household?.full_name)
            jsonObject.put("hamlet",it.household?.street?.name)
            jsonObject.put("id",it.id)
            jsonObject.put("arrival_time",it.arrival_time.toString())



            def chadStatusList=ChadStatus.findAllByChaid(it)
            JSONArray statusArray=new JSONArray()
            chadStatusList.each{
                JSONObject statusObject=new JSONObject()
                statusObject.put("name",it.status.name)
                statusObject.put("comment",it.comment)
                statusObject.put("created_at",it.created_at.toString())
                statusArray.put(statusObject)
            }

            jsonObject.put("statuses",statusArray)
            jsonArray.put(jsonObject)
        }
         render jsonArray as JSON
    }
    def initialDataAdmin(){
        def username=params.username
        def userInstance= MkpUser.findByUsername(username)
        JSONObject jsonDetails=new JSONObject()
        jsonDetails.put("full_name",userInstance.full_name)
        jsonDetails.put("id",userInstance.id)
        jsonDetails.put("facility_name",userInstance.facility.name)
        jsonDetails.put("facility_mobile_number",userInstance.facility.mobile_number)
        def statusList=DictionaryItem.findAllByDictionary_idAndActive(Dictionary.findByCode("CHADSTATUS"),true) as JSON
        jsonDetails.put("status_list",statusList)
        def visitInstanceList=MkChaid.findAllByEmergence_statusAndFacility(1,userInstance.facility)
       //  def visitInstanceList=MkChaid.findAllByFacility(userInstance.facility)

        JSONArray jsonArray=new JSONArray()
        visitInstanceList.each{
            JSONObject jsonObject=new JSONObject()
            jsonObject.put("respondent_name",it.respondent_name)
            jsonObject.put("reg_no",it.reg_no)
            jsonObject.put("chad_id",it.id)
            jsonObject.put("village_name",it.street.name)
            jsonObject.put("house_hold",it.household.full_name)
            jsonObject.put("message",it.message)
            jsonArray.put(jsonObject)
        }
        jsonDetails.put("reported_visit",jsonArray)
        render jsonDetails
    }
     def initialData(){
         def username=params.username
         //println("Initial Data")
        // println(params)
        def userInstance= MkpUser.findByUsername(username)
        JSONObject jsonDetails=new JSONObject()
        jsonDetails.put("full_name",userInstance.full_name)
        jsonDetails.put("id",userInstance.id)
        jsonDetails.put("village_id",userInstance?.village_id?.id)
         jsonDetails.put("village_name",userInstance?.village_id?.name)

         jsonDetails.put("facility_name",userInstance?.facility?.name)
         jsonDetails.put("facility_mobile_number",userInstance?.facility?.mobile_number)
        if(userInstance.village_id) {
            def countVillage=SubStreet.countByVillage_id(userInstance.village_id)
            if(countVillage==0){
               def subStreetInstnce=new SubStreet()
                subStreetInstnce.district_id=userInstance.district_id
                subStreetInstnce.village_id=userInstance.village_id
                subStreetInstnce.name=userInstance.village_id.name
                subStreetInstnce.save(flush:true)
            }
            def streetList = SubStreet.findAllByVillage_id(userInstance.village_id) as JSON

            jsonDetails.put("street", streetList.toString())

            def houselistList = Household.findAllByVillage_id(userInstance.village_id) as JSON
            jsonDetails.put("house_hold_list", houselistList.toString())
        }else{
            jsonDetails.put("street", "null")
            jsonDetails.put("house_hold_list", "null")
        }

         jsonDetails.put("pregnant_list","null")

         def chaidDataList= Dictionary.findAllByActiveAndIs_questionnaire(true,true,[order:'asc',sort:'id'])
         JSONArray jsonArrayDetails=new JSONArray()
         chaidDataList.each{
             JSONObject jsonObject=new JSONObject()
             jsonObject.put("id",it.id)
             jsonObject.put("code",it.code)
             jsonObject.put("name",it.name)
             if(it.name_en){
                 jsonObject.put("name_sw",it.name_en)
             }else{
                 jsonObject.put("name_sw"," ")
             }

             def optionQuestionare= DictionaryItem.findAllByActiveAndDictionary_id(true,it,[sort: ['displayOrder': 'asc', 'code': 'asc'] ]) as JSON
             jsonObject.put("options",optionQuestionare.toString())
             jsonArrayDetails.put(jsonObject)

         }
         jsonDetails.put("questionnaire",jsonArrayDetails)


        render jsonDetails as JSON
    }

    def getVillageList(){

        def districtInstance= District.get(params.id)

        def streetListInstance= Street.findAllByDistrict_id(districtInstance)
        render streetListInstance as JSON
    }


    def search_village_list(){

        def src=params.src
        if(!src){
            src="2"
        }
        def districtInstance= District.get(params.id)

        def streetListInstance= Street.findAllByDistrict_id(districtInstance)
        //println(streetListInstance.toString())
        if(src=="1"){
            render(template: 'villagebydistrict', model: [streetListInstance: streetListInstance])

        }else {
            render(template: 'villageoptions', model: [streetListInstance: streetListInstance])
        }
    }

    def searchFacilityByDistrict(){
        def districtInstance= District.get(params.id)

        def facilityList=Facility.findAllByDistrict_idAndDeleted(districtInstance,false)
       // println(facilityList)
        render (template:'facilityoptions',model:[facilityListInstance:facilityList])

    }



    def search_ward_list(){
        def districtInstance= District.get(params.id)
        def wardListInstance= Wards.findAllByDistrict_id(districtInstance)
        render (template:'wardoptions',model:[wardListInstance:wardListInstance])
    }
}
