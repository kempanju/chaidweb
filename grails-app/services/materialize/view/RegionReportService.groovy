package materialize.view

import grails.gorm.services.Service

@Service(RegionReport)
interface RegionReportService {

    RegionReport get(Serializable id)

    List<RegionReport> list(Map args)

    Long count()

    void delete(Serializable id)

    RegionReport save(RegionReport regionReport)

}