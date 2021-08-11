package chaid

import grails.gorm.services.Service

@Service(AdolescentAbuse)
interface AdolescentAbuseService {

    AdolescentAbuse get(Serializable id)

    List<AdolescentAbuse> list(Map args)

    Long count()

    void delete(Serializable id)

    AdolescentAbuse save(AdolescentAbuse adolescentAbuse)

}