<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'subStreet.label', default: 'SubStreet')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
     <div class="register_dv expert">
            <div class="center  panel-body">
        <a href="#create-subStreet" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="create-subStreet" class="content scaffold-create" role="main">
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.subStreet}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.subStreet}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
            </g:hasErrors>
            <g:form resource="${this.subStreet}" method="POST" class="form-horizontal">


                 <fieldset class="form">
                                                   <g:render template="form" bean="subStreet"/>
                                                   <div class="text-right col-lg-10">
                                                       <button type="submit" class="btn btn-primary">Save <i
                                                               class="icon-arrow-right14 position-right"></i>
                                                       </button>

                                                   </div>
                                               </fieldset>


            </g:form>
            </div>
            </div>
        </div>
    </body>
</html>
