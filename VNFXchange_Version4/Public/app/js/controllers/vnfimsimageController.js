routerApp.controller('vnfimsimageController',['$scope','$location','$http',function(scope,loc,http){

    scope.ipath ='imsupload.html'; 
	scope.showtable=false;
scope.uploadedFileSuccess = false;	
	 
	 
	 
scope.finalimssubmit=function(){ 
    console.log("upolading---")
	scope.searchButtonText ='Searching';
	
	http.get("http://localhost:8080/vnfimsimgupload")
		.then(function (response) {
		console.log("executedata"+response.data);
		scope.nval=false;
				
			scope.names = response.data;
			scope.report = response.report;
			
		//document.getElementById('rep').className='active';
		//document.getElementById('test').className='active';
		//scope.fpath='imsreports.html';
		 
		
		});
		setTimeout(function () {
			 scope.$apply(function(){
		scope.uploadedFileSuccess = true;	
		scope.successmessage="Image Sucessfully Uploaded";
		scope.searchButtonText ='stop';
		console.log("Image Sucessfully Uploaded")
			 });
		}, 66000);
		
	} 
}]);