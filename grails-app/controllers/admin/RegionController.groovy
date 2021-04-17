package admin

import chaid.Facility
import grails.gorm.transactions.Transactional
import grails.plugin.springsecurity.annotation.Secured
import grails.util.Environment
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*
@Secured(['ROLE_CORE_WEB','ROLE_ADMIN'])
class RegionController {

    RegionService regionService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        session["activePage"] = "location"

        params.max = Math.min(max ?: 10, 100)
        respond regionService.list(params), model:[regionCount: regionService.count()]
    }

    def show(Long id) {
        respond regionService.get(id)
    }

    def create() {
        respond new Region(params)
    }

    def save(Region region) {
        if (region == null) {
            notFound()
            return
        }

        try {
            regionService.save(region)
        } catch (ValidationException e) {
            respond region.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'region.label', default: 'Region'), region.id])
                redirect region
            }
            '*' { respond region, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond regionService.get(id)
    }

    def update(Region region) {
        if (region == null) {
            notFound()
            return
        }

        try {
            regionService.save(region)
        } catch (ValidationException e) {
            respond region.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'region.label', default: 'Region'), region.id])
                redirect region
            }
            '*'{ respond region, [status: OK] }
        }
    }


    @Transactional
    def uploadCVRegion(){
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

            sleep(1000)
            final String tempoKata,tempoVillage,tempoHelmets,tempoDistrict
            def findOrSaveWards=null
            def villageSave=null;
            def helmetSave=null;
            def districtSave=null;
            new File(file_path).splitEachLine(",") { fields ->

                try {
                    if (palines > 1) {
                        //sleep(500)



                        def kata = fields[3]
                        def village = fields[5]
                        def helmets = fields[7]
                        def district = fields[1]



                        if (kata) {
                            tempoKata = kata
                        }
                        if (village) {
                            tempoVillage = village
                        }

                        if (helmets) {
                            tempoHelmets = helmets
                        }
                        if (district) {
                            tempoDistrict = district
                        }

                      //  println(tempoDistrict+" "+tempoKata+" "+tempoVillage+" "+tempoHelmets)
                        def districtInstance = District.findByName(tempoDistrict)

                     //   def uniquename = districtInstance.id + "/" + tempoKata
                        if(districtInstance) {
                            if (kata) {
                                // println(districtInstance.name + " " + tempoKata)


                                findOrSaveWards = Wards.findOrSaveWhere(district_id: districtInstance, name: kata)
                                findOrSaveWards.save(flush: true)
                            }
                            if (village) {
                                villageSave = Street.findOrSaveWhere(district_id: districtInstance, name: village, ward_id: findOrSaveWards)
                                villageSave.save(flush: true)
                            }

                            if (helmets) {
                                try {
                                    helmetSave = SubStreet.findOrSaveWhere(district_id: districtInstance, village_id: villageSave, name: helmets.trim())
                                    helmetSave.save(flush: true)
                                }catch(Exception e){
                                    e.printStackTrace()
                                }
                            }

                            /* if(tempoDistrict){
                            facilitySave= Facility.findOrSaveWhere(name:facility,village_id:villageSave,district_id:districtInstance)
                        }*/
                            //
                            //  println(tempoKata + " " + tempoVillage + " " + tempoHelmets + " " + tempoFacility)
                        println(palines)
                        }
                    }
                }catch(Exception e){
                e.printStackTrace()
                }

                palines++
            }

        }
        redirect action: "index"

    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        regionService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'region.label', default: 'Region'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'region.label', default: 'Region'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
