package chaid

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*
@Secured(['ROLE_CORE_WEB','ROLE_ADMIN'])

class ChildUnderFiveImmunizationController {

    ChildUnderFiveImmunizationService childUnderFiveImmunizationService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond childUnderFiveImmunizationService.list(params), model:[childUnderFiveImmunizationCount: childUnderFiveImmunizationService.count()]
    }

    def show(Long id) {
        respond childUnderFiveImmunizationService.get(id)
    }

    def create() {
        respond new ChildUnderFiveImmunization(params)
    }

    def save(ChildUnderFiveImmunization childUnderFiveImmunization) {
        if (childUnderFiveImmunization == null) {
            notFound()
            return
        }

        try {
            childUnderFiveImmunizationService.save(childUnderFiveImmunization)
        } catch (ValidationException e) {
            respond childUnderFiveImmunization.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'childUnderFiveImmunization.label', default: 'ChildUnderFiveImmunization'), childUnderFiveImmunization.id])
                redirect childUnderFiveImmunization
            }
            '*' { respond childUnderFiveImmunization, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond childUnderFiveImmunizationService.get(id)
    }

    def update(ChildUnderFiveImmunization childUnderFiveImmunization) {
        if (childUnderFiveImmunization == null) {
            notFound()
            return
        }

        try {
            childUnderFiveImmunizationService.save(childUnderFiveImmunization)
        } catch (ValidationException e) {
            respond childUnderFiveImmunization.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'childUnderFiveImmunization.label', default: 'ChildUnderFiveImmunization'), childUnderFiveImmunization.id])
                redirect childUnderFiveImmunization
            }
            '*'{ respond childUnderFiveImmunization, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        childUnderFiveImmunizationService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'childUnderFiveImmunization.label', default: 'ChildUnderFiveImmunization'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'childUnderFiveImmunization.label', default: 'ChildUnderFiveImmunization'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
