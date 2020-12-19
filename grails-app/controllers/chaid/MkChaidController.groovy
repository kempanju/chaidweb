package chaid

import admin.DictionaryItem
import com.chaid.security.MkpUser
import grails.gorm.transactions.Transactional
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*
@Secured("isAuthenticated()")
class MkChaidController {

    MkChaidService mkChaidService
    def springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        session["activePage"] = "mkchaid"
        if(!params.order) {
            params.sort = 'id'
            params.order = 'desc'
        }
        params.max = Math.min(max ?: 10, 100)
        respond mkChaidService.list(params), model:[mkChaidCount: mkChaidService.count()]
    }

    def show(Long id) {
        respond mkChaidService.get(id)
    }

    def searchChadList(){

        def searchText=params.search_string
        def searchstring="%"+searchText+"%".toLowerCase()
        //println(searchstring)

        params.max=20
        params.sort = 'id'
        params.order = 'desc'
        def chadInstanceList=MkChaid.executeQuery("from MkChaid where lower(respondent_name) like :searchstring or lower(reg_no) like :searchstring or lower(street.name) like :searchstring or lower(household.full_name) like :searchstring",[searchstring:searchstring],params)

        render(template: 'mkChaidList',model: [mkChaidList:chadInstanceList])
    }

    def memberDetailsShow(){
        println(params)
        def availableMemberInstance=AvailableMemberHouse.get(params.id)
        def categoryInstance=CategoryAvailableChildren.findByAvailableMemberHouse(availableMemberInstance)
        println(categoryInstance)
        render template:'availableMemberDetails',model: [categoryInstance:categoryInstance]
    }

    @Transactional
    def addChadStatus(){
        def userInstanceData = springSecurityService.currentUser

        def comment=params.comment
        def status_id=params.status_id

        session['defaultTabL']=1

        def chadInstance=new ChadStatus();
        chadInstance.createdBy= userInstanceData
        chadInstance.chaid=MkChaid.get(params.chaid_id)
        chadInstance.comment=comment
        chadInstance.status= DictionaryItem.get(status_id)
        chadInstance.save(failOnError:true)
        flash.message="Successfully Added!"
        redirect action: 'show',id:params.chaid_id
    }

    def create() {
        respond new MkChaid(params)
    }

    def save(MkChaid mkChaid) {
        if (mkChaid == null) {
            notFound()
            return
        }

        try {
            mkChaidService.save(mkChaid)
        } catch (ValidationException e) {
            respond mkChaid.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'mkChaid.label', default: 'MkChaid'), mkChaid.id])
                redirect mkChaid
            }
            '*' { respond mkChaid, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond mkChaidService.get(id)
    }

    def update(MkChaid mkChaid) {
        if (mkChaid == null) {
            notFound()
            return
        }

        try {
            mkChaidService.save(mkChaid)
        } catch (ValidationException e) {
            respond mkChaid.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'mkChaid.label', default: 'MkChaid'), mkChaid.id])
                redirect mkChaid
            }
            '*'{ respond mkChaid, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        mkChaidService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'mkChaid.label', default: 'MkChaid'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'mkChaid.label', default: 'MkChaid'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
