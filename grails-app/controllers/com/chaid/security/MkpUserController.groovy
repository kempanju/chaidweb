package com.chaid.security

import grails.gorm.transactions.Transactional
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*
@Secured("isAuthenticated()")
class MkpUserController {

    MkpUserService mkpUserService

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
            mkpUser.username=params.email_address
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
