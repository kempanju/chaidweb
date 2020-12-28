package admin

import com.chaid.security.MkpUser
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*
@Secured("isAuthenticated()")
class SystemLogsController {

    SystemLogsService systemLogsService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        session["activePage"] = "logs"
        if(!params.order) {
            params.sort = 'id'
            params.order = 'desc'
        }
        params.max = Math.min(max ?: 10, 100)
        respond systemLogsService.list(params), model:[systemLogsCount: systemLogsService.count()]
    }

    def show(Long id) {
        respond systemLogsService.get(id)
    }

    def create() {
        respond new SystemLogs(params)
    }

    def save(SystemLogs systemLogs) {
        if (systemLogs == null) {
            notFound()
            return
        }

        try {
            systemLogsService.save(systemLogs)
        } catch (ValidationException e) {
            respond systemLogs.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'systemLogs.label', default: 'SystemLogs'), systemLogs.id])
                redirect systemLogs
            }
            '*' { respond systemLogs, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond systemLogsService.get(id)
    }

    def update(SystemLogs systemLogs) {
        if (systemLogs == null) {
            notFound()
            return
        }

        try {
            systemLogsService.save(systemLogs)
        } catch (ValidationException e) {
            respond systemLogs.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'systemLogs.label', default: 'SystemLogs'), systemLogs.id])
                redirect systemLogs
            }
            '*'{ respond systemLogs, [status: OK] }
        }
    }

    def searchLogsList(){
        def searchText=params.search_string
        String searchstring="%"+searchText+"%"
        searchstring=searchstring.toLowerCase()
        params.max=20
        params.sort = 'id'
        params.order = 'desc'
        println(searchstring)
        def logInstanceList= SystemLogs.executeQuery("from SystemLogs where  message like :searchstring or lower(user_id.full_name) like :searchstring or  lower(facility.name) like :searchstring",[searchstring:searchstring],params)
        println(logInstanceList)
        render(template: 'logslist',model: [systemLogsList:logInstanceList])
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        systemLogsService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'systemLogs.label', default: 'SystemLogs'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'systemLogs.label', default: 'SystemLogs'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
