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

    def pdfRenderingSample(){
        //def bytes = pdfRenderingService.render(template:'/pdf/countrymonthlyreporttwo')
       // render bytes.toString()
        String selectedOption = session.selectedOption2
        def from_date = session.from_date2
        def end_date = session.end_date2
        def regionId = session.region2
        def districtId = session.districtId2

        if(selectedOption.equals("region")){
            def regionInstance= Region.get(regionId)

            renderPdf(template: "/pdf/regionmonthlyreporttwo", filename: regionInstance.name+".pdf", model: [regionInstance:regionInstance,from_date: from_date, end_date: end_date])

        } else if(selectedOption.equals("district")){
            def districtInstance= District.get(districtId)
            renderPdf(template: "/pdf/districtmonthlyreporttwo", filename: districtInstance.name+".pdf", model: [districtInstance:districtInstance,from_date: from_date, end_date: end_date])

        } else {
            renderPdf(template: "/pdf/countrymonthlyreporttwo", filename: System.currentTimeMillis()+".pdf", model: [from_date: from_date, end_date: end_date])
        }
    }

    def reportByDate(){
        def  selectedOption= params.selectedOption
        def from_date=params.from_date
        def end_date=params.end_date

        session.selectedOption2 = selectedOption
        session.from_date2 = from_date
        session.end_date2 = end_date

        // println(params)
        // println(params)
       if( selectedOption&& selectedOption.equals("region")){
           def regionId = params.region_id
           session.region2 = regionId

           def regionInstance= Region.get(regionId)
            render template: '/monthlyReport/regionmonthlydata',model: [regionInstance:regionInstance,from_date:from_date,end_date:end_date]
        }else if(selectedOption&& selectedOption.equals("district")){
            def districtId = params.district_id
            def districtInstance= District.get(districtId)
           session.districtId2 = districtId

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
