package chaid

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*
@Secured(['ROLE_CORE_WEB','ROLE_ADMIN'])
class DangerSignAvailableChildrenController {

    DangerSignAvailableChildrenService dangerSignAvailableChildrenService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond dangerSignAvailableChildrenService.list(params), model:[dangerSignAvailableChildrenCount: dangerSignAvailableChildrenService.count()]
    }

    def show(Long id) {
        respond dangerSignAvailableChildrenService.get(id)
    }

    def create() {
        respond new DangerSignAvailableChildren(params)
    }

    def save(DangerSignAvailableChildren dangerSignAvailableChildren) {
        if (dangerSignAvailableChildren == null) {
            notFound()
            return
        }

        try {
            dangerSignAvailableChildrenService.save(dangerSignAvailableChildren)
        } catch (ValidationException e) {
            respond dangerSignAvailableChildren.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'dangerSignAvailableChildren.label', default: 'DangerSignAvailableChildren'), dangerSignAvailableChildren.id])
                redirect dangerSignAvailableChildren
            }
            '*' { respond dangerSignAvailableChildren, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond dangerSignAvailableChildrenService.get(id)
    }

    def update(DangerSignAvailableChildren dangerSignAvailableChildren) {
        if (dangerSignAvailableChildren == null) {
            notFound()
            return
        }

        try {
            dangerSignAvailableChildrenService.save(dangerSignAvailableChildren)
        } catch (ValidationException e) {
            respond dangerSignAvailableChildren.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'dangerSignAvailableChildren.label', default: 'DangerSignAvailableChildren'), dangerSignAvailableChildren.id])
                redirect dangerSignAvailableChildren
            }
            '*'{ respond dangerSignAvailableChildren, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        dangerSignAvailableChildrenService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'dangerSignAvailableChildren.label', default: 'DangerSignAvailableChildren'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'dangerSignAvailableChildren.label', default: 'DangerSignAvailableChildren'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
