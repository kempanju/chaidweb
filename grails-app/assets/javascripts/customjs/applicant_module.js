var app = angular.module("myApplication", []);



app.controller("myCtrl",["$scope","$http", function($scope,$http) {
    $scope.firstName = "John";
    $scope.lastName = "Doe";
    $scope.linkName="";
    $scope.start_date="";
    $scope.end_date="";
    var linkName=$scope.linkName;
    //$scope.linkName = "feli";

    linkName="http://www.habarisasa.com:8080/chaid"

    $http({
        method: "POST",
        url:linkName+ "/home/registeredReport"

    }).then(function mySuccess(response) {
        var data=response.data;
        $scope.report = data;
        console.log( $scope.report);


    }, function myError(response) {

    });


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

    $scope.applicationTypeFunc=function () {
        $applicationType=$scope.applicationType;

        $http({
            method: "POST",
            url: linkName+"/applicant/applicationsTypesList",
            params: {application_type: $applicationType}

        }).then(function mySuccess(response) {
            console.log(response.data);
            var data=response.data;

            $scope.fundList = data.fundList;
            $scope.applied=data.applied;

        }, function myError(response) {
            $scope.fundList = response.statusText;
        });


    };
}]);

app.controller("referrals",["$scope","$http", function($scope,$http) {
    $scope.fname="Felix";
console.log("called");

$scope.linkName="";

    var linkName=$scope.linkName;
    //$scope.linkName = "feli";

    $http({
        method: "POST",
        url:linkName+ "/home/reportByReferralsGeneratedJSON"

    }).then(function mySuccess(response) {
        var data=response.data;
        $scope.report = data;
        console.log( $scope.report);


    }, function myError(response) {

    });



}]);

