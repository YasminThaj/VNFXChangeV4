routerApp.controller('vnfonboardInfoController',['$scope','$location','$http',function(scope,loc,http){
	
	http.get("http://localhost:8080/vnfonboarddata") 
    .then(function (response) {
		scope.dashboardData = response.data;
		console.log("dashboardData dsdsdasdas" + scope.dashboardData.Cpus);
		scope.vnf_name = scope.dashboardData.VNFName;
		 scope.Cpus = scope.dashboardData.Cpus;
		scope.Memory = scope.dashboardData.Memory;
		scope.Status = scope.dashboardData.Status;
		scope.onboardedDate = scope.dashboardData.onboardedDate;
		scope.IpAddress = scope.dashboardData.IpAddress;  
	});  
	}]);