package chaid

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class AdolescentController {

    AdolescentService adolescentService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond adolescentService.list(params), model:[adolescentCount: adolescentService.count()]
    }

    def show(Long id) {
        respond adolescentService.get(id)
    }

    def create() {
        respond new Adolescent(params)
    }

    def save(Adolescent adolescent) {
        if (adolescent == null) {
            notFound()
            return
        }

        try {
            adolescentService.save(adolescent)
        } catch (ValidationException e) {
            respond adolescent.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'adolescent.label', default: 'Adolescent'), adolescent.id])
                redirect adolescent
            }
            '*' { respond adolescent, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond adolescentService.get(id)
    }

    def update(Adolescent adolescent) {
        if (adolescent == null) {
            notFound()
            return
        }

        try {
            adolescentService.save(adolescent)
        } catch (ValidationException e) {
            respond adolescent.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'adolescent.label', default: 'Adolescent'), adolescent.id])
                redirect adolescent
            }
            '*'{ respond adolescent, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        adolescentService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'adolescent.label', default: 'Adolescent'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'adolescent.label', default: 'Adolescent'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
