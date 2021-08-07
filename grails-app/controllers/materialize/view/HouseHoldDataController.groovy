package materialize.view

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*
class HouseHoldDataController {

    HouseHoldDataService houseHoldDataService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond houseHoldDataService.list(params), model:[houseHoldDataCount: houseHoldDataService.count()]
    }

    def show(Long id) {
        respond houseHoldDataService.get(id)
    }

    def create() {
        respond new HouseHoldData(params)
    }

    def save(HouseHoldData houseHoldData) {
        if (houseHoldData == null) {
            notFound()
            return
        }

        try {
            houseHoldDataService.save(houseHoldData)
        } catch (ValidationException e) {
            respond houseHoldData.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'houseHoldData.label', default: 'HouseHoldData'), houseHoldData.id])
                redirect houseHoldData
            }
            '*' { respond houseHoldData, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond houseHoldDataService.get(id)
    }

    def update(HouseHoldData houseHoldData) {
        if (houseHoldData == null) {
            notFound()
            return
        }

        try {
            houseHoldDataService.save(houseHoldData)
        } catch (ValidationException e) {
            respond houseHoldData.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'houseHoldData.label', default: 'HouseHoldData'), houseHoldData.id])
                redirect houseHoldData
            }
            '*'{ respond houseHoldData, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        houseHoldDataService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'houseHoldData.label', default: 'HouseHoldData'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'houseHoldData.label', default: 'HouseHoldData'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
