package materialize.view

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*
import grails.plugin.springsecurity.annotation.Secured

@Secured("isAuthenticated()")
class ChaidMeetingTypeController {

    ChaidMeetingTypeService chaidMeetingTypeService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond chaidMeetingTypeService.list(params), model:[chaidMeetingTypeCount: chaidMeetingTypeService.count()]
    }

    def show(Long id) {
        respond chaidMeetingTypeService.get(id)
    }

    def create() {
        respond new ChaidMeetingType(params)
    }

    def save(ChaidMeetingType chaidMeetingType) {
        if (chaidMeetingType == null) {
            notFound()
            return
        }

        try {
            chaidMeetingTypeService.save(chaidMeetingType)
        } catch (ValidationException e) {
            respond chaidMeetingType.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'chaidMeetingType.label', default: 'ChaidMeetingType'), chaidMeetingType.id])
                redirect chaidMeetingType
            }
            '*' { respond chaidMeetingType, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond chaidMeetingTypeService.get(id)
    }

    def update(ChaidMeetingType chaidMeetingType) {
        if (chaidMeetingType == null) {
            notFound()
            return
        }

        try {
            chaidMeetingTypeService.save(chaidMeetingType)
        } catch (ValidationException e) {
            respond chaidMeetingType.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'chaidMeetingType.label', default: 'ChaidMeetingType'), chaidMeetingType.id])
                redirect chaidMeetingType
            }
            '*'{ respond chaidMeetingType, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        chaidMeetingTypeService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'chaidMeetingType.label', default: 'ChaidMeetingType'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'chaidMeetingType.label', default: 'ChaidMeetingType'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
