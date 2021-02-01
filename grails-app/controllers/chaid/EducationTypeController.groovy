package chaid

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*
@Secured(['ROLE_CORE_WEB','ROLE_ADMIN'])
class EducationTypeController {

    EducationTypeService educationTypeService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond educationTypeService.list(params), model:[educationTypeCount: educationTypeService.count()]
    }

    def show(Long id) {
        respond educationTypeService.get(id)
    }

    def create() {
        respond new EducationType(params)
    }

    def save(EducationType educationType) {
        if (educationType == null) {
            notFound()
            return
        }

        try {
            educationTypeService.save(educationType)
        } catch (ValidationException e) {
            respond educationType.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'educationType.label', default: 'EducationType'), educationType.id])
                redirect educationType
            }
            '*' { respond educationType, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond educationTypeService.get(id)
    }

    def update(EducationType educationType) {
        if (educationType == null) {
            notFound()
            return
        }

        try {
            educationTypeService.save(educationType)
        } catch (ValidationException e) {
            respond educationType.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'educationType.label', default: 'EducationType'), educationType.id])
                redirect educationType
            }
            '*'{ respond educationType, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        educationTypeService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'educationType.label', default: 'EducationType'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'educationType.label', default: 'EducationType'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
