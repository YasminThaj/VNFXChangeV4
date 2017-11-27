routerApp.config(function($stateProvider, $urlRouterProvider) {
    
    $urlRouterProvider.otherwise('/login');
    
    $stateProvider
        
        .state('login', {
            url: '/login',
            templateUrl: '../views/login.html',
			controller:'logController'
        })
  		.state('dashboard', {
			url:'/dashboard',
            templateUrl: '../views/dashboard.html',
			controller:'dashboardController'
        })
		.state('vnfFunc', {
			url:'/vnfFunc',
            templateUrl: '../views/vnfFunc.html',
			controller:'vnffuncController'
        })
		.state('vnfimsimageupload', {
			url:'/vnfimsimageupload',
            templateUrl: '../views/vnfimsimageupload.html',
			controller:'vnfimsimageController'
		})
		.state('vnfimsonbord', {
			url:'/vnfimsonbord',
            templateUrl: '../views/vnfimsonbord.html',
			controller:'imsonboardingController'
        })
		.state('vnfImsFunc', {
			url:'/vnfImsFunc',
            templateUrl: '../views/vnfImsFunc.html',
			controller:'vnfimsfuncController'
			
        })
		.state('vnfgonboard', {
			url:'/vnfgonboard',
            templateUrl: '../views/vnfonbrd.html',
			controller:'onbordingcontroller'
        })
		.state('vnfHelp', {
			url:'/vnfHelp',
            templateUrl: '../views/vnfHelp.html'
        })
		.state('vnfImage', {
			url:'/vnfImage',
            templateUrl: '../views/vnfImage.html',
			controller:'vnfimageController'
        })
		.state('vnfonboardInfo', {
			url:'/vnfonboardInfo',
            templateUrl: '../views/vnfonboardInfo.html',
			controller:'vnfonboardInfoController'
        })
		.state('sbcimage', {
			url:'/sbcimage',
            templateUrl: '../views/sbcimage.html',
			controller:'sbcimageController'
        })
		.state('vnfwikilink', {
			url:'/vnfwikilink',
			templateUrl: '../views/vnfwikilink.html',			
			controller:'wikilinkController'
		})
		.state('reports', {
			url:'/reports',
			templateUrl: '../views/reports.html',			
			controller:'funReportController'
		});
       
});