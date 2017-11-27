routerApp.controller('wikilinkController',['$scope','$window',function(scope,window)
{
	/* alert("hello");
             window.location.href = 'http://10.53.172.10/dokuwiki/doku.php?id=start';
     */
	
window.open(
  'http://10.53.172.10:82/dokuwiki/doku.php?id=start',
  '_blank' // <- This is what makes it open in a new window.
 );
 console.log("openingg")	
	
}]);