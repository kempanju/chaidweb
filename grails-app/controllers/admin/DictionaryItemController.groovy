package admin

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*
import grails.plugin.springsecurity.annotation.Secured
@Secured(['ROLE_CORE_WEB','ROLE_ADMIN'])
class DictionaryItemController {

    DictionaryItemService dictionaryItemService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        session["activePage"] = "dictionaryitem"

        params.max = Math.min(max ?: 10, 100)
        respond dictionaryItemService.list(params), model:[dictionaryItemCount: dictionaryItemService.count()]
    }

    def searchDictionaryList(){
        def searchText=params.search_string
        String searchstring="%"+searchText+"%"
       // searchstring=searchstring.toLowerCase()
        //println(searchstring)
        def dictionaryInstanceList= DictionaryItem.executeQuery("from DictionaryItem where  lower(name) like lower(:searchstring) or lower(name_en) like lower(:searchstring) or code like :searchstring or dictionary_id.name like :searchstring ",[searchstring:searchstring],params)

        render(template: 'dictionaryItem',model: [dictionaryItemList:dictionaryInstanceList])

    }

    def show(Long id) {
        respond dictionaryItemService.get(id)
    }

    def create() {
        session["activePage"] = "dictionaryitem"

        respond new DictionaryItem(params)
    }

    def save(DictionaryItem dictionaryItem) {
        if (dictionaryItem == null) {
            notFound()
            return
        }

        try {
            dictionaryItemService.save(dictionaryItem)
        } catch (ValidationException e) {
            respond dictionaryItem.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'dictionaryItem.label', default: 'DictionaryItem'), dictionaryItem.id])
                redirect dictionaryItem
            }
            '*' { respond dictionaryItem, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond dictionaryItemService.get(id)
    }

    def update(DictionaryItem dictionaryItem) {
        if (dictionaryItem == null) {
            notFound()
            return
        }

        try {
            dictionaryItemService.save(dictionaryItem)
        } catch (ValidationException e) {
            respond dictionaryItem.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'dictionaryItem.label', default: 'DictionaryItem'), dictionaryItem.id])
                redirect dictionaryItem
            }
            '*'{ respond dictionaryItem, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        dictionaryItemService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'dictionaryItem.label', default: 'DictionaryItem'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'dictionaryItem.label', default: 'DictionaryItem'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
