import sys,os
import AutoItLibrary
import win32com.client
import ConfigParser
import paramiko
import shutil 
reload(sys)  
sys.setdefaultencoding('UTF-8')
autoit=win32com.client.Dispatch("AutoItX3.Control")


Config = ConfigParser.ConfigParser()

#********************The below function is used for Parse data from Config file************#
def parseconfdata(path,section):
	Config.read(path)
	Config.sections()
	dict1={}
	options = Config.options(section)
	#print options
	lst=[]
	for option in options:
		try:
			dict1[option] = Config.get(section,option)
			#print dict1[option]
			lst.append(dict1[option])
			
			#print lst
			#strng = dict1[option]
			if dict1[option] == -1:
				DebugPrint("skip: %s" % option)
		except:
			print("exception on %s!" % option)
			dict1[option] = None
	return lst

	
def getimagename(serverpath,name):	
	
	#img= imagelocalpath.split('/')
	#name= img[-1]	
	str= [serverpath,name]
	remotepath= '/'.join(str)
	return remotepath
	
	
def PushImagetoServer(host,user,pwd,srcpath):
	ssh = paramiko.SSHClient() 
	LP=srcpath.strip()
	ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
	ssh.load_system_host_keys()
	#ssh.load_host_keys(os.path.expanduser(os.path.join("~", ".ssh", "known_hosts")))
	ssh.connect(hostname=host,username=user,password=pwd)
	sftp = ssh.open_sftp()
	dst ='/root/auto_heatfiles'
	sftp.put(LP,dst)
	sftp.close()
	ssh.close()

def remove_tracedir(host,user,pwd):
	ssh = paramiko.SSHClient() 
	#LP=srcpath.strip()
	ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
	ssh.load_system_host_keys()
	#ssh.load_host_keys(os.path.expanduser(os.path.join("~", ".ssh", "known_hosts")))
	ssh.connect(hostname=host,username=user,password=pwd)
	sftp = ssh.open_sftp()
	dst ='/opt/traces/'
	sftp.remove(dst)
	sftp.close()
	ssh.close()
	
def get_string(path):
		o = open(path,'r+')
		r= o.read()
		s= r.split(" ")
		print s
		a=s[36]
		string1 = a.split("=")
		string2= string1[1]
		IP=string2[:-1]
		print IP
		return IP
		
def join_string(id):
	i=id.strip()
	seq1=(i,"--allowed-address-pairs type=dict list=true ip_address=0.0.0.0/1 ip_address=128.0.0.0/1 ip_address=::/1 ip_address=8000::/1")
	a= " ".join(seq1)
	#b= (id,seq1)
	return a
	
	
def tabloop(num):
		print "Worked"
		for i in range(0,int(num)):	 
			autoit.Send("{TAB}")
			if i==num: 
				break
				
def rev_tab(num):
    
    for i in range(0,int(num)):	 
        autoit.Send("+{TAB}")
        if i==num: 
            break
			
			


#The below func is used to rename the file
def rename_file(path_of_file,src,dst):
		os.chdir(path_of_file)
		os.rename(src,dst)
		print "the dir is: %s" %os.listdir(os.getcwd())
	