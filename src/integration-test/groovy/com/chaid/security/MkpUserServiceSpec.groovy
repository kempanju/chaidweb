package com.chaid.security

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class MkpUserServiceSpec extends Specification {

    MkpUserService mkpUserService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new MkpUser(...).save(flush: true, failOnError: true)
        //new MkpUser(...).save(flush: true, failOnError: true)
        //MkpUser mkpUser = new MkpUser(...).save(flush: true, failOnError: true)
        //new MkpUser(...).save(flush: true, failOnError: true)
        //new MkpUser(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //mkpUser.id
    }

    void "test get"() {
        setupData()

        expect:
        mkpUserService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<MkpUser> mkpUserList = mkpUserService.list(max: 2, offset: 2)

        then:
        mkpUserList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        mkpUserService.count() == 5
    }

    void "test delete"() {
        Long mkpUserId = setupData()

        expect:
        mkpUserService.count() == 5

        when:
        mkpUserService.delete(mkpUserId)
        sessionFactory.currentSession.flush()

        then:
        mkpUserService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        MkpUser mkpUser = new MkpUser()
        mkpUserService.save(mkpUser)

        then:
        mkpUser.id != null
    }
}
