package chaid

import grails.gorm.services.Service

@Service(ReferalAdolescent)
interface ReferalAdolescentService {

    ReferalAdolescent get(Serializable id)

    List<ReferalAdolescent> list(Map args)

    Long count()

    void delete(Serializable id)

    ReferalAdolescent save(ReferalAdolescent referalAdolescent)

}