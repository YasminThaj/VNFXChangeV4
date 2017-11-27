routerApp.controller('dashboardController',['$scope','$location','$http',function(scope,loc,http)
{
	scope.dashboardData='';
	/*http.get("../js/customers.php")
    .then(function (response) 
	{
		scope.names = response.data.records;
	});*/
	 http.get("http://localhost:8080/vnfdashboard")
    .then(function (response) {
		console.log(JSON.stringify(response.data));	
				var data=JSON.stringify(response.data);					
				var ojdata=JSON.parse(data);	
		scope.dashboardData = ojdata;
		//console.log(scope.dashboardData)
	}); 
	

	
	
}]);