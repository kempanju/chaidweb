package admin

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*
@Secured(['ROLE_CORE_WEB','ROLE_ADMIN'])
class SubStreetController {

    SubStreetService subStreetService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        session["activePage"] = "location"

        params.max = Math.min(max ?: 10, 100)
        respond subStreetService.list(params), model:[subStreetCount: subStreetService.count()]
    }

    def show(Long id) {
        respond subStreetService.get(id)
    }

    def create() {
        respond new SubStreet(params)
    }

    def save(SubStreet subStreet) {
        if (subStreet == null) {
            notFound()
            return
        }

        try {
            subStreetService.save(subStreet)
        } catch (ValidationException e) {
            respond subStreet.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'subStreet.label', default: 'SubStreet'), subStreet.id])
                redirect subStreet
            }
            '*' { respond subStreet, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond subStreetService.get(id)
    }


    def searchStreetList(){

        def searchText=params.search_string
        def searchstring="%"+searchText+"%".toLowerCase()
        //println(searchstring)

        params.max=50
        params.sort = 'id'
        params.order = 'desc'
        def subStreetInstanceList=SubStreet.executeQuery("from SubStreet where lower(name) like :searchstring or  lower(village_id.name) like :searchstring  ",[searchstring:searchstring],params)

        render(template: 'village',model: [subStreetList:subStreetInstanceList])
    }

    def update(SubStreet subStreet) {
        if (subStreet == null) {
            notFound()
            return
        }

        try {
            subStreetService.save(subStreet)
        } catch (ValidationException e) {
            respond subStreet.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'subStreet.label', default: 'SubStreet'), subStreet.id])
                redirect subStreet
            }
            '*'{ respond subStreet, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        subStreetService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'subStreet.label', default: 'SubStreet'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'subStreet.label', default: 'SubStreet'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
