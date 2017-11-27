routerApp.controller('vnfimsfuncController',['$scope','$location','$http',function(scope,loc,http){

scope.fpath ='Imstestcase.html';
scope.nval=true;
scope.imsexdate='';

	scope.gotofun12=function(fpath){
	scope.nval=true;
	scope.isDisabled = false;
		scope.fpath=fpath;

		
	}
	scope.isDisabled = false;

    scope.gotoexecutebtn=function(){
	    console.log("gotoexecute");
		scope.isDisabled = true;
		scope.searchButtonText="Searching";
		//document.getElementById('tstbutn').value="Executing";
		//document.getElementById('tstbutn').style.margin="-7px 0 0 0";
		var today = new Date();
	    var dd = today.getDate();
	    var mm = today.getMonth()+1;
	    var yyyy = today.getFullYear();
	    if(dd<10){
        dd='0'+dd;
	    } 
	    if(mm<10){
		mm='0'+mm;
	    } 
	    var today = dd+'/'+mm+'/'+yyyy;
		console.log("eedate"+today);
		scope.imsexdate=today;
		console.log("eedate"+scope.imsexdate);
		
		http.get("http://localhost:8080/vnfimsexecute")
		.then(function (response) {
		console.log("executedata"+response.data);
		scope.nval=false;
			scope.names = response.data;
			scope.report = response.report;
		});
		setTimeout(function () {
					console.log("timeeee")
		  scope.$apply(function(){
		  scope.searchButtonText="false";
		scope.fpath='imsreports.html';
		  });
		}, 121800);
	
}

scope.ontestimsChange=function(){
	scope.showimscheckbox=true;
}
}]);