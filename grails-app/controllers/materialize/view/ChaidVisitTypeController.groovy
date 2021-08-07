package materialize.view

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class ChaidVisitTypeController {

    ChaidVisitTypeService chaidVisitTypeService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond chaidVisitTypeService.list(params), model:[chaidVisitTypeCount: chaidVisitTypeService.count()]
    }

    def show(Long id) {
        respond chaidVisitTypeService.get(id)
    }

    def create() {
        respond new ChaidVisitType(params)
    }

    def save(ChaidVisitType chaidVisitType) {
        if (chaidVisitType == null) {
            notFound()
            return
        }

        try {
            chaidVisitTypeService.save(chaidVisitType)
        } catch (ValidationException e) {
            respond chaidVisitType.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'chaidVisitType.label', default: 'ChaidVisitType'), chaidVisitType.id])
                redirect chaidVisitType
            }
            '*' { respond chaidVisitType, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond chaidVisitTypeService.get(id)
    }

    def update(ChaidVisitType chaidVisitType) {
        if (chaidVisitType == null) {
            notFound()
            return
        }

        try {
            chaidVisitTypeService.save(chaidVisitType)
        } catch (ValidationException e) {
            respond chaidVisitType.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'chaidVisitType.label', default: 'ChaidVisitType'), chaidVisitType.id])
                redirect chaidVisitType
            }
            '*'{ respond chaidVisitType, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        chaidVisitTypeService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'chaidVisitType.label', default: 'ChaidVisitType'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'chaidVisitType.label', default: 'ChaidVisitType'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
