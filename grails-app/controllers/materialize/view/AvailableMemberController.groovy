package materialize.view

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class AvailableMemberController {

    AvailableMemberService availableMemberService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond availableMemberService.list(params), model:[availableMemberCount: availableMemberService.count()]
    }

    def show(Long id) {
        respond availableMemberService.get(id)
    }

    def create() {
        respond new AvailableMember(params)
    }

    def save(AvailableMember availableMember) {
        if (availableMember == null) {
            notFound()
            return
        }

        try {
            availableMemberService.save(availableMember)
        } catch (ValidationException e) {
            respond availableMember.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'availableMember.label', default: 'AvailableMember'), availableMember.id])
                redirect availableMember
            }
            '*' { respond availableMember, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond availableMemberService.get(id)
    }

    def update(AvailableMember availableMember) {
        if (availableMember == null) {
            notFound()
            return
        }

        try {
            availableMemberService.save(availableMember)
        } catch (ValidationException e) {
            respond availableMember.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'availableMember.label', default: 'AvailableMember'), availableMember.id])
                redirect availableMember
            }
            '*'{ respond availableMember, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        availableMemberService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'availableMember.label', default: 'AvailableMember'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'availableMember.label', default: 'AvailableMember'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
