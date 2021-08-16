package materialize.view

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class DangerSignController {

    DangerSignService dangerSignService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond dangerSignService.list(params), model:[dangerSignCount: dangerSignService.count()]
    }

    def show(Long id) {
        respond dangerSignService.get(id)
    }

    def create() {
        respond new DangerSign(params)
    }

    def save(DangerSign dangerSign) {
        if (dangerSign == null) {
            notFound()
            return
        }

        try {
            dangerSignService.save(dangerSign)
        } catch (ValidationException e) {
            respond dangerSign.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'dangerSign.label', default: 'DangerSign'), dangerSign.id])
                redirect dangerSign
            }
            '*' { respond dangerSign, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond dangerSignService.get(id)
    }

    def update(DangerSign dangerSign) {
        if (dangerSign == null) {
            notFound()
            return
        }

        try {
            dangerSignService.save(dangerSign)
        } catch (ValidationException e) {
            respond dangerSign.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'dangerSign.label', default: 'DangerSign'), dangerSign.id])
                redirect dangerSign
            }
            '*'{ respond dangerSign, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        dangerSignService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'dangerSign.label', default: 'DangerSign'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'dangerSign.label', default: 'DangerSign'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
