package admin

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*
@Secured(['ROLE_CORE_WEB','ROLE_ADMIN'])
class WardsController {

    WardsService wardsService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        session["activePage"] = "location"

        params.max = Math.min(max ?: 10, 100)
        respond wardsService.list(params), model:[wardsCount: wardsService.count()]
    }

    def show(Long id) {
        respond wardsService.get(id)
    }


    def searchWardList(){

        def searchText=params.search_string
        def searchstring="%"+searchText+"%".toLowerCase()
        //println(searchstring)

        params.max=20
        params.sort = 'id'
        params.order = 'desc'
        def wardInstanceList=Wards.executeQuery("from Wards where lower(name) like :searchstring or  lower(district_id.name) like :searchstring ",[searchstring:searchstring],params)

        render(template: 'wardlist',model: [wardsList:wardInstanceList])
    }


    def create() {
        respond new Wards(params)
    }

    def save(Wards wards) {
        if (wards == null) {
            notFound()
            return
        }

        try {
            wardsService.save(wards)
        } catch (ValidationException e) {
            respond wards.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'wards.label', default: 'Wards'), wards.id])
                redirect wards
            }
            '*' { respond wards, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond wardsService.get(id)
    }

    def update(Wards wards) {
        if (wards == null) {
            notFound()
            return
        }

        try {
            wardsService.save(wards)
        } catch (ValidationException e) {
            respond wards.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'wards.label', default: 'Wards'), wards.id])
                redirect wards
            }
            '*'{ respond wards, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        wardsService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'wards.label', default: 'Wards'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'wards.label', default: 'Wards'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
