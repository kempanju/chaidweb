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
   <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.js"></script>
       <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular-route.js"></script>

    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular-sanitize.min.js"></script>
 <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular-animate.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular-aria.js"></script>
      <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular-messages.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-material/1.2.2/angular-material.min.js"></script>
    <script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/t-114/assets-cache.js"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/angular-material/1.2.2/angular-material.css">

    <link rel = "stylesheet"
          type = "text/css" href="https://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700,900"/>
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
    <asset:javascript src="jquery-ui/jquery-ui.js"/>

    <asset:javascript src="bootstrap-datetimepicker.min.js"/>


    <g:layoutHead/>
    <script>
    function getVillages(idsData){
    var ids = idsData.value;


                $.ajax({
                    url: '${grailsApplication.config.systemLink.toString()}/home/search_village_list',
                    data: {'id': ids}, // change this to send js object
                    type: "post",
                    success: function (data) {
                   // alert("Done");
                        //document.write(data); just do not use document.write
                        $("#list-village").html(data);
                        //console.log(data);
                    }
                });



                  $.ajax({
                                    url: '${grailsApplication.config.systemLink.toString()}/home/searchFacilityByDistrict',
                                    data: {'id': ids}, // change this to send js object
                                    type: "post",
                                    success: function (data) {
                                   // alert("Done");
                                        //document.write(data); just do not use document.write
                                        $("#list-facility").html(data);
                                        //console.log(data);
                                    }
                                });


    }


    function getVillageReports(idsData){
        var ids = idsData.value;


                    $.ajax({
                        url: '${grailsApplication.config.systemLink.toString()}/home/searchVillageReport',
                        data: {'id': ids}, // change this to send js object
                        type: "post",
                        success: function (data) {
                       // alert("Done");
                            //document.write(data); just do not use document.write
                            $("#village-report").html(data);
                            //console.log(data);
                        }
                    });


        }




    function getWards(idsData){
    var ids = idsData.value;


                    $.ajax({
                        url: '${grailsApplication.config.systemLink.toString()}/home/search_ward_list',
                        data: {'id': ids}, // change this to send js object
                        type: "post",
                        success: function (data) {
                       // alert("Done");
                            //document.write(data); just do not use document.write
                            $("#list-ward").html(data);
                            //console.log(data);
                        }
                    });


    }
    </script>
</head>

<body class="navbar-bottom">
<div class="container">

    <div class="row justify-content-center general_registration">

        <g:render template="/layouts/registration/header"/>

        <div class="page-container" style="padding: 0 !important;background-color: white" >
            <div class="page-content" style="background: white">
                <g:render template="/layouts/sidemenu"/>

                <!-- Page container -->
                <div class="content-wrapper">

                <g:layoutBody/>
                </div>
            </div>

        </div>
    </div>
</div>


<asset:javascript src="core/libraries/bootstrap.min.js"/>
<asset:javascript src="plugins/loaders/blockui.min.js"/>
<asset:javascript src="plugins/ui/moment/moment.min.js"/>
<asset:javascript src="plugins/uploaders/fileinput.min.js"/>
<asset:javascript src="core/app.js"/>
<asset:javascript src="core/libraries/jquery_ui/interactions.min.js"/>
<asset:javascript src="jquery.elevatezoom.js"/>
<asset:javascript src="darkbox.js"/>
<asset:javascript src="bootstrap-datetimepicker.min.js"/>
<asset:javascript src="pages/uploader_bootstrap.js"/>
<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.18/js/bootstrap-select.min.js"></script>

    <asset:javascript src="customjs/applicant_module.js"/>

<script>
    $(document).ready(function () {
        $("#modal_form_vertical").modal('show');
    });
    $("#modal_form_vertical").modal({
        backdrop: 'static',
        keyboard: false
    });

    /*$(window).on('load',function(){
        $('#modal_form_vertical').modal('show');
    });*/
</script>
<script>
    $(document).ready(function(){
        $(".buton").click(function(e) {
            //alert(this.id);
            var id=(this.id);
            $.ajax({
                url: "${g.createLink(controller:'applicant',action:'get_path')}",
                type:'POST',
                data:{id:id},

                success:function(data){
                    $('#frame').html(data);
                }
            });
            $("#modal_full").modal('show');
            e.preventDefault();

        });

    });
</script>
</body>
</html>
