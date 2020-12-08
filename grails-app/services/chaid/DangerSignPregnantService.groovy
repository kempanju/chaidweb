package chaid

import grails.gorm.services.Service

@Service(DangerSignPregnant)
interface DangerSignPregnantService {

    DangerSignPregnant get(Serializable id)

    List<DangerSignPregnant> list(Map args)

    Long count()

    void delete(Serializable id)

    DangerSignPregnant save(DangerSignPregnant dangerSignPregnant)

}