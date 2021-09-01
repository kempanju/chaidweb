package materialize.view

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class RegionReportController {

    RegionReportService regionReportService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond regionReportService.list(params), model:[regionReportCount: regionReportService.count()]
    }

    def show(Long id) {
        respond regionReportService.get(id)
    }

    def create() {
        respond new RegionReport(params)
    }

    def save(RegionReport regionReport) {
        if (regionReport == null) {
            notFound()
            return
        }

        try {
            regionReportService.save(regionReport)
        } catch (ValidationException e) {
            respond regionReport.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'regionReport.label', default: 'RegionReport'), regionReport.id])
                redirect regionReport
            }
            '*' { respond regionReport, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond regionReportService.get(id)
    }

    def update(RegionReport regionReport) {
        if (regionReport == null) {
            notFound()
            return
        }

        try {
            regionReportService.save(regionReport)
        } catch (ValidationException e) {
            respond regionReport.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'regionReport.label', default: 'RegionReport'), regionReport.id])
                redirect regionReport
            }
            '*'{ respond regionReport, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        regionReportService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'regionReport.label', default: 'RegionReport'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'regionReport.label', default: 'RegionReport'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
