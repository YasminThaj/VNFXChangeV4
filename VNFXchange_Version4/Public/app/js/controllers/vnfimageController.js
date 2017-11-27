routerApp.controller('vnfimageController',['$scope','$location','$http',function(scope,loc,http){

	 scope.ipath ='upload.html'; 
	 scope.showtable=false;
	
	scope.imagename='';
	scope.filename=''; 
	scope.servertype='';
	scope.Imagetype='';
	scope.Contype='';
	scope.vnftypeid='';
	
scope.servertypeChange=function(servertype){
	
	scope.servertype=servertype;
	console.log("servertype "+scope.servertype)
}
scope.imgtypeChange=function(Imagetype){
	
	scope.Imagetype=Imagetype;
	console.log("imgtype "+scope.Imagetype)
}
scope.containertypeChange=function(Containtype){
	
	scope.Containtype=Containtype;
	console.log("contype "+scope.Containtype)
}

 scope.uploadImage = function(){ 

scope.imagename = event.target.files[0].name;
		
}
scope.uploadfile=function(){
	
	
	scope.filename = event.target.files[0].name;
}

scope.cancel=function(){
	
	
	
}
scope.finalsubmit=function(ovnfName){
	//var blob = new Blob(["Server=scope.servertype"], { type: 'text/javascript' });
	//saveAs(blob, "ImageUpload.txt");
	var imgnm=scope.imagename;
	var filename=scope.filename;
	var servern=scope.servertype;
	var imGtype=scope.Imagetype;
	var container=scope.Containtype;
	var vnFname=ovnfName;
	scope.searchButtonText ='Searching';
	http({
            method: 'POST',
            url: 'http://localhost:8080/vnfUploadAll',
            headers: {
               'Content-Type': undefined
            },
            params: {
               
                imageName:  imgnm,
				flavfilename:filename,
				ServeNam:servern,
				imgType:imGtype,
				contype:container,
				VnFName:vnFname
            }
        })
        .then(function (data) {
		
			var edata=JSON.stringify(data.data);
			if(edata.indexOf('Failed')>=0){
				
				scope.uploadedFilefailure = true;
				
			}
			else{ 
				scope.uploadedFileSuccess = true;
			}
			scope.searchButtonText ='stop';			
			scope.successmessage=data.data;
				
		});
	
}
scope.gotoimg1=function(valh){
	
	scope.ipath=valh;
	scope.showtable=false;
}
scope.onvvnftypeChange=function(vvnftype){
	scope.vnftypeid=vvnftype;
	http({
			url: "http://localhost:8080/vnfgetuploadimage",
			params: {vnfid: vvnftype}
			
			}).then(function (response) {
			var sdata=JSON.stringify(response.data);
			var cdata=JSON.parse(sdata);
			scope.vimfnames = cdata;
			
	}); 
	
}
scope.onvvimgChange=function(vimgnm){
	
	http({
			url: "http://localhost:8080/vnfUploadView",
			params: {ImageId: vimgnm,
					 vnftypeid:scope.vnftypeid}
			
			}).then(function (response) {
			var sdata=JSON.stringify(response.data);
			var cdata=JSON.parse(sdata);
			scope.vfnames = cdata;
			scope.showtable=true;
			
	}); 
}
scope.onvfavChange=function(flv){
	
}
}]);
