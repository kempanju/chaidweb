package chaid

import admin.DictionaryItem
import com.chaid.security.MkpUser
import grails.converters.JSON
import grails.gorm.transactions.Transactional
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*
@Secured(['ROLE_CORE_WEB','ROLE_ADMIN','ROLE_REGION','ROLE_DISTRICT'])
class MkChaidController {

    MkChaidService mkChaidService
    def springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    @Secured(['ROLE_CORE_WEB','ROLE_ADMIN'])
    def index(Integer max) {
        session["activePage"] = "mkchaid"
        if(!params.order) {
            params.sort = 'id'
            params.order = 'desc'
        }
        params.max = Math.min(max ?: 10, 100)
        respond MkChaid.findAllByDeleted(false,params), model:[mkChaidCount: MkChaid.countByDeleted(false)]
    }
    @Secured(['ROLE_REGION'])
    def byRegion(Integer max){
        session["activePage"] = "mkchaid"
        if(!params.order) {
            params.sort = 'id'
            params.order = 'desc'
        }
        params.max = Math.min(max ?: 10, 100)
        def currentUser=springSecurityService.getCurrentUser()
       def activityList=chaid.MkChaid.executeQuery(" from MkChaid  where distric.region_id=:region and deleted=false",[region:currentUser.region],params)
        def activityCount=chaid.MkChaid.executeQuery(" from MkChaid  where distric.region_id=:region and deleted=false",[region:currentUser.region] ).size()

        render view: 'byregion',model:[mkChaidList:activityList,mkChaidCount:activityCount]

    }

    @Secured(['ROLE_DISTRICT'])
    def byDistrict(Integer max){
        session["activePage"] = "mkchaid"
        if(!params.order) {
            params.sort = 'id'
            params.order = 'desc'
        }
        params.max = Math.min(max ?: 10, 100)
        def currentUser=springSecurityService.getCurrentUser()
        def activityList=chaid.MkChaid.executeQuery(" from MkChaid  where distric=:district and deleted=false",[district:currentUser.district_id],params)
        def activityCount=chaid.MkChaid.executeQuery(" from MkChaid  where distric=:district and deleted=false",[district:currentUser.district_id] ).size()

        render view: 'bydistrict',model:[mkChaidList:activityList,mkChaidCount:activityCount]

    }
    @Transactional
    def deleteChad(){
        MkChaid.executeUpdate("update MkChaid set deleted=true where id=:id",[id:Integer.parseInt(params.id)])
        flash.message="Successfully removed!"
        redirect(action: 'index')
    }

    def show(Long id) {
        respond mkChaidService.get(id)
    }
    def showTest(Long id) {
        def chaidInstance=MkChaid.get(id).app_logs
        render chaidInstance
    }

    def searchChadList(){

        def searchText=params.search_string
        def searchstring="%"+searchText+"%".toLowerCase()
        //println(searchstring)

        params.max=20
        params.sort = 'id'
        params.order = 'desc'
        def chadInstanceList=MkChaid.executeQuery("from MkChaid where lower(created_by.full_name) like :searchstring or lower(respondent_name) like :searchstring or lower(reg_no) like :searchstring or lower(street.name) like :searchstring or lower(household.full_name) like :searchstring",[searchstring:searchstring],params)

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
