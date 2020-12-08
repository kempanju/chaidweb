package chaid

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class DangerSignPregnantController {

    DangerSignPregnantService dangerSignPregnantService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond dangerSignPregnantService.list(params), model:[dangerSignPregnantCount: dangerSignPregnantService.count()]
    }

    def show(Long id) {
        respond dangerSignPregnantService.get(id)
    }

    def create() {
        respond new DangerSignPregnant(params)
    }

    def save(DangerSignPregnant dangerSignPregnant) {
        if (dangerSignPregnant == null) {
            notFound()
            return
        }

        try {
            dangerSignPregnantService.save(dangerSignPregnant)
        } catch (ValidationException e) {
            respond dangerSignPregnant.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'dangerSignPregnant.label', default: 'DangerSignPregnant'), dangerSignPregnant.id])
                redirect dangerSignPregnant
            }
            '*' { respond dangerSignPregnant, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond dangerSignPregnantService.get(id)
    }

    def update(DangerSignPregnant dangerSignPregnant) {
        if (dangerSignPregnant == null) {
            notFound()
            return
        }

        try {
            dangerSignPregnantService.save(dangerSignPregnant)
        } catch (ValidationException e) {
            respond dangerSignPregnant.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'dangerSignPregnant.label', default: 'DangerSignPregnant'), dangerSignPregnant.id])
                redirect dangerSignPregnant
            }
            '*'{ respond dangerSignPregnant, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        dangerSignPregnantService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'dangerSignPregnant.label', default: 'DangerSignPregnant'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'dangerSignPregnant.label', default: 'DangerSignPregnant'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
