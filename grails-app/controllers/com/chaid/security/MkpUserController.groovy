package com.chaid.security

import chaid.ApplicationService
import grails.gorm.transactions.Transactional
import grails.plugin.springsecurity.annotation.Secured
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
        params.max=20

        def userInstanceList=MkpUser.executeQuery("from MkpUser where  lower(full_name) like :searchstring or phone_number like :searchstring or  lower(username) like :searchstring ",[searchstring:searchstring],params)
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
