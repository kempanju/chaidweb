package materialize.view

import admin.District
import admin.Region
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

@Secured("isAuthenticated()")
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

    def reportByDate(){
        def  selectedOption= params.selectedOption
        def from_date=params.from_date
        def end_date=params.end_date
       // println(params)
        // println(params)
       if( selectedOption&& selectedOption.equals("region")){
            def regionInstance= Region.get(params.region_id)
            render template: '/monthlyReport/regionmonthlydata',model: [regionInstance:regionInstance,from_date:from_date,end_date:end_date]
        }else if(selectedOption&& selectedOption.equals("district")){
            def districtInstance= District.get(params.district_id)
            render template: '/monthlyReport/districtmonthlydata',model: [districtInstance:districtInstance,from_date:from_date,end_date:end_date]
        }else {
          // if(from_date && end_date){
               render template: '/monthlyReport/statemonthlydata',model: [from_date:from_date,end_date:end_date]

          /* } else {
               render " Select date range"
           }*/
        }
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
