
routerApp.controller('logController',['$scope','$rootScope','$location',function(scope,root,loc){
	$(logout).addClass("hidden");
	$(help).addClass("hidden");
	scope.loginpag = function()
	{
		if(scope.uname =="admin" && scope.upassword == "admin") 
		{	
			root.name=scope.uname;
				root.logout = function()
				{
					console.log("outttt")
					root.name='';
					loc.path('/login');
				};
			loc.path('/dashboard');
			$(logout).removeClass("hidden");
			$(help).removeClass("hidden");
		}
		else
		{
			scope.unamesuccess=true;
		}
	};
		scope.reset = function()
		{
			scope.uname="";
			scope.upassword="";
			scope.unamesuccess=false;
		};
}]); 
