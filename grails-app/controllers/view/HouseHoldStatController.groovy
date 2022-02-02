package view

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class HouseHoldStatController {

    HouseHoldStatService houseHoldStatService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond houseHoldStatService.list(params), model:[houseHoldStatCount: houseHoldStatService.count()]
    }

    def show(Long id) {
        respond houseHoldStatService.get(id)
    }

    def create() {
        respond new HouseHoldStat(params)
    }

    def save(HouseHoldStat houseHoldStat) {
        if (houseHoldStat == null) {
            notFound()
            return
        }

        try {
            houseHoldStatService.save(houseHoldStat)
        } catch (ValidationException e) {
            respond houseHoldStat.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'houseHoldStat.label', default: 'HouseHoldStat'), houseHoldStat.id])
                redirect houseHoldStat
            }
            '*' { respond houseHoldStat, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond houseHoldStatService.get(id)
    }

    def update(HouseHoldStat houseHoldStat) {
        if (houseHoldStat == null) {
            notFound()
            return
        }

        try {
            houseHoldStatService.save(houseHoldStat)
        } catch (ValidationException e) {
            respond houseHoldStat.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'houseHoldStat.label', default: 'HouseHoldStat'), houseHoldStat.id])
                redirect houseHoldStat
            }
            '*'{ respond houseHoldStat, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        houseHoldStatService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'houseHoldStat.label', default: 'HouseHoldStat'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'houseHoldStat.label', default: 'HouseHoldStat'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
