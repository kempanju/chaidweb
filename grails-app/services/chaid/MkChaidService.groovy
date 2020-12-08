package chaid

import grails.gorm.services.Service

@Service(MkChaid)
interface MkChaidService {

    MkChaid get(Serializable id)

    List<MkChaid> list(Map args)

    Long count()

    void delete(Serializable id)

    MkChaid save(MkChaid mkChaid)

}