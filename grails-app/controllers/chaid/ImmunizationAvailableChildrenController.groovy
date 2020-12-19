package chaid

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*
@Secured("isAuthenticated()")
class ImmunizationAvailableChildrenController {

    ImmunizationAvailableChildrenService immunizationAvailableChildrenService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond immunizationAvailableChildrenService.list(params), model:[immunizationAvailableChildrenCount: immunizationAvailableChildrenService.count()]
    }

    def show(Long id) {
        respond immunizationAvailableChildrenService.get(id)
    }

    def create() {
        respond new ImmunizationAvailableChildren(params)
    }

    def save(ImmunizationAvailableChildren immunizationAvailableChildren) {
        if (immunizationAvailableChildren == null) {
            notFound()
            return
        }

        try {
            immunizationAvailableChildrenService.save(immunizationAvailableChildren)
        } catch (ValidationException e) {
            respond immunizationAvailableChildren.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'immunizationAvailableChildren.label', default: 'ImmunizationAvailableChildren'), immunizationAvailableChildren.id])
                redirect immunizationAvailableChildren
            }
            '*' { respond immunizationAvailableChildren, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond immunizationAvailableChildrenService.get(id)
    }

    def update(ImmunizationAvailableChildren immunizationAvailableChildren) {
        if (immunizationAvailableChildren == null) {
            notFound()
            return
        }

        try {
            immunizationAvailableChildrenService.save(immunizationAvailableChildren)
        } catch (ValidationException e) {
            respond immunizationAvailableChildren.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'immunizationAvailableChildren.label', default: 'ImmunizationAvailableChildren'), immunizationAvailableChildren.id])
                redirect immunizationAvailableChildren
            }
            '*'{ respond immunizationAvailableChildren, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        immunizationAvailableChildrenService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'immunizationAvailableChildren.label', default: 'ImmunizationAvailableChildren'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'immunizationAvailableChildren.label', default: 'ImmunizationAvailableChildren'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
