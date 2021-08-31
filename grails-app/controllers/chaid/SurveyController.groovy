package chaid

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class SurveyController {

    SurveyService surveyService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond surveyService.list(params), model:[surveyCount: surveyService.count()]
    }

    def show(Long id) {
        respond surveyService.get(id)
    }

    def create() {
        respond new Survey(params)
    }

    def save(Survey survey) {
        if (survey == null) {
            notFound()
            return
        }

        try {
            surveyService.save(survey)
        } catch (ValidationException e) {
            respond survey.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'survey.label', default: 'Survey'), survey.id])
                redirect survey
            }
            '*' { respond survey, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond surveyService.get(id)
    }

    def update(Survey survey) {
        if (survey == null) {
            notFound()
            return
        }

        try {
            surveyService.save(survey)
        } catch (ValidationException e) {
            respond survey.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'survey.label', default: 'Survey'), survey.id])
                redirect survey
            }
            '*'{ respond survey, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        surveyService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'survey.label', default: 'Survey'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'survey.label', default: 'Survey'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
