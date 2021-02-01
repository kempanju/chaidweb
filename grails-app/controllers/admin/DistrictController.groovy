package admin

import chaid.Facility
import grails.gorm.transactions.Transactional
import grails.plugin.springsecurity.annotation.Secured
import grails.util.Environment
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*
@Secured(['ROLE_CORE_WEB','ROLE_ADMIN'])
class DistrictController {

    DistrictService districtService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        session["activePage"] = "location"

        params.max = Math.min(max ?: 10, 100)
        respond districtService.list(params), model:[districtCount: districtService.count()]
    }

    def show(Long id) {
        respond districtService.get(id)
    }

    def create() {
        respond new District(params)
    }

    def save(District district) {
        if (district == null) {
            notFound()
            return
        }

        try {
            districtService.save(district)
        } catch (ValidationException e) {
            respond district.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'district.label', default: 'District'), district.id])
                redirect district
            }
            '*' { respond district, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond districtService.get(id)
    }
    @Transactional
    def uploadCVDistrict(){
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
                file_path = "/home/felijose/" + namephoto
            }

            File fileDest = new File(file_path)
            reqFile.transferTo(fileDest)

            sleep(1000)
           final String tempoKata,tempoVillage,tempoHelmets,tempoFacility
            def findOrSaveWards=null
            def villageSave=null;
            def helmetSave=null;
            def facilitySave=null;
            new File(file_path).splitEachLine(",") { fields ->
                try {
                    if (palines > 1) {
                        //sleep(500)


                        def kata = fields[2]
                        def village = fields[4]
                        def helmets = fields[6]
                        def facility = fields[8]

                        if (kata) {
                            tempoKata = kata
                        }
                        if (village) {
                            tempoVillage = village
                        }

                        if (helmets) {
                            tempoHelmets = helmets
                        }
                        if (facility) {
                            tempoFacility = facility
                        }
                        def districtInstance = District.get(params.district_id)

                        def uniquename = districtInstance.id + "/" + tempoKata

                        if (kata) {
                            println(districtInstance.name + " " + tempoKata)


                            findOrSaveWards = Wards.findOrSaveWhere(district_id: districtInstance, name: kata)

                        }
                        if (village) {
                            villageSave = Street.findOrSaveWhere(district_id: districtInstance, name: village, ward_id: findOrSaveWards)
                        }

                        if(helmets){
                            helmetSave=SubStreet.findOrSaveWhere(district_id: districtInstance,village_id:villageSave,name:helmets)
                        }

                        if(facility){
                            facilitySave= Facility.findOrSaveWhere(name:facility,village_id:villageSave,district_id:districtInstance)
                        }
                        //
                        println(tempoKata + " " + tempoVillage + " " + tempoHelmets + " " + tempoFacility)


                    }
                }catch(Exception e){

                }

                palines++
            }

        }
        redirect action: "show",id:params.district_id

    }

    def update(District district) {
        if (district == null) {
            notFound()
            return
        }

        try {
            districtService.save(district)
        } catch (ValidationException e) {
            respond district.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'district.label', default: 'District'), district.id])
                redirect district
            }
            '*'{ respond district, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        districtService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'district.label', default: 'District'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'district.label', default: 'District'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
