var app = angular.module("myApplication", ['ngRoute','ngMaterial', 'ngAnimate']);

/*app.config(['$mdDateLocaleProvider',function($mdDateLocaleProvider) {
  $mdDateLocaleProvider.formatDate = function(date) {
    return date ? moment(date).format('DD-MM-YYYY') : '';
  };

  $mdDateLocaleProvider.parseDate = function(dateString) {
    var m = moment(dateString, 'DD-MM-YYYY', true);
    return m.isValid() ? m.toDate() : new Date(NaN);
  };
]});*/



app.controller("myCtrl",["$scope","$http", function($scope,$http) {
    $scope.firstName = "John";
    $scope.lastName = "Doe";
    $scope.linkName="";

    var linkName=$scope.linkName;

      $scope.insert = {};

    //$scope.linkName = "feli";


    linkName="http://chaid.mkapafoundation.or.tz"
    //linkName="http://localhost:9090"
   // linkName="http://www.habarisasa.com:8080/chaid"

   callRegisteredMethod("");

    $scope.registeredReportByDate=function(){
        $start_date=$scope.insert.start_date;
         $end_date=$scope.insert.end_date;



         //console.log($scope.insert);
        // alert($end_date);
        // $scope.end_date="887";
        $http({
            method: "POST",
            url: linkName+"/home/registeredReportByDate",
            params: $scope.insert

        }).then(function mySuccess(response) {
                      var data=response.data;
                      $scope.report = data;
                      console.log( $scope.report);


                  }, function myError(response) {

                  });
      //  console.log($scope);
    };

    $scope.updateRegistered=function(){
      $selectedItem=$scope.insert.facility;
    callRegisteredMethod($selectedItem);
    console.log($selectedItem);

    }


    function callRegisteredMethod(facility){
     $http({
            method: "POST",
            url:linkName+ "/home/registeredReport",
            params: {facility:facility}

        }).then(function mySuccess(response) {
            var data=response.data;
            $scope.report = data;
            console.log( $scope.report);


        }, function myError(response) {

        });
    }


}]);




app.controller("reached",["$scope","$http", function($scope,$http) {
    $scope.firstName = "John";
    $scope.lastName = "Doe";
    $scope.linkName="";
    $scope.start_date="";
    $scope.end_date="";
    var linkName=$scope.linkName;
    //$scope.linkName = "feli";

   linkName="http://chaid.mkapafoundation.or.tz"
    //linkName="http://localhost:9090"
    //linkName="http://www.habarisasa.com:8080/chaid"

callRegisteredMethod("");


    $scope.registeredReportByDate=function(){
        $start_date=$scope.start_date;
         $end_date=$scope.end_date;
         //alert($scope);
        // $scope.end_date="887";
        $http({
            method: "POST",
            url: linkName+"/home/reachedReportByDate",
            params: $scope.insert

        }).then(function mySuccess(response) {
                      var data=response.data;
                      $scope.report = data;
                      console.log( $scope.report);


                  }, function myError(response) {

                  });
        console.log($scope);
    };

    $scope.updateRegistered=function(){
      $selectedItem=$scope.insert.facility;
    callRegisteredMethod($selectedItem);
    console.log($scope);

    }


    function callRegisteredMethod(facility){
     $http({
            method: "POST",
            url:linkName+ "/home/reachedReport",
            params: {facility:facility}

        }).then(function mySuccess(response) {
            var data=response.data;
            $scope.report = data;
            console.log( $scope.report);


        }, function myError(response) {

        });
    }


}]);


app.controller("referrals",["$scope","$http", function($scope,$http) {

    $scope.fname="Felix";
console.log("called");
$scope.referral = {};
$scope.referral.end_date="";

$scope.referral.start_date="";

  var linkName=$scope.linkName;
    //$scope.linkName = "feli";

    linkName="http://chaid.mkapafoundation.or.tz"
    //linkName="http://localhost:9090"
callHttpMethod("");


$scope.registeredReportByDate=function(){
        $start_date=$scope.start_date;
         $end_date=$scope.end_date;
         //alert($scope);
        // $scope.end_date="887";
        $http({
            method: "POST",
            url: linkName+"/home/referralsReportByDate",
            params: $scope.insert

        }).then(function mySuccess(response) {
                      var data=response.data;
                      $scope.report = data;
                      console.log( $scope.report);


                  }, function myError(response) {

                  });
        console.log($scope);
    };


$scope.updateReferrals=function(){
  $selectedItem=$scope.insert.facility;
callHttpMethod($selectedItem);
console.log($scope);
 console.log("called:"+$selectedItem+" "+$start_date+" "+$end_date);

}


function callHttpMethod(facility){

   // linkName="http://www.habarisasa.com:8080/chaid"

    $http({
        method: "POST",
        url:linkName+ "/home/reportByReferralsGeneratedJSON",
         params: {facility: facility, draft: true}

    }).then(function mySuccess(response) {
        var data=response.data;
        $scope.report = data;
        console.log($scope.report);


    }, function myError(response) {

    });
}

}]);

