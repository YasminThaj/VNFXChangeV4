routerApp.controller('imsonboardingController',['$scope', '$sce','$http',function(scope,sce,http){

scope.onbpath='imsonbord.html';
scope.onboardFileSuccess=false;
scope.vtypeopn ='';
scope.option1='';
scope.Option2='';
var option1Options = ["vIMS","EPC"];
var option2Options = ["MCM", "CSM", "SSM"];

			   
scope.options1 = option1Options;
scope.options2 = [];

scope.onvnftypechange = function(){
       
        var key = scope.options1;
		console.log("op1------"+scope.options1)   
        var myNewOptions = option2Options[key];
        scope.options2 = myNewOptions;
    };
	
	
scope.onboardimsfile=function(){ 
    console.log("onboarding---")
	scope.searchButton ='seraching';
	
	http.get("http://localhost:8080/vnfimsonboard")
		.then(function (response) {
		console.log("executedata"+response.data);
		scope.nval=false;
		      
			scope.names = response.data;
			scope.report = response.report;
		//document.getElementById('rep').className='active';
		//document.getElementById('test').className='';
		//scope.fpath='imsreports.html';
		  });
    
		setTimeout(function () {
		        scope.$apply(function(){
			    scope.onboardFileSuccess = true;	
		        scope.osuccessmessage="Sucessfully Onboarded";
		        scope.searchButton ='stop';
				console.log("Sucessfully Onboarded")
		
		  });
     	}, 729000);
		
	} 

/*scope.onvnftypechange=function(){
	
	var key = scope.options1.indexOf(scope.option1);
	console.log("op1"+key)   
    var myNewOptions = option2Options[key];
	console.log("op2"+myNewOptions) 
    scope.options2 = myNewOptions;	
}*/

	
}]);
