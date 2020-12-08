<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>
        <g:layoutTitle default="Grails"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>

    <asset:stylesheet href="https://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700,900"/>
    <asset:stylesheet src="icons/icomoon/styles.css"/>

    <asset:stylesheet src="application.css"/>
    <asset:stylesheet src="bootstrap.css"/>
    <asset:stylesheet src="darkbox.css"/>
    <asset:stylesheet src="core.css"/>
    <asset:stylesheet src="general.css"/>
    <asset:stylesheet src="components.css"/>
    <asset:stylesheet src="colors.css"/>
    <asset:stylesheet src="jquery-ui.css"/>
    <asset:stylesheet src="bootstrap-datetimepicker.min.css"/>
    <asset:stylesheet src="zcustom.css"/>



    <asset:javascript src="plugins/loaders/pace.min.js"/>

    <asset:javascript src="core/libraries/jquery.min.js"/>

    <asset:javascript src="jquery-ui/jquery-ui.js"/>
    <asset:javascript src="core/libraries/bootstrap.min.js"/>
    <asset:javascript src="plugins/loaders/blockui.min.js"/>

    <asset:javascript src="plugins/ui/moment/moment.min.js"/>

    <asset:javascript src="plugins/uploaders/fileinput.min.js"/>

    <asset:javascript src="core/app.js"/>

    <asset:javascript src="core/libraries/jquery_ui/interactions.min.js"/>


    <asset:javascript src="forms/styling/uniform.min.js"/>

    <asset:javascript src="jquery.elevatezoom.js"/>
    <asset:javascript src="darkbox.js"/>
    <asset:javascript src="bootstrap-datetimepicker.min.js"/>

    <asset:javascript src="pages/uploader_bootstrap.js"/>

    <script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.6.3/js/bootstrap-select.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" />

    <g:layoutHead/>
</head>

<body class="navbar-bottom">
<div class="container">
    <div class="row justify-content-center general_registration">
        <g:render template="/layouts/registration/header"/>
%{--
            <g:render template="/layouts/registration/sidemenu"/>
--}%

            <!-- Page container -->
            <div style="min-height: 300px;margin-top: 40px">
                <div class="page-content page-container col-lg-12 text-center">
                        <div class="col-lg-3"></div>
                        <g:layoutBody/>
                </div>
            </div>

        <g:set var="today" value="${Calendar.getInstance().get(Calendar.YEAR)}"/>

        %{--<div class="col-lg-12 text-center text-dark panel-body">
            ${today} © ZHELB
        </div>--}%

    </div>
</div>
%{--
<g:render template="/layouts/footer"/>
--}%

%{--
    <asset:javascript src="application.js"/>
--}%

</body>
</html>
