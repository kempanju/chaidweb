package chaid

import admin.DictionaryItem
import admin.SystemLogs
import com.chaid.security.MkpUser
import grails.converters.JSON
import grails.gorm.transactions.Transactional

import java.sql.Date

@Transactional
class ApplicationService {

    def serviceMethod() {

    }

    def saveChaid(def data){
        def jsonData= JSON.parse(data)

        def user_id=jsonData.user_id


        def house_hold_id=jsonData.house_hold_id
        def respondent=jsonData.respondent
        def gender=jsonData.gender
        def age=jsonData.age
        def relationshipstatus=jsonData.relationship_status
        def results=jsonData.results
        def house_hold_sick_person=jsonData.house_hold_sick_person
        def house_hold_sick_person_age=jsonData.house_hold_sick_person_age

        def uniquecode=jsonData.unique_code

        if(MkChaid.countByUniquecode(uniquecode)==0) {
            def userInstance= MkpUser.get(user_id)

            def chadInstance = new MkChaid()

            def houseHoldInstance=Household.get(house_hold_id)
            chadInstance.respondent_name = respondent
            chadInstance.respondent_gender = gender
            chadInstance.respondent_age = age
            chadInstance.household = houseHoldInstance
            chadInstance.created_by=userInstance
            chadInstance.distric = userInstance.village_id.district_id
            chadInstance.street = userInstance.village_id
            chadInstance.age_sick_person=house_hold_sick_person_age
            chadInstance.sick_person=house_hold_sick_person
            chadInstance.uniquecode=uniquecode
            chadInstance.relationship_status = DictionaryItem.findByCode(relationshipstatus)
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


            }
            if (chadInstance.save(failOnError: true)) {
                results.each {
                    def code = it.code
                    String answer_code = it.answer_code
                    String comment = it.comment

                    if (code.equals("CHAD6")) {
                        try {
                            def breakArray = answer_code.split(",")
                            breakArray.each {
                                def dictionaryItemList = DictionaryItem.findByCode(it)
                                def educationInstance = new EducationType()
                                educationInstance.type = dictionaryItemList
                                educationInstance.chaid = chadInstance
                                educationInstance.save()

                            }
                        }catch(Exception e){

                        }

                    }


                    if (code.equals("CHAD7")) {
                        try {
                            def breakArray = answer_code.split(",")
                            breakArray.each {
                                def dictionaryItemList = DictionaryItem.findByCode(it)
                                def activityInstance = new ActivityType()
                                activityInstance.household = houseHoldInstance
                                activityInstance.chaid = chadInstance
                                activityInstance.type = dictionaryItemList
                                activityInstance.other_explaination = comment
                                activityInstance.save()

                            }
                        }catch(Exception e){

                        }


                    }


                    if (code.equals("CHAD16")) {
                        try {
                            def breakArray = answer_code.split(",")
                            breakArray.each {
                                def dictionaryItemList = DictionaryItem.findByCode(it)
                                def houseHoldDetail = new HouseholdDetails()
                                houseHoldDetail.household = houseHoldInstance
                                houseHoldDetail.detailsType = dictionaryItemList
                                houseHoldDetail.save()

                            }
                        }catch(Exception e){

                        }
                    }

                    if (code.equals("CHAD17")) {
                        try {
                            def breakArray = answer_code.split(",")
                            breakArray.each {
                                def dictionaryItemList = DictionaryItem.findByCode(it)
                                def availableHouseHold = new AvailableMemberHouse()
                                availableHouseHold.household = houseHoldInstance
                                availableHouseHold.type_id = dictionaryItemList
                                availableHouseHold.chaid = chadInstance
                                availableHouseHold.save()

                            }
                        }catch(Exception e){

                        }
                    }

                    if (code.equals("CHAD17")) {
                        def breakArray = answer_code.split(",")
                        breakArray.each {
                            def dictionaryItemList = DictionaryItem.findByCode(it)

                        }

                    }




                }
                pregnantWomen(chadInstance,houseHoldInstance,jsonData,userInstance)
                postDelivery(chadInstance,houseHoldInstance,jsonData,userInstance)
                childUnderFive(chadInstance,houseHoldInstance,jsonData,userInstance)
            }


        }

    }



    def childUnderFive(MkChaid mkChaid,Household household,def jsonData,def userInstance){
        def last_date=jsonData.child_under_five.last_date
        def baby_provided_immunization=jsonData.child_under_five.baby_provided_immunization
        def take_child_clinic=jsonData.child_under_five.take_child_clinic
        def under_five_no=jsonData.child_under_five.under_five_no

        def childUnderFiveInstance=new ChildFiveYears()
        childUnderFiveInstance.provided_immunization=baby_provided_immunization
        childUnderFiveInstance.chaid=mkChaid
        childUnderFiveInstance.child_clinic=take_child_clinic
        childUnderFiveInstance.child_no=under_five_no
        childUnderFiveInstance.household=household

        if(childUnderFiveInstance.save(failOnError: true)){
            def results=jsonData.results

            results.each {
                def code = it.code
                def answer_code = it.answer_code


                if (code.equals("CHAD32A")) {
                    try {
                        def dangerSignExists = false
                        def msgDangerSign = ""
                        def signCount = 1;
                        def breakArray = answer_code.split(",")
                        breakArray.each {
                            def dictionaryItemList = DictionaryItem.findByCode(it)
                            def childSignInstance = new ChildDangerSign()
                            childSignInstance.childFiveYears = childUnderFiveInstance
                            childSignInstance.sign_type = dictionaryItemList
                            childSignInstance.save(failOnError: true)

                            msgDangerSign = msgDangerSign + " " + signCount + ". " + dictionaryItemList.name


                            signCount++

                        }

                        def uniquecode = jsonData.unique_code
                        def current_time = Calendar.instance
                        def send_at = new java.sql.Timestamp(current_time.time.time)

                        def dangerSignOn = "Reported Child danger sign with code " + uniquecode + ". Some signs are " + msgDangerSign + "."

                        saveSchedualMessages(userInstance, dangerSignOn, 0, send_at)

                    }catch(Exception e){
                        e.printStackTrace()
                    }

                }

            }

        }

    }
    def postDelivery(MkChaid mkChaid,Household household,def jsonData,def userInstance){
        def delivery_date=jsonData.post_delivery.delivery_date
        def card_verification_facility=jsonData.post_delivery.card_verification_facility
        def taken_baby_to_clinic=jsonData.post_delivery.taken_baby_to_clinic
        def baby_provided_immunization=jsonData.post_delivery.baby_provided_immunization
        def under_five_no=jsonData.post_delivery.under_five_no
        def postDeliveryInstance=new PostDelivery()
        //postDeliveryInstance.delivery_date=delivery_date
        postDeliveryInstance.facility_card_name=card_verification_facility
        postDeliveryInstance.postnatal_clinic=taken_baby_to_clinic
        postDeliveryInstance.provided_immunization=baby_provided_immunization
        postDeliveryInstance.chaid=mkChaid
        postDeliveryInstance.under_five_no=under_five_no
        def results=jsonData.results

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
        if(postDeliveryInstance.save(failOnError: true)){

            results.each {
                def code = it.code
                def answer_code = it.answer_code

                if (code.equals("CHAD27B")) {

                    try {

                        def breakArray = answer_code.split(",")
                        breakArray.each {
                            def dictionaryItemList = DictionaryItem.findByCode(it)
                            def childImmunizationInstance = new ChildImmunization()
                            childImmunizationInstance.chaid = mkChaid
                            childImmunizationInstance.postDelivery = postDeliveryInstance
                            childImmunizationInstance.immunization_type = dictionaryItemList
                            childImmunizationInstance.save()

                        }
                    }catch(Exception e){

                    }

                }
                if (code.equals("CHAD25")) {

                    try {
                        def dangerSignExists = false
                        def msgDangerSign = ""
                        def signCount = 1;
                        def breakArray = answer_code.split(",")
                        breakArray.each {
                            def dictionaryItemList = DictionaryItem.findByCode(it)
                            def dangerSignInstance = new DangerSignMotherDelivery()
                            dangerSignInstance.chaid = mkChaid
                            dangerSignInstance.postDelivery = postDeliveryInstance
                            dangerSignInstance.sign_type = dictionaryItemList
                            dangerSignInstance.save()

                            msgDangerSign = msgDangerSign + " " + signCount + ". " + dictionaryItemList.name


                            signCount++
                        }

                        def uniquecode = jsonData.unique_code
                        def current_time = Calendar.instance
                        def send_at = new java.sql.Timestamp(current_time.time.time)

                        def dangerSignOn = "Reported Mother danger sign with code " + uniquecode + ". Some signs are " + msgDangerSign + "."

                        saveSchedualMessages(userInstance, dangerSignOn, 0, send_at)

                    }catch(Exception e){
                        e.printStackTrace()
                    }


                }


                if (code.equals("CHAD26")) {
                    try {
                        def breakArray = answer_code.split(",")
                        def dangerSignExists = false
                        def msgDangerSign = ""
                        def signCount = 1;
                        breakArray.each {
                            def dictionaryItemList = DictionaryItem.findByCode(it)
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

                        def dangerSignOn = "Reported Child danger sign with code " + uniquecode + ". Some signs are " + msgDangerSign + "."

                        saveSchedualMessages(userInstance, dangerSignOn, 0, send_at)






                }catch(Exception e){
                    e.printStackTrace()
                }
                }
            }
        }


    }


    def  saveSchedualMessages(MkpUser userInstance, def message, def seder_status, def senderTime){
        def userLogsInstanceD = new SystemLogs()
        userLogsInstanceD.log_type = DictionaryItem.findByCode("SSMS")
        userLogsInstanceD.user_id = userInstance
        userLogsInstanceD.message = message
        userLogsInstanceD.sending_time=senderTime
        userLogsInstanceD.sending_status=seder_status
        userLogsInstanceD.unique_id=System.currentTimeMillis()
        userLogsInstanceD.save(failOnError: true)
        // flash.message="Message successfully sent."
    }



    def pregnantWomen(MkChaid mkChaid,Household household,def jsonData,def userInstance){

        println("called ghhh")

        def last_menstrual=jsonData.pregnant_woman.last_menstrual
        def attended_clinic=jsonData.pregnant_woman.attended_clinic
        def child_aged_under_one=jsonData.pregnant_woman.child_aged_under_one
       // def used_planning_method=jsonData.pregnant_woman.used_planning_method
        def prefer_planning_after_delivery=jsonData.pregnant_woman.prefer_planning_after_delivery

        println(last_menstrual)

        def pregnantInstance=new PreginantDetails()
        //pregnantInstance.last_menstual= Date.parse("yyyy-MM-dd",last_menstrual)
        pregnantInstance.attended_clinic=attended_clinic
        pregnantInstance.child_under_one=child_aged_under_one
        pregnantInstance.prefer_family_planning=prefer_planning_after_delivery
        pregnantInstance.chaid=mkChaid
        pregnantInstance.household=household

        def results=jsonData.results

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

        if(pregnantInstance.save(failOnError: true)){
            results.each {
                def code = it.code
                def answer_code = it.answer_code

                if (code.equals("CHAD18B")) {
                    try {
                        def breakArray = answer_code.split(",")
                        def dangerSignExists = false
                        def msgDangerSign = ""
                        def signCount = 1;
                        breakArray.each {
                            dangerSignExists = true
                            def dictionaryItemList = DictionaryItem.findByCode(it)
                            def dangerSignPregnant = new DangerSignPregnant()
                            dangerSignPregnant.chaid = mkChaid
                            dangerSignPregnant.sign_type = dictionaryItemList
                            dangerSignPregnant.preginantDetails = pregnantInstance
                            dangerSignPregnant.save(failOnError: true)

                            msgDangerSign = msgDangerSign + " " + signCount + ". " + dictionaryItemList.name


                            signCount++

                        }
                        def uniquecode = jsonData.unique_code
                        def current_time = Calendar.instance
                        def send_at = new java.sql.Timestamp(current_time.time.time)

                        def dangerSignOn = "Reported Pregnant danger sign with code " + uniquecode + ". Some signs are " + msgDangerSign + "."

                        saveSchedualMessages(userInstance, dangerSignOn, 0, send_at)
                    }catch(Exception e){
                        e.printStackTrace()
                    }

                }
            }

        }

    }

    def sendMessage(def phoneNumber,def shortTxt){
        def linkUrl="https://gw.selcommobile.com:8443/bin/send.json"
        def output = null;
        String name = "1"
        String parameters="USERNAME=BMFAPI&PASSWORD=BMFAPI&DESTADDR=255766545878&MESSAGE=TEST"
        //println(grailsApplication.config.cardApiUrlUser.toString())
        def post = new URL(linkUrl).openConnection()
        post.setRequestMethod("GET")
        post.setDoOutput(true)
        OutputStreamWriter wr = new OutputStreamWriter(post.getOutputStream())
        wr.write(parameters)
        wr.flush()

        def postRC = post.getResponseCode()
        println("code:"+postRC)

        if (postRC.equals(200)) {
            output = post.getInputStream().getText()
            println(output)
        }
    }
}
