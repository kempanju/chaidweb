package materialize.view

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class ViewHealthEducationController {

    ViewHealthEducationService viewHealthEducationService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond viewHealthEducationService.list(params), model:[viewHealthEducationCount: viewHealthEducationService.count()]
    }

    def show(Long id) {
        respond viewHealthEducationService.get(id)
    }

    def create() {
        respond new ViewHealthEducation(params)
    }

    def save(ViewHealthEducation viewHealthEducation) {
        if (viewHealthEducation == null) {
            notFound()
            return
        }

        try {
            viewHealthEducationService.save(viewHealthEducation)
        } catch (ValidationException e) {
            respond viewHealthEducation.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'viewHealthEducation.label', default: 'ViewHealthEducation'), viewHealthEducation.id])
                redirect viewHealthEducation
            }
            '*' { respond viewHealthEducation, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond viewHealthEducationService.get(id)
    }

    def update(ViewHealthEducation viewHealthEducation) {
        if (viewHealthEducation == null) {
            notFound()
            return
        }

        try {
            viewHealthEducationService.save(viewHealthEducation)
        } catch (ValidationException e) {
            respond viewHealthEducation.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'viewHealthEducation.label', default: 'ViewHealthEducation'), viewHealthEducation.id])
                redirect viewHealthEducation
            }
            '*'{ respond viewHealthEducation, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        viewHealthEducationService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'viewHealthEducation.label', default: 'ViewHealthEducation'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'viewHealthEducation.label', default: 'ViewHealthEducation'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
