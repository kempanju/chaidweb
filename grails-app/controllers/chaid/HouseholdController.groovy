package chaid

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*
@Secured("isAuthenticated()")
class HouseholdController {

    HouseholdService householdService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        session["activePage"] = "household"
        if(!params.order) {
            params.sort = 'id'
            params.order = 'desc'
        }

        params.max = Math.min(max ?: 10, 100)
        respond householdService.list(params), model:[householdCount: householdService.count()]
    }

    def show(Long id) {
        respond householdService.get(id)
    }

    def create() {
        respond new Household(params)
    }

    def save(Household household) {
        if (household == null) {
            notFound()
            return
        }

        try {
            householdService.save(household)
        } catch (ValidationException e) {
            respond household.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'household.label', default: 'Household'), household.id])
                redirect household
            }
            '*' { respond household, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond householdService.get(id)
    }

    def update(Household household) {
        if (household == null) {
            notFound()
            return
        }

        try {
            householdService.save(household)
        } catch (ValidationException e) {
            respond household.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'household.label', default: 'Household'), household.id])
                redirect household
            }
            '*'{ respond household, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        householdService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'household.label', default: 'Household'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'household.label', default: 'Household'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
