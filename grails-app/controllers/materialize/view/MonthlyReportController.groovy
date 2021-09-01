package materialize.view

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class MonthlyReportController {

    MonthlyReportService monthlyReportService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond monthlyReportService.list(params), model:[monthlyReportCount: monthlyReportService.count()]
    }

    def show(Long id) {
        respond monthlyReportService.get(id)
    }

    def create() {
        respond new MonthlyReport(params)
    }

    def save(MonthlyReport monthlyReport) {
        if (monthlyReport == null) {
            notFound()
            return
        }

        try {
            monthlyReportService.save(monthlyReport)
        } catch (ValidationException e) {
            respond monthlyReport.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'monthlyReport.label', default: 'MonthlyReport'), monthlyReport.id])
                redirect monthlyReport
            }
            '*' { respond monthlyReport, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond monthlyReportService.get(id)
    }

    def update(MonthlyReport monthlyReport) {
        if (monthlyReport == null) {
            notFound()
            return
        }

        try {
            monthlyReportService.save(monthlyReport)
        } catch (ValidationException e) {
            respond monthlyReport.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'monthlyReport.label', default: 'MonthlyReport'), monthlyReport.id])
                redirect monthlyReport
            }
            '*'{ respond monthlyReport, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        monthlyReportService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'monthlyReport.label', default: 'MonthlyReport'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'monthlyReport.label', default: 'MonthlyReport'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
