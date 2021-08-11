package chaid

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class ReferalAdolescentController {

    ReferalAdolescentService referalAdolescentService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond referalAdolescentService.list(params), model:[referalAdolescentCount: referalAdolescentService.count()]
    }

    def show(Long id) {
        respond referalAdolescentService.get(id)
    }

    def create() {
        respond new ReferalAdolescent(params)
    }

    def save(ReferalAdolescent referalAdolescent) {
        if (referalAdolescent == null) {
            notFound()
            return
        }

        try {
            referalAdolescentService.save(referalAdolescent)
        } catch (ValidationException e) {
            respond referalAdolescent.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'referalAdolescent.label', default: 'ReferalAdolescent'), referalAdolescent.id])
                redirect referalAdolescent
            }
            '*' { respond referalAdolescent, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond referalAdolescentService.get(id)
    }

    def update(ReferalAdolescent referalAdolescent) {
        if (referalAdolescent == null) {
            notFound()
            return
        }

        try {
            referalAdolescentService.save(referalAdolescent)
        } catch (ValidationException e) {
            respond referalAdolescent.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'referalAdolescent.label', default: 'ReferalAdolescent'), referalAdolescent.id])
                redirect referalAdolescent
            }
            '*'{ respond referalAdolescent, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        referalAdolescentService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'referalAdolescent.label', default: 'ReferalAdolescent'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'referalAdolescent.label', default: 'ReferalAdolescent'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
