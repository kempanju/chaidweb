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
@Secured(['ROLE_CORE_WEB','ROLE_ADMIN'])
class FacilityController {

    FacilityService facilityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        session["activePage"] = "facility"

        params.max = Math.min(max ?: 10, 100)
        respond facilityService.list(params), model:[facilityCount: facilityService.count()]
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
                        def district = fields[3]
                        def facilityType = fields[5]
                        if(Facility.countByNumber(facilityNo)==0) {
                            if (region) {
                                regionSave = Region.findOrSaveWhere(name: region)
                                regionSave.save(flush: true)
                            }


                            if (district) {

                                findOrSaveDistrict = District.findOrSaveWhere(region_id: regionSave, name: district)
                                findOrSaveDistrict.save(flush: true)
                            }


                            /*   if(helmets){
                            helmetSave= SubStreet.findOrSaveWhere(district_id: districtInstance,village_id:villageSave,name:helmets)
                        }*/

                            if (facilityName) {

                                // String codeDictionary=
                                def dictionatyItem = DictionaryItem.findOrSaveWhere(dictionary_id: dictionary, name: facilityType, code: facilityType.toUpperCase())
                                dictionatyItem.save(flush: true)
                                facilitySave = Facility.findOrSaveWhere(number: facilityNo, name: facilityName, district_id: findOrSaveDistrict, type: dictionatyItem)
                                facilitySave.save(flush: true)


                            }
                            //
                            //  println(tempoKata + " " + tempoVillage + " " + tempoHelmets + " " + tempoFacility)
                            //    sleep(2000)
                        }
                        System.out.println(palines)
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

        params.max=20
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
