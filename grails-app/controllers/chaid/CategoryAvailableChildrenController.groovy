package chaid

import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*
@Secured(['ROLE_CORE_WEB','ROLE_ADMIN'])
class CategoryAvailableChildrenController {

    CategoryAvailableChildrenService categoryAvailableChildrenService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond categoryAvailableChildrenService.list(params), model:[categoryAvailableChildrenCount: categoryAvailableChildrenService.count()]
    }

    def show(Long id) {
        respond categoryAvailableChildrenService.get(id)
    }

    def create() {
        respond new CategoryAvailableChildren(params)
    }

    def save(CategoryAvailableChildren categoryAvailableChildren) {
        if (categoryAvailableChildren == null) {
            notFound()
            return
        }

        try {
            categoryAvailableChildrenService.save(categoryAvailableChildren)
        } catch (ValidationException e) {
            respond categoryAvailableChildren.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'categoryAvailableChildren.label', default: 'CategoryAvailableChildren'), categoryAvailableChildren.id])
                redirect categoryAvailableChildren
            }
            '*' { respond categoryAvailableChildren, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond categoryAvailableChildrenService.get(id)
    }

    def update(CategoryAvailableChildren categoryAvailableChildren) {
        if (categoryAvailableChildren == null) {
            notFound()
            return
        }

        try {
            categoryAvailableChildrenService.save(categoryAvailableChildren)
        } catch (ValidationException e) {
            respond categoryAvailableChildren.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'categoryAvailableChildren.label', default: 'CategoryAvailableChildren'), categoryAvailableChildren.id])
                redirect categoryAvailableChildren
            }
            '*'{ respond categoryAvailableChildren, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        categoryAvailableChildrenService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'categoryAvailableChildren.label', default: 'CategoryAvailableChildren'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'categoryAvailableChildren.label', default: 'CategoryAvailableChildren'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
