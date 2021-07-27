package chaid

import admin.Dictionary
import admin.DictionaryItem
import admin.District
import admin.Region
import admin.Street
import admin.SubStreet
import admin.Wards
import grails.gorm.transactions.Transactional
import grails.plugin.springsecurity.annotation.Secured
import grails.util.Environment
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*
@Secured(['ROLE_CORE_WEB','ROLE_ADMIN','ROLE_REGION'])
class FacilityController {

    FacilityService facilityService
    def springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    @Secured(['ROLE_CORE_WEB','ROLE_ADMIN'])
    def index(Integer max) {
        session["activePage"] = "facility"

        params.max = Math.min(max ?: 10, 100)
        respond facilityService.list(params), model:[facilityCount: facilityService.count()]
    }
    @Secured(['ROLE_REGION'])
    def byRegion(Integer max){
        params.max = Math.min(max ?: 10, 100)
        def currentUser=springSecurityService.getCurrentUser()

        def facilityList=Facility.executeQuery("from Facility where deleted=false and district_id.region_id=:regionInstance ",[regionInstance:currentUser.region],params)
        def facilityCount=Facility.executeQuery("from Facility where deleted=false and district_id.region_id=:regionInstance ",[regionInstance:currentUser.region]).size()

        render view: 'byregion',model: [facilityList:facilityList,facilityCount:facilityCount]
    }
    def show(Long id) {
        respond facilityService.get(id)
    }
    @Transactional
    def myUploadFacility(){
        println(params)
        def palines = 0;
        int userexists = 0;
        int usernotexists = 0;


        //  println(params)

        def reqFile = request.getFile("filename_csv")

        if(reqFile) {
            def namephoto = System.currentTimeMillis() + ".csv";
            def file_path = servletContext.getRealPath("") + "csvfiles/" + namephoto


            if (Environment.current != Environment.DEVELOPMENT) {
                file_path = "/home/mkapauser/chaiddocuments/" + namephoto
            }

            File fileDest = new File(file_path)
            reqFile.transferTo(fileDest)

            final String tempoKata,tempoVillage,tempoHelmets,tempoFacility
            def findOrSaveDistrict=null
            def regionSave=null;
            def facilitySave=null;
            def dictionary= Dictionary.findOrSaveWhere(code: 'FAUCYTYPE',name: 'Facility Type')

            new File(file_path).splitEachLine(",") { fields ->
                try {
                    if (palines > 0) {
                        //sleep(500)


                        def facilityNo = fields[0]
                        def facilityName = fields[1]
                        def region = fields[2]
                        def district = fields[4]
                        def facilityType = fields[5]
                       // if(Facility.countByNumber(facilityNo)<10) {
                          /*  if (region) {
                                regionSave = Region.findOrSaveWhere(name: region)
                                regionSave.save(flush: true)
                            }


                            if (district) {

                                findOrSaveDistrict = District.findOrSaveWhere(region_id: regionSave, name: district)
                                findOrSaveDistrict.save(flush: true)
                            }



*/
                             findOrSaveDistrict=District.findByName(district)
                            /*   if(helmets){
                            helmetSave= SubStreet.findOrSaveWhere(district_id: districtInstance,village_id:villageSave,name:helmets)
                        }*/
                        System.out.println(palines+" "+district)

                            if (facilityName&&findOrSaveDistrict) {

                                // String codeDictionary=
                                if(Facility.countByNumber(facilityNo)==0) {
                                    println("created")

                                    def dictionatyItem = DictionaryItem.findOrSaveWhere(dictionary_id: dictionary, name: facilityType, code: facilityType.toUpperCase())
                                    dictionatyItem.save(flush: true)

                                    facilitySave = Facility.findOrSaveWhere(number: facilityNo, name: facilityName, district_id: findOrSaveDistrict, type: dictionatyItem)
                                    facilitySave.save(flush: true)
                                }else{
                                    println("updated")
                                    Facility.executeUpdate("update Facility set district_id=:district_id where number=:number",[district_id:findOrSaveDistrict,number:facilityNo])
                                }


                            }
                            //
                            //  println(tempoKata + " " + tempoVillage + " " + tempoHelmets + " " + tempoFacility)
                            //    sleep(2000)

                    }
                }catch(Exception e){
                    e.printStackTrace()
                }

                palines++
            }
            flash.message="Successfully updated :"+palines

        }
        redirect action: "index"
    }

    def create() {
        respond new Facility(params)
    }

    def save(Facility facility) {
        if (facility == null) {
            notFound()
            return
        }

        try {
            facilityService.save(facility)
        } catch (ValidationException e) {
            respond facility.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'facility.label', default: 'Facility'), facility.id])
                redirect facility
            }
            '*' { respond facility, [status: CREATED] }
        }
    }
    def searchFacilityList(){

        def searchText=params.search_string
        def searchstring="%"+searchText+"%".toLowerCase()
        //println(searchstring)

        params.max=150
        params.sort = 'id'
        params.order = 'desc'
        def facilityInstanceList=Facility.executeQuery("from Facility where lower(name) like :searchstring or lower(number) like :searchstring or lower(district_id.name) like :searchstring ",[searchstring:searchstring],params)

        render(template: 'facilityList',model: [facilityList:facilityInstanceList])
    }
    def edit(Long id) {
        respond facilityService.get(id)
    }

    def update(Facility facility) {
        if (facility == null) {
            notFound()
            return
        }

        try {
            facilityService.save(facility)
        } catch (ValidationException e) {
            respond facility.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'facility.label', default: 'Facility'), facility.id])
                redirect facility
            }
            '*'{ respond facility, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        facilityService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'facility.label', default: 'Facility'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'facility.label', default: 'Facility'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
