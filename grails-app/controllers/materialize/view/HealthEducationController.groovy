package materialize.view

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class HealthEducationController {

    HealthEducationService healthEducationService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond healthEducationService.list(params), model:[healthEducationCount: healthEducationService.count()]
    }

    def show(Long id) {
        respond healthEducationService.get(id)
    }

    def create() {
        respond new HealthEducation(params)
    }

    def save(HealthEducation healthEducation) {
        if (healthEducation == null) {
            notFound()
            return
        }

        try {
            healthEducationService.save(healthEducation)
        } catch (ValidationException e) {
            respond healthEducation.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'healthEducation.label', default: 'HealthEducation'), healthEducation.id])
                redirect healthEducation
            }
            '*' { respond healthEducation, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond healthEducationService.get(id)
    }

    def update(HealthEducation healthEducation) {
        if (healthEducation == null) {
            notFound()
            return
        }

        try {
            healthEducationService.save(healthEducation)
        } catch (ValidationException e) {
            respond healthEducation.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'healthEducation.label', default: 'HealthEducation'), healthEducation.id])
                redirect healthEducation
            }
            '*'{ respond healthEducation, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        healthEducationService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'healthEducation.label', default: 'HealthEducation'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'healthEducation.label', default: 'HealthEducation'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
