package chaid

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class AdolescentServiceSpec extends Specification {

    AdolescentService adolescentService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Adolescent(...).save(flush: true, failOnError: true)
        //new Adolescent(...).save(flush: true, failOnError: true)
        //Adolescent adolescent = new Adolescent(...).save(flush: true, failOnError: true)
        //new Adolescent(...).save(flush: true, failOnError: true)
        //new Adolescent(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //adolescent.id
    }

    void "test get"() {
        setupData()

        expect:
        adolescentService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Adolescent> adolescentList = adolescentService.list(max: 2, offset: 2)

        then:
        adolescentList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        adolescentService.count() == 5
    }

    void "test delete"() {
        Long adolescentId = setupData()

        expect:
        adolescentService.count() == 5

        when:
        adolescentService.delete(adolescentId)
        sessionFactory.currentSession.flush()

        then:
        adolescentService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Adolescent adolescent = new Adolescent()
        adolescentService.save(adolescent)

        then:
        adolescent.id != null
    }
}
