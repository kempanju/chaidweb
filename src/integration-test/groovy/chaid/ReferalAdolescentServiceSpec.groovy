package chaid

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class ReferalAdolescentServiceSpec extends Specification {

    ReferalAdolescentService referalAdolescentService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new ReferalAdolescent(...).save(flush: true, failOnError: true)
        //new ReferalAdolescent(...).save(flush: true, failOnError: true)
        //ReferalAdolescent referalAdolescent = new ReferalAdolescent(...).save(flush: true, failOnError: true)
        //new ReferalAdolescent(...).save(flush: true, failOnError: true)
        //new ReferalAdolescent(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //referalAdolescent.id
    }

    void "test get"() {
        setupData()

        expect:
        referalAdolescentService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<ReferalAdolescent> referalAdolescentList = referalAdolescentService.list(max: 2, offset: 2)

        then:
        referalAdolescentList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        referalAdolescentService.count() == 5
    }

    void "test delete"() {
        Long referalAdolescentId = setupData()

        expect:
        referalAdolescentService.count() == 5

        when:
        referalAdolescentService.delete(referalAdolescentId)
        sessionFactory.currentSession.flush()

        then:
        referalAdolescentService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        ReferalAdolescent referalAdolescent = new ReferalAdolescent()
        referalAdolescentService.save(referalAdolescent)

        then:
        referalAdolescent.id != null
    }
}
