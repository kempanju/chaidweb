package chaid

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*
@Secured("isAuthenticated()")
class ActivityTypeController {

    ActivityTypeService activityTypeService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond activityTypeService.list(params), model:[activityTypeCount: activityTypeService.count()]
    }

    def show(Long id) {
        respond activityTypeService.get(id)
    }

    def create() {
        respond new ActivityType(params)
    }

    def save(ActivityType activityType) {
        if (activityType == null) {
            notFound()
            return
        }

        try {
            activityTypeService.save(activityType)
        } catch (ValidationException e) {
            respond activityType.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'activityType.label', default: 'ActivityType'), activityType.id])
                redirect activityType
            }
            '*' { respond activityType, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond activityTypeService.get(id)
    }

    def update(ActivityType activityType) {
        if (activityType == null) {
            notFound()
            return
        }

        try {
            activityTypeService.save(activityType)
        } catch (ValidationException e) {
            respond activityType.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'activityType.label', default: 'ActivityType'), activityType.id])
                redirect activityType
            }
            '*'{ respond activityType, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        activityTypeService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'activityType.label', default: 'ActivityType'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'activityType.label', default: 'ActivityType'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
