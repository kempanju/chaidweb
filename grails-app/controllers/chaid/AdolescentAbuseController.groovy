package chaid

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class AdolescentAbuseController {

    AdolescentAbuseService adolescentAbuseService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond adolescentAbuseService.list(params), model:[adolescentAbuseCount: adolescentAbuseService.count()]
    }

    def show(Long id) {
        respond adolescentAbuseService.get(id)
    }

    def create() {
        respond new AdolescentAbuse(params)
    }

    def save(AdolescentAbuse adolescentAbuse) {
        if (adolescentAbuse == null) {
            notFound()
            return
        }

        try {
            adolescentAbuseService.save(adolescentAbuse)
        } catch (ValidationException e) {
            respond adolescentAbuse.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'adolescentAbuse.label', default: 'AdolescentAbuse'), adolescentAbuse.id])
                redirect adolescentAbuse
            }
            '*' { respond adolescentAbuse, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond adolescentAbuseService.get(id)
    }

    def update(AdolescentAbuse adolescentAbuse) {
        if (adolescentAbuse == null) {
            notFound()
            return
        }

        try {
            adolescentAbuseService.save(adolescentAbuse)
        } catch (ValidationException e) {
            respond adolescentAbuse.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'adolescentAbuse.label', default: 'AdolescentAbuse'), adolescentAbuse.id])
                redirect adolescentAbuse
            }
            '*'{ respond adolescentAbuse, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        adolescentAbuseService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'adolescentAbuse.label', default: 'AdolescentAbuse'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'adolescentAbuse.label', default: 'AdolescentAbuse'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
