routerApp.directive('customOnChange', function() {
  return {
    restrict: 'A',
    link: function (scope, element, attrs) 
	{
     var onChangeFunc = scope.$eval(attrs.customOnChange);
     element.bind('change', onChangeFunc);
    }
  };
});
routerApp.directive('customOnFilechange', function() {
  return {
    restrict: 'A',
    link: function (scope, element, attrs) 
	{
     var onChangeFunc = scope.$eval(attrs.customOnFilechange);
     element.bind('change', onChangeFunc);
    }
  };
});