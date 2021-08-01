package chaid

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*
@Secured(['ROLE_CORE_WEB','ROLE_ADMIN','ROLE_REGION','ROLE_DISTRICT'])
class HouseholdController {
    def springSecurityService

    HouseholdService householdService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    @Secured(['ROLE_CORE_WEB','ROLE_ADMIN'])
    def index(Integer max) {
        session["activePage"] = "household"
        if(!params.order) {
            params.sort = 'id'
            params.order = 'desc'
        }

        params.max = Math.min(max ?: 10, 100)
        respond householdService.list(params), model:[householdCount: householdService.count()]
    }

    @Secured(['ROLE_REGION'])
    def byRegion(Integer max) {
        session["activePage"] = "household"
        if(!params.order) {
            params.sort = 'id'
            params.order = 'desc'
        }
        def currentUser=springSecurityService.getCurrentUser()

        params.max = Math.min(max ?: 10, 100)
        def householdList=Household.executeQuery(" from Household  where district_id.region_id=:region and deleted=false",[region:currentUser.region],params)
        def householdCount=Household.executeQuery(" from Household  where district_id.region_id=:region and deleted=false",[region:currentUser.region] ).size()
        render view: 'byRegion',model:[householdList:householdList,householdCount: householdCount]
    }

    @Secured(['ROLE_DISTRICT'])
    def byDistrict(Integer max) {
        session["activePage"] = "household"
        if(!params.order) {
            params.sort = 'id'
            params.order = 'desc'
        }
        def currentUser=springSecurityService.getCurrentUser()

        params.max = Math.min(max ?: 10, 100)
        def householdList=Household.executeQuery(" from Household  where district_id=:district and deleted=false",[district:currentUser.district_id],params)
        def householdCount=Household.executeQuery(" from Household  where district_id=:district and deleted=false",[district:currentUser.district_id] ).size()
        render view: 'byDistrict',model:[householdList:householdList,householdCount: householdCount]
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
