package chaid

import grails.gorm.services.Service

@Service(Adolescent)
interface AdolescentService {

    Adolescent get(Serializable id)

    List<Adolescent> list(Map args)

    Long count()

    void delete(Serializable id)

    Adolescent save(Adolescent adolescent)

}