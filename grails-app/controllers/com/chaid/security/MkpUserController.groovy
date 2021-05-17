package com.chaid.security

import admin.District
import admin.Street
import admin.SubStreet
import admin.Wards
import chaid.ApplicationService
import chaid.Facility
import grails.gorm.transactions.Transactional
import grails.plugin.springsecurity.annotation.Secured
import grails.util.Environment
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*
@Secured(['ROLE_CORE_WEB','ROLE_ADMIN'])
class MkpUserController {

    MkpUserService mkpUserService
    def springSecurityService
    ApplicationService applicationService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        session["activePage"] = "users"

        params.max = Math.min(max ?: 10, 100)
        respond mkpUserService.list(params), model:[mkpUserCount: mkpUserService.count()]
    }

    def show(Long id) {
        respond mkpUserService.get(id)
    }

    def create() {
        respond new MkpUser(params)
    }

    def save(MkpUser mkpUser) {
        if (mkpUser == null) {
            notFound()
            return
        }

        try {
            if(params.username){
                mkpUser.username=params.username
            }else{
                mkpUser.username=params.email_address

            }
            mkpUser.email=params.email_address

            mkpUser.password=System.currentTimeMillis()+"yhh"
            mkpUserService.save(mkpUser)
        } catch (ValidationException e) {
            respond mkpUser.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'mkpUser.label', default: 'MkpUser'), mkpUser.id])
                redirect mkpUser
            }
            '*' { respond mkpUser, [status: CREATED] }
        }
    }
    @Secured(['ROLE_ADMIN'])
    @Transactional
    def addRole(){
        def userRoleInstance = new MkpUserMkpRole()
        userRoleInstance.mkpUser = MkpUser.get(params.user_id)
        userRoleInstance.mkpRole = MkpRole.get(params.role_id)
        userRoleInstance.save()
        redirect(action: 'show', params: [id: params.user_id])
    }
    @Secured(['ROLE_ADMIN'])
    @Transactional
    def deleteRole(){
        def userInstance=MkpUser.get(params.user_id)
        def roleInstance=MkpRole.get(params.role_id)
        MkpUserMkpRole.remove(userInstance,roleInstance)
        flash.message="Role successfully removed!"
        redirect(action: 'show', params: [id: params.user_id])
    }

    def edit(Long id) {
        respond mkpUserService.get(id)
    }

    @Transactional
    def uploadUsers(){
        println(params)
        def palines = 0;
        int userexists = 0;
        int usernotexists = 0;


        //  println(params)

        def reqFile = request.getFile("filename_csv")

        if(reqFile) {
            def namephoto = System.currentTimeMillis() + ".csv";
            def file_path = servletContext.getRealPath("") + "csvfiles/" + namephoto


            if (Environment.current != Environment.DEVELOPMENT) {
                file_path = "/home/mkapauser/chaiddocuments/" + namephoto
            }

            File fileDest = new File(file_path)
            reqFile.transferTo(fileDest)


            new File(file_path).splitEachLine(",") { fields ->

                try {
                    if (palines > 0) {
                        String username=fields[8]
                        if(username) {
                            //sleep(500)
                            def fName = fields[0]
                            def mName = fields[1]
                            def lName = fields[2]
                            def village = fields[3]
                            if(village){
                                village=village.trim()
                            }
                            def ward = fields[4]
                            def district = fields[5]
                            if(district){
                                district=district.trim()
                            }
                            def facility = fields[6]
                            if(facility){
                                facility=facility.trim()
                            }
                            def mobNo = fields[7]
                            String userName = username.toLowerCase()


                            //  println(tempoDistrict+" "+tempoKata+" "+tempoVillage+" "+tempoHelmets)

                            //   def uniquename = districtInstance.id + "/" + tempoKata

                            if (MkpUser.countByUsername(userName) == 0) {
                                def code = getRandomNumber(1000, 9999)

                                def userInstance = new MkpUser()
                                userInstance.username = userName
                                userInstance.first_name = fName
                                userInstance.middle_name = mName
                                userInstance.last_name = lName
                                userInstance.phone_number = mobNo
                                userInstance.password = code
                                userInstance.accountLocked = 0
                                def districtInstance = District.findByNameIlike(district)

                                userInstance.district_id = districtInstance
                                userInstance.facility = Facility.findByNameIlikeAndDistrict_id(facility, districtInstance)
                                userInstance.village_id = Street.findByNameIlikeAndDistrict_id(village, districtInstance)
                                if (userInstance.save(failOnError: true, flush: true)) {
                                  //  println("passed" + palines)
                                    def adminRole = MkpRole.findByAuthority('ROLE_CHW')
                                    def roleInstance = new MkpUserMkpRole()
                                    roleInstance.mkpUser = userInstance
                                    roleInstance.mkpRole = adminRole
                                    roleInstance.save(failOnError: true)


                                    try {
                                        def name = userInstance.first_name + " " + userInstance.last_name
                                        def phone_number = userInstance.phone_number

                                        // phone_number="255766545878"

                                        def msg = "Hello " + name + ", Your Chaid Username is " + userInstance.username + " and Password is " + code + ". Thanks."
                                        applicationService.saveSchedualLogs(userInstance, msg)


                                    } catch (Exception e) {
                                        // e.printStackTrace()
                                    }

                                }
                            } else {
                                def userInstance = MkpUser.findByUsername(userName)
                                def districtInstance = District.findByNameIlike(district)

                                userInstance.district_id = districtInstance
                                userInstance.facility = Facility.findByNameIlikeAndDistrict_id(facility, districtInstance)
                                def villageInstance= Street.findByNameIlikeAndDistrict_id(village, districtInstance)
                                userInstance.village_id =villageInstance

                               // System.out.println(village+" " +villageInstance)


                                userInstance.save(flush: true)
                            }
                        }
                        flash.message="Users uploaded!"
                    }
                }catch(Exception e){
                    e.printStackTrace()
                }

                palines++
            }

        }
        redirect action: "index"

    }

    def update(MkpUser mkpUser) {
        if (mkpUser == null) {
            notFound()
            return
        }

        try {
            mkpUserService.save(mkpUser)
        } catch (ValidationException e) {
            respond mkpUser.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'mkpUser.label', default: 'MkpUser'), mkpUser.id])
                redirect mkpUser
            }
            '*'{ respond mkpUser, [status: OK] }
        }
    }


    def searchUserList(){
        def searchText=params.search_string
        String searchstring="%"+searchText+"%"
        searchstring=searchstring.toLowerCase()
        //println(searchstring)
        params.max=150

        def userInstanceList=MkpUser.executeQuery("from MkpUser m " +
                " left join m.facility left join m.village_id left join m.district_id where " +
                " lower(m.district_id.region_id.name) like :searchstring or " +
                " lower(m.district_id.name) like :searchstring or " +
                " lower(m.village_id.name) like :searchstring or " +
                " lower(m.facility.name) like :searchstring or  " +
                "lower(m.full_name) like :searchstring or m.phone_number like :searchstring or  lower(m.username) like :searchstring  " +
                " ",[searchstring:searchstring],params)
       // println(userInstanceList)
        render(template: 'userlist',model: [mkpUserList:userInstanceList])

    }


    @org.springframework.transaction.annotation.Transactional
    def sendPasswordUser(){
        //  def optionData=Integer.parseInt(params.optionData)
        def code = getRandomNumber(1000, 9999)
        def userInstance = MkpUser.get(params.id)
        def passwords= Integer.toString(code)
        //userInstance.password =springSecurityService.encodePassword(passwords, null)
        userInstance.password=passwords
        userInstance.accountLocked = 0
        // println(code)
        if(userInstance.save(failOnError: true,flush:true)){
            //  flash.message="Password successfully sent!"
            flash.message="Password successfully sent! Password: "+code

            try {
                def name = userInstance.full_name
                def phone_number=userInstance.phone_number

                String msg="Hello "+name+", Your Chaid Username is "+userInstance.username+" and Password is "+code+". Thanks."
                applicationService.sendMessage(phone_number,msg)


            } catch (Exception e) {
                // e.printStackTrace()
            }

        }

        redirect(action: 'show',id:params.id)
    }

    private int getRandomNumber(int min,int max) {
        return (new Random()).nextInt((max - min) + 1) + min;
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        mkpUserService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'mkpUser.label', default: 'MkpUser'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'mkpUser.label', default: 'MkpUser'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
