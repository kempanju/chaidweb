package materialize.view

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class YearReportsController {

    YearReportsService yearReportsService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond yearReportsService.list(params), model:[yearReportsCount: yearReportsService.count()]
    }

    def show(Long id) {
        respond yearReportsService.get(id)
    }

    def create() {
        respond new YearReports(params)
    }

    def save(YearReports yearReports) {
        if (yearReports == null) {
            notFound()
            return
        }

        try {
            yearReportsService.save(yearReports)
        } catch (ValidationException e) {
            respond yearReports.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'yearReports.label', default: 'YearReports'), yearReports.id])
                redirect yearReports
            }
            '*' { respond yearReports, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond yearReportsService.get(id)
    }

    def update(YearReports yearReports) {
        if (yearReports == null) {
            notFound()
            return
        }

        try {
            yearReportsService.save(yearReports)
        } catch (ValidationException e) {
            respond yearReports.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'yearReports.label', default: 'YearReports'), yearReports.id])
                redirect yearReports
            }
            '*'{ respond yearReports, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        yearReportsService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'yearReports.label', default: 'YearReports'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'yearReports.label', default: 'YearReports'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
