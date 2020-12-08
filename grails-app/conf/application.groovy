

// Added by the Spring Security Core plugin:
grails.plugin.springsecurity.userLookup.userDomainClassName = 'com.chaid.security.MkpUser'
grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'com.chaid.security.MkpUserMkpRole'
grails.plugin.springsecurity.authority.className = 'com.chaid.security.MkpRole'

grails.plugin.springsecurity.rest.token.validation.headerName = 'X-Auth-Token'
grails.plugins.cookie.cookieage.default = 864000
grails.plugin.springsecurity.rest.token.storage.jwt.expiration=3600000
grails.databinding.dateFormats = ['yyyy-mm-dd']

grails.plugin.springsecurity.logout.postOnly = false

grails.plugin.springsecurity.controllerAnnotations.staticRules = [
	[pattern: '/',               access: ['permitAll']],
	[pattern: '/error',          access: ['permitAll']],
	[pattern: '/index',          access: ['permitAll']],
	[pattern: '/index.gsp',      access: ['permitAll']],
	[pattern: '/shutdown',       access: ['permitAll']],
	[pattern: '/assets/**',      access: ['permitAll']],
	[pattern: '/**/js/**',       access: ['permitAll']],
	[pattern: '/**/css/**',      access: ['permitAll']],
	[pattern: '/**/images/**',   access: ['permitAll']],
	[pattern: '/**/favicon.ico', access: ['permitAll']],
	[pattern: '/api/login', access: ['permitAll']],
	[pattern: '/login/auth', access: ['permitAll']],
]

grails.plugin.springsecurity.filterChain.chainMap = [
	[pattern: '/assets/**',      filters: 'none'],
	[pattern: '/**/js/**',       filters: 'none'],
	[pattern: '/**/css/**',      filters: 'none'],
	[pattern: '/**/images/**',   filters: 'none'],
	[pattern: '/**/favicon.ico', filters: 'none'],
	//Stateless chain
	[
			pattern: '/api/**',
			filters: 'JOINED_FILTERS,-anonymousAuthenticationFilter,-exceptionTranslationFilter,-authenticationProcessingFilter,-securityContextPersistenceFilter,-rememberMeAuthenticationFilter'
	],

	//Traditional chain
	[
			pattern: '/**',
			filters: 'JOINED_FILTERS,-restTokenValidationFilter,-restExceptionTranslationFilter'
	]
]

