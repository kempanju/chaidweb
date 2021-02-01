package chaid

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*
@Secured(['ROLE_CORE_WEB','ROLE_ADMIN'])
class FacilityController {

    FacilityService facilityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        session["activePage"] = "facility"

        params.max = Math.min(max ?: 10, 100)
        respond facilityService.list(params), model:[facilityCount: facilityService.count()]
    }

    def show(Long id) {
        respond facilityService.get(id)
    }

    def create() {
        respond new Facility(params)
    }

    def save(Facility facility) {
        if (facility == null) {
            notFound()
            return
        }

        try {
            facilityService.save(facility)
        } catch (ValidationException e) {
            respond facility.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'facility.label', default: 'Facility'), facility.id])
                redirect facility
            }
            '*' { respond facility, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond facilityService.get(id)
    }

    def update(Facility facility) {
        if (facility == null) {
            notFound()
            return
        }

        try {
            facilityService.save(facility)
        } catch (ValidationException e) {
            respond facility.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'facility.label', default: 'Facility'), facility.id])
                redirect facility
            }
            '*'{ respond facility, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        facilityService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'facility.label', default: 'Facility'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'facility.label', default: 'Facility'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
