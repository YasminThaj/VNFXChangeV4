routerApp.controller('vnffuncController',['$scope','$location','$http',function(scope,loc,http){
	
	scope.fpath ='testcases.html';
	scope.nval=true;	
	scope.funvnftype='';
	scope.funvnfname='';
	scope.testcasetype='';
	scope.testcase='';
	scope.exedate='';
	scope.testcase1='';
	scope.testcase2='';
	scope.testcase3='';
	scope.tcisChecked='';
	scope.selctchb1='';
	scope.selctchb2='';
	scope.selctchb3='';
	var TC1="TC1:Register User through SBC";
	var TC2="TC2:Make call from Orginiator,RemoteUser drop the call";
	var TC3="TC3:Un_Registering User";
	//	var checkExecute  = $("#tstbutn");
//	checkExecute.prop('disabled', true);
	scope.isDis = true;
	scope.selectedName = '';
	scope.selectedVName = '';
	scope.viewDisplay = false;	
	scope.gotofun1=function(fpath){
		console.log("fpath---------------"+ fpath)
	scope.nval=true;
	scope.isDisabled = false;
		scope.fpath=fpath;

scope.viewDisplay = false;		
	}
	scope.isDisabled = false;
	
	scope.gotoexecute =function(){   
	
	    var svname=scope.selectedVName;
		var svtype=scope.selectedName;
		//var tcs=scope.tcisChecked;
		var tcs1=scope.selctchb1;
		var tcs2=scope.selctchb2;
		
		/*function getSelectedCheckbox(frm){
			var selectbox = [];
			
			var inputfields = frm.getElementsByTagName('input');
			var len_inputfields=inputfields.lenght;
			
			for(var i=0; i<len_inputfields; i++) {
				if(inputfields[i].type == 'checkbox' && inputfields[i].checked == true) selectbox
				console.log("selected"+ selectbox)
			}
			return selectbox;
		}
		document.getElementById('tstbutn').onClick=function(){
			var selcbox= getSelectedCheckbox(this.form);
			console.log("hereeee"+selcbox)
		}*/
		console.log("tcs1---" + tcs1);
		console.log("tcs2---" + tcs2);
		console.log("vtyp---" + scope.selectedName);
		console.log("gotoexecute---" + scope.funvnfname);
		//scope.isDisabled = true;
		scope.searchButtonText="Searching";
		//document.getElementById('tstbutn').value="Executing ...";
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
		scope.exedate=today;
		console.log("eedate"+scope.exedate);
		
		
		http.get("http://localhost:8080/vnfexecute1")
		.then(function (response) {
		console.log("executedata------------------"+response.data);
		scope.nval=false;
		});
			setTimeout(function () {
		    scope.$apply(function(){
			scope.searchButtonText="false";
			//scope.names = response.data;
			//scope.report = response.report;
			
            scope.viewDisplay = true;			
			
		document.getElementById('rep').className='active';
		document.getElementById('test').className='';
		scope.fpath='reports.html';
		  });
		}, 75000);
	
		http({
			url:"http://localhost:8080/vnfexecute",
			method:"POST",
			params:{exe_vnfnam:svname,
			exe_type:svtype,
			testCas1:tcs1,
			testCas2:tcs2,
			exe_date:today}
			
		    }).then(function (response) {
			var odata=JSON.stringify(response.data);
		    console.log("mongodata------------------"+response.data);
		    //scope.nval=false;
	//			http.get("http://localhost:8080/vnfreport")
	//			.then(function (response) {
	//			console.log("reportdata"+response.data);	
		});	
		
    }

	
	scope.ontypeChange =function(svtype){

	
		scope.showdrdwn=true;
		scope.funvnftype=svtype;
		console.log("------jjhgjhgjhg" + scope.funvnftype);
		var ovtype=scope.funvnftype.split(',');
		scope.selectedName=ovtype[1];
		console.log("------jjhgjhgjhg" + ovtype);
	
		http({
			url: "http://localhost:8080/vnfgetvnfname",
			params: {vnffuntypeid: ovtype[0]}
			
			}).then(function (response) {
				
			var sdata=JSON.stringify(response.data);
			
			var cdata=JSON.parse(sdata);
			
			scope.vimfunnames = cdata;
			console.log("gettingname"+ scope.vimfunnames)
			
	}); 
	
}

scope.onnameChange =function(sname){

	
		scope.showcheckbox=true;
		scope.showbtn=true;
		scope.funvnfname=sname;
		scope.selectedVName = sname;
		console.log("------name" + sname);
		console.log("------name----------" + scope.selectedName);
}

/*scope.testcase= [
        { name: "TestCase1",  isChecked: false }, 
        { name: "TestCase2",  isChecked: false } 
       
    ];

scope.tctypeChange =function(selectedtc){
	scope.tcisChecked = selectedtc;
	console.log("checktypebefr-------if"+ scope.tcisChecked)
	    if(scope.tcisChecked !=null){
		console.log("checktype-------if"+ scope.tcisChecked)
		scope.isDis = false;
	}
}*/	

scope.Testcase1 =function(test1){
	scope.testcase1 = test1;
	console.log("checktype1bfr-------if"+ test1)
	if(scope.testcase1 == true){
		scope.selctchb1=TC1;
		console.log("checktype1aftr-------if"+ scope.selctchb1)
		scope.isDis = false;
	}else{
		scope.isDis = true;
	}
}
scope.Testcase2 =function(checktype2){
	scope.testcase2 = checktype2;
	console.log("checktype2bfr-------if"+ checktype2)
	if(scope.testcase2 == true){
		scope.selctchb2=TC2;
		console.log("checktype2aftr-------if"+ scope.selctchb2)
		scope.isDis = false;
	}else{
		//scope.isDis = true;
	}
}
scope.Testcase3 =function(checktype3){
	scope.testcase3 = checktype3;
	console.log("checktype3bfr-------if"+ checktype3)
	if(scope.testcase3 == true){
		scope.selctchb3=TC3;
		console.log("checktype3aftr-------if"+ scope.selctchb3)
		scope.isDis = false;
	}else{
		//scope.isDis = true;
	}
}
/*scope.Testcase3 =function(checktype3){
	scope.testcase3 = checktype3;
	console.log("checktype3-------if"+ checktype3)
	if(scope.testcase3 == true){
		console.log("checktype3-------if"+ checktype3)
		scope.isDis = false;
	}else{
		//scope.isDis = true;
	}
}

scope.Testcase4 =function(checktype4){
	scope.testcase4 = checktype4;
	console.log("checktype4-------if"+ checktype4)
	if(scope.testcase4 == true){
		console.log("checktype4-------if"+ checktype4)
		scope.isDis = false;
	}else{
		//scope.isDis = true;
	}
}
scope.Testcase5 =function(checktype5){
	scope.testcase5 = checktype5;
	console.log("checktype5-------if"+ checktype5)
	if(scope.testcase5 == true){
		console.log("checktype5-------if"+ checktype5)
		scope.isDis = false;
	}else{
		//scope.isDis = true;
	}
}
scope.Testcase6 =function(checktype6){
	scope.testcase6 = checktype6;
	console.log("checktype6-------if"+ checktype6)
	if(scope.testcase6 == true){
		console.log("checktype6-------if"+ checktype6)
		scope.isDis = false;
	}else{
		//scope.isDis = true;
	}
}
scope.Testcase7 =function(checktype7){
	scope.testcase7 = checktype7;
	console.log("checktype7-------if"+ checktype7)
	if(scope.testcase7 == true){
		console.log("checktype7-------if"+ checktype7)
		scope.isDis = false;
	}else{
		//scope.isDis = true;
	}
}
scope.Testcase8 =function(checktype8){
	scope.testcase8 = checktype8;
	console.log("checktype8-------if"+ checktype8)
	if(scope.testcase8 == true){
		console.log("checktype8-------if"+ checktype8)
		scope.isDis = false;
	}else{
		//scope.isDis = true;
	}
}
scope.Testcase9 =function(checktype9){
	scope.testcase9 = checktype9;
	console.log("checktype9-------if"+ checktype9)
	if(scope.testcase9 == true){
		console.log("checktype9-------if"+ checktype9)
		scope.isDis = false;
	}else{
		//scope.isDis = true;
	}
}
scope.Testcase10 =function(checktype10){
	scope.testcase10 = checktype10;
	console.log("checktype10-------if"+ checktype10)
	if(scope.testcase10 == true){
		console.log("checktype10-------if"+ checktype10)
		scope.isDis = false;
	}else{
		//scope.isDis = true;
	}
}
scope.Testcase11 =function(checktype11){
	scope.testcase11 = checktype11;
	console.log("checktype11-------if"+ checktype11)
	if(scope.testcase11 == true){
		console.log("checktype11-------if"+ checktype11)
		scope.isDis = false;
	}else{
		//scope.isDis = true;
	}
}*/
	
}]);
		
	