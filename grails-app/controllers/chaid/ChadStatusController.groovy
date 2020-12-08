package chaid

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*
@Secured("isAuthenticated()")
class ChadStatusController {

    ChadStatusService chadStatusService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond chadStatusService.list(params), model:[chadStatusCount: chadStatusService.count()]
    }

    def show(Long id) {
        respond chadStatusService.get(id)
    }

    def create() {
        respond new ChadStatus(params)
    }

    def save(ChadStatus chadStatus) {
        if (chadStatus == null) {
            notFound()
            return
        }

        try {
            chadStatusService.save(chadStatus)
        } catch (ValidationException e) {
            respond chadStatus.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'chadStatus.label', default: 'ChadStatus'), chadStatus.id])
                redirect chadStatus
            }
            '*' { respond chadStatus, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond chadStatusService.get(id)
    }

    def update(ChadStatus chadStatus) {
        if (chadStatus == null) {
            notFound()
            return
        }

        try {
            chadStatusService.save(chadStatus)
        } catch (ValidationException e) {
            respond chadStatus.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'chadStatus.label', default: 'ChadStatus'), chadStatus.id])
                redirect chadStatus
            }
            '*'{ respond chadStatus, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        chadStatusService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'chadStatus.label', default: 'ChadStatus'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'chadStatus.label', default: 'ChadStatus'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
