<!DOCTYPE html>
<g:set var='securityConfig' value='${applicationContext.springSecurityService.securityConfig}'/>

<html>
<head>
	<meta name="layout" content="registration/main"/>
	<g:set var="entityName" value="${message(code: 'zlbLoanFundSrc.label', default: 'ZlbLoanFundSrc')}"/>
	<title>CHAID</title>
</head>

<body>

<div class="col-lg-6" style="padding: 0px !important;">

	<div class="center panel_div_list text-left">


		<div>

			<div class="panel-flat">

				<div class="card_header_title card-header text-center">
					<h2 class="panel-title text-bold"><g:message code="default.message.zhelb.signin" default="CHAID Sign In"/></h2>

				</div>

				<g:if test="${flash.message}">
					<div class="alert alert-warning alert-styled-left alert-arrow-left alert-bordered" style="margin-top: 5px">
						<button type="button" class="close" data-dismiss="alert"><span>&times;</span><span
								class="sr-only">Close</span></button>
						${flash.message}
					</div>
				</g:if>


				<div class="panel-body">

					<p class="text-muted" style="margin-bottom: 20px" >
						<g:message code="default.message.already.have.account" default="If you already have an account, please provide your Username and your password in the fields
                        below in order to login in into the system"/>



					</p>

					<s2ui:form type='login' focus='username' class="form-horizontal">
						<fieldset class="form">
							<g:render template="formlogins"/>
							<div class="text-right col-lg-11">
								<div id="resetPass" class="text-right" style="margin-bottom: 8px">
									<g:link controller="home" action="showResetPassword"><g:message code="default.message.forgot.password" default="Forget password?"/></g:link>
								</div>
								<button type="submit" class="btn btn-primary"><g:message code="default.message.login" default="LOGIN"/>
								</button>
							</div>
						</fieldset>
					</s2ui:form>

				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
