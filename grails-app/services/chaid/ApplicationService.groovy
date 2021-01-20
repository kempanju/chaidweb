package chaid

import admin.DictionaryItem
import admin.SubStreet
import admin.SystemLogs
import com.chaid.security.MkpUser
import com.chaid.security.MkpUserMkpRole
import grails.converters.JSON
import grails.gorm.transactions.Transactional
import org.grails.web.json.JSONArray
import org.grails.web.json.JSONObject

import javax.net.ssl.HttpsURLConnection
import java.nio.charset.StandardCharsets
import java.sql.Date

@Transactional
class ApplicationService {

    def serviceMethod() {

    }

    def saveAvailableMemberDetails(def jsonData,String coreRequest,DictionaryItem category,def member_no,AvailableMemberHouse availableMemberHouse,MkChaid mkChaid){
        def neonates=jsonData.neonates
        def infants=jsonData.infants
        def children=jsonData.children

        def nameSign=null

        def savingJson=null
        if(coreRequest.equals("CHAD17D")){
            savingJson=neonates
            nameSign="Neonate"

        }else  if(coreRequest.equals("CHAD17E")){
            savingJson=infants
            nameSign="Infant"
        } else  if (coreRequest.equals("CHAD17F")){
            savingJson=children
            nameSign="Child"
        }
       // println(savingJson)

        if(savingJson) {

            def taken_baby_to_clinic = savingJson.taken_baby_to_clinic
            def baby_provided_immunization = savingJson.baby_provided_immunization
            if(!baby_provided_immunization){
                baby_provided_immunization=0
            }

            if(!taken_baby_to_clinic){
                taken_baby_to_clinic=0
            }

            def immunization = savingJson.immunization
            def danger_sign = savingJson.danger_sign

           // println("danger sign:"+danger_sign)

            def categoryAvailableInstance = new CategoryAvailableChildren();
            categoryAvailableInstance.taken_baby_to_clinic = taken_baby_to_clinic
            categoryAvailableInstance.baby_provided_immunization = baby_provided_immunization
            categoryAvailableInstance.categoryType = category
            categoryAvailableInstance.member_no = member_no
            categoryAvailableInstance.availableMemberHouse = availableMemberHouse
            if (categoryAvailableInstance.save(flush: true,failOnError: true)) {

                if (immunization) {
                   // println(immunization)
                    def breakArray = immunization.split(",")
                    breakArray.each {
                        String reqCode = it
                        reqCode = reqCode.trim()
                       // println(reqCode)
                        def immunizationAvailable = new ImmunizationAvailableChildren()
                        immunizationAvailable.availableMemberHouse = availableMemberHouse
                        immunizationAvailable.categoryAvailableChildren = categoryAvailableInstance
                        def dictionaryItemList = DictionaryItem.findByCode(reqCode)
                        immunizationAvailable.immunization_type = dictionaryItemList
                        immunizationAvailable.save()
                    }
                }
                if (danger_sign) {
                    def breakArray = danger_sign.split(",")
                    def msgDangerSign = ""
                    def signCount = 1;
                    breakArray.each {
                        String reqCode = it
                        reqCode = reqCode.trim()
                        def immunizationAvailable = new DangerSignAvailableChildren()
                        immunizationAvailable.availableMemberHouse = availableMemberHouse
                        immunizationAvailable.categoryAvailableChildren = categoryAvailableInstance
                        def dictionaryItemList = DictionaryItem.findByCode(reqCode)
                        immunizationAvailable.danger_type = dictionaryItemList
                        immunizationAvailable.save(failOnError: true)

                        msgDangerSign = msgDangerSign + " " + signCount + ". " + dictionaryItemList.name
                        signCount++
                    }

                    def current_time = Calendar.instance

                    def send_at = new java.sql.Timestamp(current_time.time.time)


                    String dangerSignOn=" Name: "+mkChaid?.respondent_name+" %0a Village: "+mkChaid?.household?.village_id?.name+" %0a" +
                            " Hamlets: "+mkChaid?.household?.street?.name+"%0a Reference: "+mkChaid.reg_no+"%0a Household: "+mkChaid?.household?.full_name+".%0a Danger Sign "+nameSign+": %0a "+msgDangerSign

                    //println(mkChaid.created_by.facility)
                    def userLists= MkpUserMkpRole.executeQuery("from MkpUserMkpRole where mkpRole.authority=:authority and mkpUser.facility=:facility",[authority:"ROLE_DISTRICT",facility:mkChaid.created_by.facility])

                    userLists.each {
                        //println(it)
                        saveSchedualMessages(it.mkpUser, dangerSignOn, 0, send_at,mkChaid)
                    }
                    MkChaid.executeUpdate("update MkChaid set emergence_status=1,message=:message where id=:id",[message:dangerSignOn,id:mkChaid.id])
                    CategoryAvailableChildren.executeUpdate("update CategoryAvailableChildren set is_referrals=true where id=:id",[id:categoryAvailableInstance.id])


                }

            }
        }
    }

    def saveChaid(def data){
        println(data)
        def jsonData= JSON.parse(data)

        def user_id=jsonData.user_id


        def house_hold_id=jsonData.house_hold
        def respondent=jsonData.respondent
        def gender=jsonData.gender
        def age=jsonData.age
        def relationshipstatus=jsonData.relationshipstatus
        def results=jsonData.results
        def house_hold_sick_person=jsonData.house_hold_sick_person
        def house_hold_sick_person_age=jsonData.house_hold_sick_person_age

        def latitude=jsonData.latitude
        def longitude=jsonData.longitude
        def accuracy=jsonData.accuracy
        def care_giver=jsonData.care_giver



        def uniquecode=jsonData.unique_code

        if(MkChaid.countByUniquecode(uniquecode)==0) {
            def userInstance= MkpUser.get(user_id)

            def chadInstance = new MkChaid()

            def houseHoldInstance=null

            if(house_hold_id){
                def id=house_hold_id.house_hold_id
                if(!id) {
                    def number = house_hold_id.number
                    def street_id = house_hold_id.street_id
                    def name = house_hold_id.name
                    def subStreetInstance = SubStreet.get(street_id)
                    houseHoldInstance = Household.findOrSaveWhere(village_id: subStreetInstance.village_id, district_id: subStreetInstance.district_id, number: number, name: name, street: subStreetInstance)
                }else{
                    houseHoldInstance = Household.get(id)
                }
            }
            chadInstance.respondent_name = respondent
            chadInstance.respondent_gender = gender
            chadInstance.respondent_age = age
            chadInstance.household = houseHoldInstance
            chadInstance.created_by=userInstance
            chadInstance.distric = userInstance?.village_id?.district_id
            chadInstance.street = userInstance?.village_id
            chadInstance.facility=userInstance.facility
            chadInstance.age_sick_person=house_hold_sick_person_age
            chadInstance.sick_person=house_hold_sick_person
            chadInstance.uniquecode=uniquecode
            chadInstance.relationship_status = DictionaryItem.findByCode(relationshipstatus)
            chadInstance.care_giver=care_giver
            chadInstance.app_logs=data

            try{
                int countChaid=MkChaid.countByStreet(userInstance.village_id)+1
                int  districtId= userInstance.village_id.district_id.id
                //int regionId=userInstance.village_id.district_id.id
                int village=userInstance.village_id.id
                def regNo= String.format("%03d", districtId)+"/"+String.format("%04d", village)+"/"+String.format("%04d", countChaid)
                chadInstance.reg_no=regNo
            }catch(Exception e){
                e.printStackTrace()
            }

            try{
                def lat=Double.parseDouble(latitude)
                def lon=Double.parseDouble(longitude)
                def tempValueLat=lat
                def tempValueLon=lon
                if(lat>0){
                    lat=tempValueLon
                    lon=tempValueLat
                }
                chadInstance.centroid_x=lat
                chadInstance.centroid_y=lon
                chadInstance.accuracy=Double.parseDouble(accuracy)
            }catch(Exception e){
                chadInstance.centroid_x=0
                chadInstance.centroid_y=0
                chadInstance.accuracy=0
               // e.printStackTrace()
            }
            results.each {
                def code = it.code
                def answer_code = it.answer_code

                if (code.equals("CHAD4")) {
                    chadInstance.visit_type = DictionaryItem.findByCode(answer_code)
                }

                if (code.equals("CHAD5")) {
                    chadInstance.meeting_type = DictionaryItem.findByCode(answer_code)
                }

                if (code.equals("CHAD11")) {
                    chadInstance.objective_type = DictionaryItem.findByCode(answer_code)
                }
                if (code.equals("CHAD14")) {
                    chadInstance.interview_status = DictionaryItem.findByCode(answer_code)
                }

                if (code.equals("CHAD33E")) {
                    chadInstance.living_with_household = DictionaryItem.findByCode(answer_code)
                }


            }
            if (chadInstance.save(failOnError: true,flush: true)) {
                def dangerSignPostDelivery=false

                results.each {
                    def code = it.code
                    String answer_code = it.answer_code
                    String comment = it.comment
                    def resultCodeArray=it.answer_code
                   // println("passed twice:"+code)
                    if (code.equals("CHAD6")) {
                        try {
                            def breakArray = answer_code.split(",")
                            breakArray.each {
                                String codeselected=it
                                codeselected=codeselected.trim()
                                def dictionaryItemList = DictionaryItem.findByCode(codeselected)
                                def educationInstance = new EducationType()
                                educationInstance.type = dictionaryItemList
                                educationInstance.chaid = chadInstance
                                educationInstance.save(flush: true)

                            }
                        }catch(Exception e){

                        }

                    }

                    if(code.equals("CHAD15")){
                        def answercodeArray=it.answer_code
                        def maleNo=0
                        def femaleNo=0
                        answercodeArray.each{
                            try {
                                String valueCode = it.code
                                def member_no = it.member_no
                                if(valueCode.equals("CHAD15A")){
                                    if(member_no) {
                                        maleNo = Integer.parseInt(member_no)
                                    }
                                }
                                if(valueCode.equals("CHAD15B")){
                                    if(member_no) {
                                        femaleNo = Integer.parseInt(member_no)
                                    }
                                }

                            }catch(Exception e){
                                e.printStackTrace()
                            }

                        }

                        if((maleNo>0||femaleNo>0)&&houseHoldInstance){
                            Household.executeUpdate("update Household set male_no=:male_no,female_no=:female_no,facility=:facility where id=:houseID",[male_no:maleNo,female_no:femaleNo,facility:userInstance.facility,houseID:houseHoldInstance.id])
                        }

                    }


                    if (code.equals("CHAD7")) {
                        try {
                            def breakArray = answer_code.split(",")
                            breakArray.each {
                                String codeselected=it
                                codeselected=codeselected.trim()
                                def dictionaryItemList = DictionaryItem.findByCode(codeselected)
                                def activityInstance = new ActivityType()
                                activityInstance.household = houseHoldInstance
                                activityInstance.chaid = chadInstance
                                activityInstance.type = dictionaryItemList
                                activityInstance.other_explaination = comment
                                activityInstance.save(flush: true)

                            }
                        }catch(Exception e){

                        }


                    }

                    if (code.equals("CHAD33C")) {
                        try {
                            def breakArray = answer_code.split(",")
                            breakArray.each {
                                String codeselected=it
                                codeselected=codeselected.trim()
                                def dictionaryItemList = DictionaryItem.findByCode(codeselected)
                                def activityInstance = new HouseSickPersonExamination()
                                activityInstance.chaid = chadInstance
                                activityInstance.diseaseType = dictionaryItemList
                                activityInstance.household=houseHoldInstance
                                activityInstance.save(flush: true)

                            }
                        }catch(Exception e){

                        }


                    }


                    if (code.equals("CHAD33F")) {
                        try {
                            def breakArray = answer_code.split(",")
                            breakArray.each {
                                String codeselected=it
                                codeselected=codeselected.trim()
                                def dictionaryItemList = DictionaryItem.findByCode(codeselected)
                                def activityInstance = new HealthEducation()
                                activityInstance.chaid = chadInstance
                                activityInstance.type = dictionaryItemList
                                activityInstance.save(flush: true)

                            }
                        }catch(Exception e){

                        }


                    }





                    if (code.equals("CHAD16")) {
                        try {
                            def breakArray = resultCodeArray
                            breakArray.each {
                                String coreRequest=it.code
                                coreRequest=coreRequest.trim()
                                def dictionaryItemList = DictionaryItem.findByCode(coreRequest)
                                def houseHoldDetail =HouseholdDetails.findOrSaveWhere(household:houseHoldInstance,detailsType:dictionaryItemList)
                                houseHoldDetail.member_no = Integer.parseInt(it.member_no)
                                houseHoldDetail.save(flush: true)

                            //    println(it.member_no)

                            }
                        }catch(Exception e){

                        }
                    }



                    if (code.equals("CHAD17")) {
                        try {
                            def breakArray = resultCodeArray
                            breakArray.each {
                                String coreRequest=it.code
                                coreRequest=coreRequest.trim()
                               // println("called:"+coreRequest)
                                def dictionaryItemList = DictionaryItem.findByCode(coreRequest)
                                def availableHouseHold = new AvailableMemberHouse()
                                availableHouseHold.household = houseHoldInstance
                                availableHouseHold.type_id = dictionaryItemList
                                availableHouseHold.chaid = chadInstance
                                availableHouseHold.member_no = Integer.parseInt(it.member_no)
                                if(availableHouseHold.save(flush: true)){
                                    def memberNo=Integer.parseInt(it.member_no)
                                    try {
                                        saveAvailableMemberDetails(jsonData, coreRequest, dictionaryItemList, memberNo, availableHouseHold, chadInstance)

                                    }catch(Exception e){
                                        e.printStackTrace()
                                    }
                                }

                            }
                        }catch(Exception e){
                            e.printStackTrace()
                        }
                    }

                    if (code.equals("CHAD25")||code.equals("CHAD26")) {

                        dangerSignPostDelivery=true
                    }




                }
                try {
                    def post_delivery = jsonData.post_delivery


                    def pregnant_woman = jsonData.pregnant_woman
                    def child_under_five = jsonData.child_under_five
                   // println(pregnant_woman)
                    if(pregnant_woman) {
                        pregnantWomen(chadInstance, houseHoldInstance, jsonData, userInstance)
                    }
                    if(post_delivery||dangerSignPostDelivery) {
                        postDelivery(chadInstance, houseHoldInstance, jsonData, userInstance)
                    }
                    if(child_under_five) {
                        childUnderFive(chadInstance, houseHoldInstance, jsonData, userInstance)
                    }
                }catch(Exception e){
                    e.printStackTrace()
                }




                try{
                    def chadInstanceStatus=new ChadStatus();
                    chadInstanceStatus.createdBy=userInstance
                    chadInstanceStatus.chaid=chadInstance
                    chadInstanceStatus.comment="Submitted"
                    chadInstanceStatus.status=DictionaryItem.findByCode("CHASUB")
                    chadInstanceStatus.save(failOnError:true)
                }catch(Exception e){
                    e.printStackTrace()
                }


            }


        }

    }



    def childUnderFive(MkChaid mkChaid,Household household,def jsonData,def userInstance){
        try {
            def last_date = jsonData.child_under_five.last_date
            def baby_provided_immunization = jsonData.child_under_five.baby_provided_immunization
            def take_child_clinic = jsonData.child_under_five.take_child_clinic
            def under_five_no = jsonData.child_under_five.under_five_no

            def childUnderFiveInstance = new ChildFiveYears()
            childUnderFiveInstance.provided_immunization = baby_provided_immunization
            childUnderFiveInstance.chaid = mkChaid
            childUnderFiveInstance.child_clinic = take_child_clinic
            childUnderFiveInstance.child_no = under_five_no
            childUnderFiveInstance.household = household

            if (childUnderFiveInstance.save(failOnError: true,flush: true)) {
                def results = jsonData.results

                results.each {
                    def code = it.code
                    def answer_code = it.answer_code
                    if (code.equals("CHAD32F")) {
                        try {

                            def breakArray = answer_code.split(",")
                            breakArray.each {
                                //println(it)
                                String codeSelected=it
                                codeSelected=codeSelected.trim()
                                def dictionaryItemList = DictionaryItem.findByCode(codeSelected)
                                def childImmunizationInstance = new ChildUnderFiveImmunization()
                                childImmunizationInstance.chaid = mkChaid
                                childImmunizationInstance.childFiveYears = childUnderFiveInstance
                                childImmunizationInstance.immunization_type = dictionaryItemList
                                childImmunizationInstance.save()

                            }
                        } catch (Exception e) {
                            e.printStackTrace()
                        }

                    }

                    if (code.equals("CHAD32B")) {
                        try {
                            def dangerSignExists = false
                            def msgDangerSign = ""
                            def signCount = 1;
                            def breakArray = answer_code.split(",")
                            breakArray.each {
                                String coreRequest=it
                                coreRequest=coreRequest.trim()
                                def dictionaryItemList = DictionaryItem.findByCode(coreRequest)
                                def childSignInstance = new ChildDangerSign()
                                childSignInstance.childFiveYears = childUnderFiveInstance
                                childSignInstance.sign_type = dictionaryItemList
                                childSignInstance.save()

                                msgDangerSign = msgDangerSign + " " + signCount + ". " + dictionaryItemList.name


                                signCount++

                            }

                            def uniquecode = jsonData.unique_code
                            def current_time = Calendar.instance
                            def send_at = new java.sql.Timestamp(current_time.time.time)

                           // def dangerSignOn = "Reported Child danger sign with code " + mkChaid.reg_no + ". Some signs are " + msgDangerSign + "."

                            String dangerSignOn=" Name: "+mkChaid?.respondent_name+" %0a Village: "+mkChaid?.household?.village_id?.name+" %0a" +
                                    " Hamlets: "+mkChaid?.household?.street?.name+"%0a Reference: "+mkChaid.reg_no+"%0a Household: "+mkChaid?.household?.full_name+".%0a Danger Sign Child "+": %0a "+msgDangerSign


                            def userLists= MkpUserMkpRole.executeQuery("from MkpUserMkpRole where mkpRole.authority=:authority and mkpUser.facility=:facility",[authority:"ROLE_DISTRICT",facility:userInstance.facility])

                            userLists.each {
                                saveSchedualMessages(it.mkpUser, dangerSignOn, 0, send_at,mkChaid)
                            }
                            //MkChaid.executeUpdate("update MkChaid set emergence_status=1 where id=:id",[id:mkChaid.id])
                            MkChaid.executeUpdate("update MkChaid set emergence_status=1,message=:message where id=:id",[message:dangerSignOn,id:mkChaid.id])

                        } catch (Exception e) {
                            e.printStackTrace()
                        }

                    }

                }

            }
        }catch(Exception e){
            e.printStackTrace()
        }

    }
    def postDelivery(MkChaid mkChaid,Household household,def jsonData,def userInstance){
     //   println("passed99")
        try {
            def delivery_date = jsonData.post_delivery.delivery_date
            def card_verification_facility = jsonData.post_delivery.card_verification_facility
            def taken_baby_to_clinic = jsonData.post_delivery.taken_baby_to_clinic
            def baby_provided_immunization = jsonData.post_delivery.baby_provided_immunization
            def under_five_no = jsonData.post_delivery.under_five_no
            def postDeliveryInstance = new PostDelivery()
            //postDeliveryInstance.delivery_date=delivery_date

            if(delivery_date){
                postDeliveryInstance.delivery_date= java.util.Date.parse("yyyy-MM-dd",delivery_date)

            }
            postDeliveryInstance.facility_card_name = card_verification_facility
            postDeliveryInstance.postnatal_clinic = taken_baby_to_clinic
            postDeliveryInstance.provided_immunization = baby_provided_immunization
            postDeliveryInstance.chaid = mkChaid
            postDeliveryInstance.under_five_no = under_five_no
            def results = jsonData.results

            results.each {
                def code = it.code
                def answer_code = it.answer_code

                if (code.equals("CHAD23A")) {
                    postDeliveryInstance.outcome_type = DictionaryItem.findByCode(answer_code)
                }

                if (code.equals("CHAD23B")) {
                    postDeliveryInstance.baby_condition = DictionaryItem.findByCode(answer_code)
                }

                if (code.equals("CHAD23C")) {
                    postDeliveryInstance.delivery_type = DictionaryItem.findByCode(answer_code)
                }

                if (code.equals("CHAD23D")) {
                    postDeliveryInstance.delivery_place = DictionaryItem.findByCode(answer_code)
                }

                if (code.equals("CHAD29")) {
                    postDeliveryInstance.family_planning = DictionaryItem.findByCode(answer_code)
                }

            }
            if (postDeliveryInstance.save(failOnError: true,flush: true)) {

                results.each {
                    def code = it.code
                    def answer_code = it.answer_code

                    if (code.equals("CHAD27C")) {

                        try {

                            def breakArray = answer_code.split(",")
                            breakArray.each {
                                //println(it)
                                String codeSelected=it
                                codeSelected=codeSelected.trim()
                                def dictionaryItemList = DictionaryItem.findByCode(codeSelected)
                                def childImmunizationInstance = new ChildImmunization()
                                childImmunizationInstance.chaid = mkChaid
                                childImmunizationInstance.postDelivery = postDeliveryInstance
                                childImmunizationInstance.immunization_type = dictionaryItemList
                                childImmunizationInstance.save()

                            }
                        } catch (Exception e) {
                            e.printStackTrace()
                        }

                    }
                    if (code.equals("CHAD25")) {
                        println("passe")

                        try {
                            def dangerSignExists = false
                            def msgDangerSign = ""
                            def signCount = 1;
                            if(answer_code) {
                                def breakArray = answer_code.split(",")
                                breakArray.each {
                                    try {
                                        String codeSelected=it
                                        codeSelected=codeSelected.trim()
                                        def dictionaryItemList = DictionaryItem.findByCode(codeSelected)
                                        def dangerSignInstance = new DangerSignMotherDelivery()
                                        dangerSignInstance.chaid = mkChaid
                                        dangerSignInstance.postDelivery = postDeliveryInstance
                                        dangerSignInstance.sign_type = dictionaryItemList
                                        dangerSignInstance.save()

                                        msgDangerSign = msgDangerSign + " " + signCount + ". " + dictionaryItemList.name

                                    } catch (Exception e) {
                                        e.printStackTrace()
                                    }
                                    signCount++
                                }

                                def uniquecode = jsonData.unique_code
                                def current_time = Calendar.instance
                                def send_at = new java.sql.Timestamp(current_time.time.time)

                               // def dangerSignOn = "Reported Mother danger sign with code " + mkChaid.reg_no + ". Some signs are " + msgDangerSign + "."

                                String dangerSignOn=" Name: "+mkChaid?.respondent_name+" %0a Village: "+mkChaid?.household?.village_id?.name+" %0a" +
                                        " Hamlets: "+mkChaid?.household?.street?.name+"%0a Reference: "+mkChaid.reg_no+"%0a Household: "+mkChaid?.household?.full_name+".%0a Danger Sign Mother: %0a"+msgDangerSign


                                def userLists= MkpUserMkpRole.executeQuery("from MkpUserMkpRole where mkpRole.authority=:authority and mkpUser.facility=:facility",[authority:"ROLE_DISTRICT",facility:userInstance.facility])
                                userLists.each {
                                    saveSchedualMessages(it.mkpUser, dangerSignOn, 0, send_at,mkChaid)
                                }
                                MkChaid.executeUpdate("update MkChaid set emergence_status=1,message=:message where id=:id",[message:dangerSignOn,id:mkChaid.id])
                                PostDelivery.executeUpdate("update PostDelivery set is_referrals=true where id=:id",[id:postDeliveryInstance.id])

                            }
                        } catch (Exception e) {
                            e.printStackTrace()
                        }


                    }


                    if (code.equals("CHAD26")) {
                        try {
                            if(answer_code) {
                                def breakArray = answer_code.split(",")
                                def dangerSignExists = false
                                def msgDangerSign = ""
                                def signCount = 1;
                                breakArray.each {
                                    String codeSelected=it
                                    codeSelected=codeSelected.trim()
                                    def dictionaryItemList = DictionaryItem.findByCode(codeSelected)
                                    def dangerSignInstance = new DangerSignChildDelivery()
                                    dangerSignInstance.chaid = mkChaid
                                    dangerSignInstance.postDelivery = postDeliveryInstance
                                    dangerSignInstance.sign_type = dictionaryItemList
                                    msgDangerSign = msgDangerSign + " " + signCount + ". " + dictionaryItemList.name


                                    signCount++
                                    if (dangerSignInstance.save()) {

                                    }
                                }


                                def uniquecode = jsonData.unique_code
                                def current_time = Calendar.instance
                                def send_at = new java.sql.Timestamp(current_time.time.time)

                              //  def dangerSignOn = "Reported Child danger sign with code " + mkChaid.reg_no + ". Some signs are " + msgDangerSign + "."

                                String dangerSignOn=" Name: "+mkChaid?.respondent_name+" %0a Village: "+mkChaid?.household?.village_id?.name+" %0a" +
                                        " Hamlets: "+mkChaid?.household?.street?.name+"%0a Reference: "+mkChaid.reg_no+"%0a Household: "+mkChaid?.household?.full_name+".%0a Danger Sign Child: "+msgDangerSign


                                def userLists= MkpUserMkpRole.executeQuery("from MkpUserMkpRole where mkpRole.authority=:authority and mkpUser.facility=:facility",[authority:"ROLE_DISTRICT",facility:userInstance.facility])
                                userLists.each {
                                    saveSchedualMessages(it.mkpUser, dangerSignOn, 0, send_at,mkChaid)
                                }

                                MkChaid.executeUpdate("update MkChaid set emergence_status=1,message=:message where id=:id",[message:dangerSignOn,id:mkChaid.id])


                            }

                        } catch (Exception e) {
                            e.printStackTrace()
                        }
                    }
                }
            }
        }catch(Exception e){
            e.printStackTrace()
        }


    }


    def  saveSchedualMessages(MkpUser userInstance, def message, def seder_status, def senderTime,def mkChaid=null){
        def userLogsInstanceD = new SystemLogs()
        userLogsInstanceD.log_type = DictionaryItem.findByCode("SSMS")
        userLogsInstanceD.user_id = userInstance
        userLogsInstanceD.message = message
        userLogsInstanceD.chaid=mkChaid
        userLogsInstanceD.sending_time=senderTime
        userLogsInstanceD.sending_status=seder_status
        userLogsInstanceD.unique_id=System.currentTimeMillis()
        userLogsInstanceD.save(failOnError: true)
        // flash.message="Message successfully sent."
    }


    def  saveSchedualLogs(MkpUser userInstance, def message){
        def current_time = Calendar.instance
        def send_at = new java.sql.Timestamp(current_time.time.time)

        def userLogsInstanceD = new SystemLogs()
        userLogsInstanceD.log_type = DictionaryItem.findByCode("SSMS")
        userLogsInstanceD.user_id = userInstance
        userLogsInstanceD.message = message
        userLogsInstanceD.sending_time=send_at
        userLogsInstanceD.sending_status=0
        userLogsInstanceD.unique_id=System.currentTimeMillis()
        userLogsInstanceD.save()
        // flash.message="Message successfully sent."
    }



    def pregnantWomen(MkChaid mkChaid,Household household,def jsonData,def userInstance){

        try {
            println("passed")
            def name = jsonData.pregnant_woman.name
            def phone_number = jsonData.pregnant_woman.phone_number
            def age = jsonData.pregnant_woman.age

            def last_menstrual = jsonData.pregnant_woman.last_menstrual
            def attended_clinic = jsonData.pregnant_woman.attended_clinic
            def child_aged_under_one = jsonData.pregnant_woman.child_aged_under_one
            // def used_planning_method=jsonData.pregnant_woman.used_planning_method
            def prefer_planning_after_delivery = jsonData.pregnant_woman.prefer_planning_after_delivery


            def pregnantInstance = new PreginantDetails()

            if(last_menstrual){
                pregnantInstance.last_menstual = java.util.Date.parse("yyyy-MM-dd",last_menstrual)

            }


            pregnantInstance.name= name
            pregnantInstance.phone_number= phone_number
            try {
                pregnantInstance.age =age
            }catch(Exception e){

            }
            pregnantInstance.attended_clinic = attended_clinic
            pregnantInstance.child_under_one = child_aged_under_one
            pregnantInstance.prefer_family_planning = prefer_planning_after_delivery
            pregnantInstance.chaid = mkChaid
            pregnantInstance.household = household

            def results = jsonData.results

            results.each {
                def code = it.code
                def answer_code = it.answer_code
                if (code.equals("CHAD18D")) {
                    pregnantInstance.visit_type = DictionaryItem.findByCode(answer_code)
                }


                if (code.equals("CHAD18F")) {
                    pregnantInstance.education_type = DictionaryItem.findByCode(answer_code)
                }
                if (code.equals("CHAD19")) {
                    pregnantInstance.child_group_no = DictionaryItem.findByCode(answer_code)
                }

                if (code.equals("CHAD22B")) {
                    pregnantInstance.family_planning_type = DictionaryItem.findByCode(answer_code)
                }

            }

            if (pregnantInstance.save(failOnError: true,flush: true)) {
                results.each {
                    def code = it.code
                    def answer_code = it.answer_code
                  //  println(code)

                    if (code.equals("CHAD18C")) {
                       // println("passed")
                        try {
                            if(answer_code) {
                                def breakArray = answer_code.split(",")
                                def dangerSignExists = false
                                def msgDangerSign = ""
                                def signCount = 1;
                                breakArray.each {

                                    String codeGiven=it
                                    codeGiven=codeGiven.trim()
                                    dangerSignExists = true
                                    def dictionaryItemList = DictionaryItem.findByCode(codeGiven)
                                    def dangerSignPregnant = new DangerSignPregnant()
                                    dangerSignPregnant.chaid = mkChaid
                                    dangerSignPregnant.sign_type = dictionaryItemList
                                    dangerSignPregnant.preginantDetails = pregnantInstance
                                    dangerSignPregnant.save(failOnError: true)

                                    msgDangerSign = msgDangerSign + " " + signCount + ". " + dictionaryItemList.name+"%0a"


                                    signCount++

                                }
                                def uniquecode = jsonData.unique_code
                                def current_time = Calendar.instance
                                def send_at = new java.sql.Timestamp(current_time.time.time)


                                String dangerSignOn=" Name: "+name+" %0a Village: "+mkChaid?.household?.village_id?.name+" %0a" +
                                        " Hamlets: "+mkChaid?.household?.street?.name+"%0a Reference: "+mkChaid.reg_no+"%0a Household: "+mkChaid?.household?.full_name+".%0a Danger Sign Pregnant: %0a"+msgDangerSign


                                def userLists= MkpUserMkpRole.executeQuery("from MkpUserMkpRole where mkpRole.authority=:authority and mkpUser.facility=:facility",[authority:"ROLE_DISTRICT",facility:userInstance.facility])
                                userLists.each {
                                    saveSchedualMessages(it.mkpUser, dangerSignOn, 0, send_at,mkChaid)
                                }
                                MkChaid.executeUpdate("update MkChaid set emergence_status=1,message=:message where id=:id",[message:dangerSignOn,id:mkChaid.id])
                                PreginantDetails.executeUpdate("update PreginantDetails set is_referrals=true where id=:id",[id:pregnantInstance.id])

                            }
                        } catch (Exception e) {
                            e.printStackTrace()
                        }

                    }
                }

            }
        }catch(Exception e){
            e.printStackTrace()
        }

    }

    def sendMessage(def phoneNumber,def shortTxt){
        String output=" "
         String parameters="USERNAME=bmfapi&PASSWORD=bmfapi123&DESTADDR="+phoneNumber+"&MESSAGE="+shortTxt

        def linkUrl="https://gw.selcommobile.com:8443/bin/send.json"
        def post = new URL(linkUrl).openConnection()
        post.setRequestMethod("GET")
        post.setDoOutput(true)
        OutputStreamWriter wr = new OutputStreamWriter(post.getOutputStream())
        wr.write(parameters)
        wr.flush()

        def postRC = post.getResponseCode()
       // println("code:"+postRC)
        if (postRC.equals(200)) {
            output = post.getInputStream().getText()
        //    println(output)
        }
    }





}
