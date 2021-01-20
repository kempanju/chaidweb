var app = angular.module("myApplication", []);



app.controller("myCtrl",["$scope","$http", function($scope,$http) {
    $scope.firstName = "John";
    $scope.lastName = "Doe";
    $scope.linkName="";
    $scope.start_date="";
    $scope.end_date="";
    var linkName=$scope.linkName;
    //$scope.linkName = "feli";

   // linkName="http://3.138.177.11:8080/chaid"
    //linkName="http://localhost:8080"
    linkName="http://www.habarisasa.com:8080/chaid"

callRegisteredMethod("");


    $scope.registeredReportByDate=function(){
        $start_date=$scope.start_date;
         $end_date=$scope.end_date;
         alert($scope);
        // $scope.end_date="887";
        $http({
            method: "POST",
            url: linkName+"/home/registeredReportByDate",
            params: {start_date: $start_date}

        })
        console.log($scope);
    };

    $scope.updateRegistered=function(){
      $selectedItem=$scope.selectedItem;
    callRegisteredMethod($selectedItem);
    console.log($scope);

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

   // linkName="http://3.138.177.11:8080/chaid"
    //linkName="http://localhost:8080"
    linkName="http://www.habarisasa.com:8080/chaid"

callRegisteredMethod("");


    $scope.registeredReportByDate=function(){
        $start_date=$scope.start_date;
         $end_date=$scope.end_date;
         alert($scope);
        // $scope.end_date="887";
        $http({
            method: "POST",
            url: linkName+"/home/registeredReportByDate",
            params: {start_date: $start_date}

        })
        console.log($scope);
    };

    $scope.updateRegistered=function(){
      $selectedItem=$scope.selectedItem;
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

$scope.linkName="";
callHttpMethod("");

     $end_date=$scope.referral.end_date;
      $start_date=$scope.referral.start_date;

$scope.updateReferrals=function(){
  $selectedItem=$scope.selectedItem;
callHttpMethod($selectedItem);
console.log($scope);
 console.log("called:"+$selectedItem+" "+$start_date+" "+$end_date);

}


function callHttpMethod(facility){
 var linkName=$scope.linkName;
    //$scope.linkName = "feli";
   // linkName="http://3.138.177.11:8080/chaid"
   // linkName="http://localhost:8080"
    linkName="http://www.habarisasa.com:8080/chaid"

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

