package materialize.view

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class DistrictReportController {

    DistrictReportService districtReportService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond districtReportService.list(params), model:[districtReportCount: districtReportService.count()]
    }

    def show(Long id) {
        respond districtReportService.get(id)
    }

    def create() {
        respond new DistrictReport(params)
    }

    def save(DistrictReport districtReport) {
        if (districtReport == null) {
            notFound()
            return
        }

        try {
            districtReportService.save(districtReport)
        } catch (ValidationException e) {
            respond districtReport.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'districtReport.label', default: 'DistrictReport'), districtReport.id])
                redirect districtReport
            }
            '*' { respond districtReport, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond districtReportService.get(id)
    }

    def update(DistrictReport districtReport) {
        if (districtReport == null) {
            notFound()
            return
        }

        try {
            districtReportService.save(districtReport)
        } catch (ValidationException e) {
            respond districtReport.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'districtReport.label', default: 'DistrictReport'), districtReport.id])
                redirect districtReport
            }
            '*'{ respond districtReport, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        districtReportService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'districtReport.label', default: 'DistrictReport'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'districtReport.label', default: 'DistrictReport'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
