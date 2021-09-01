package materialize.view

import grails.gorm.services.Service

@Service(DistrictReport)
interface DistrictReportService {

    DistrictReport get(Serializable id)

    List<DistrictReport> list(Map args)

    Long count()

    void delete(Serializable id)

    DistrictReport save(DistrictReport districtReport)

}