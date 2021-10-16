package chaid

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class EpidemicController {

    EpidemicService epidemicService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond epidemicService.list(params), model:[epidemicCount: epidemicService.count()]
    }

    def show(Long id) {
        respond epidemicService.get(id)
    }

    def create() {
        respond new Epidemic(params)
    }

    def save(Epidemic epidemic) {
        if (epidemic == null) {
            notFound()
            return
        }

        try {
            epidemicService.save(epidemic)
        } catch (ValidationException e) {
            respond epidemic.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'epidemic.label', default: 'Epidemic'), epidemic.id])
                redirect epidemic
            }
            '*' { respond epidemic, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond epidemicService.get(id)
    }

    def update(Epidemic epidemic) {
        if (epidemic == null) {
            notFound()
            return
        }

        try {
            epidemicService.save(epidemic)
        } catch (ValidationException e) {
            respond epidemic.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'epidemic.label', default: 'Epidemic'), epidemic.id])
                redirect epidemic
            }
            '*'{ respond epidemic, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        epidemicService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'epidemic.label', default: 'Epidemic'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'epidemic.label', default: 'Epidemic'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
