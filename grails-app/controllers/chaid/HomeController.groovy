package chaid

import admin.Dictionary
import admin.DictionaryItem
import admin.District
import admin.Street
import admin.SubStreet
import admin.Wards
import com.chaid.security.MkpUser
import grails.converters.JSON
import grails.gorm.transactions.Transactional
import grails.plugin.springsecurity.annotation.Secured
import org.grails.web.json.JSONArray
import org.grails.web.json.JSONObject

@Secured("isAuthenticated()")
class HomeController {
ApplicationService applicationService
    def index() { }

    def dashboard(){
        session["activePage"] = "dashboard"

        render view:'dashboard'
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

    def reportByVillage(){
        session["activePage"] = "reports"
        render view: 'reportbyvillage'
    }
    def searchVillageReport(){
        println(params)
        def districtInstance=District.get(params.id)
        render template: 'villagereport',model: [districtInstance:districtInstance]
    }

    def chadSaveData(){
        def response = request.JSON
        if(response) {
            //println("Sent: "+response.toString())
            applicationService.saveChaid(response.toString())
            render "Successfully "

        }else{
            render "Failed ",status:404
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
        println(params)
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
         println(params)
        def userInstance= MkpUser.findByUsername(username)
        JSONObject jsonDetails=new JSONObject()
        jsonDetails.put("full_name",userInstance.full_name)
        jsonDetails.put("id",userInstance.id)
        jsonDetails.put("village_id",userInstance.village_id.id)
         jsonDetails.put("village_name",userInstance.village_id.name)

         jsonDetails.put("facility_name",userInstance.facility.name)
         jsonDetails.put("facility_mobile_number",userInstance.facility.mobile_number)

         def streetList= SubStreet.findAllByVillage_id(userInstance.village_id) as JSON
         jsonDetails.put("street",streetList.toString())

         def houselistList= Household.findAllByVillage_id(userInstance.village_id) as JSON
         jsonDetails.put("house_hold_list",houselistList.toString())
         jsonDetails.put("pregnant_list","null")

         def chaidDataList= Dictionary.findAllByActiveAndIs_questionnaireAndActive(true,true,true,[order:'asc',sort:'id'])
         JSONArray jsonArrayDetails=new JSONArray()
         chaidDataList.each{
             JSONObject jsonObject=new JSONObject()
             jsonObject.put("id",it.id)
             jsonObject.put("code",it.code)
             jsonObject.put("name",it.name)

             def optionQuestionare= DictionaryItem.findAllByActiveAndDictionary_id(true,it,[order:'asc',sort:'code']) as JSON
             jsonObject.put("options",optionQuestionare.toString())
             jsonArrayDetails.put(jsonObject)

         }
         jsonDetails.put("questionnaire",jsonArrayDetails)


        render jsonDetails as JSON
    }

    def search_village_list(){
        println("called")
        def districtInstance= District.get(params.id)

        def streetListInstance= Street.findAllByDistrict_id(districtInstance)
        //println(streetListInstance.toString())
        render (template:'villageoptions',model:[streetListInstance:streetListInstance])
    }

    def search_ward_list(){
        def districtInstance= District.get(params.id)
        def wardListInstance= Wards.findAllByDistrict_id(districtInstance)
        render (template:'wardoptions',model:[wardListInstance:wardListInstance])
    }
}
