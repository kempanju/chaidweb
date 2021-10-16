package chaid

import grails.gorm.services.Service

@Service(Epidemic)
interface EpidemicService {

    Epidemic get(Serializable id)

    List<Epidemic> list(Map args)

    Long count()

    void delete(Serializable id)

    Epidemic save(Epidemic epidemic)

}