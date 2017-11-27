routerApp.controller('funReportController',['$scope','$location','$http',function(scope,loc,http)
{
	scope.reportData='';
	/*http.get("../js/customers.php")
    .then(function (response) 
	{
		scope.names = response.data.records;
	});*/
	 http.get("http://localhost:8080/funexereport")
    .then(function (response) {
		console.log(JSON.stringify(response.data));	
				var data=JSON.stringify(response.data);					
				var ojdata=JSON.parse(data);	
		scope.reportData = ojdata;
		console.log("dddataa"+scope.reportData)
		
	}); 
	

	
	
}]);