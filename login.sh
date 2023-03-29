#!/bin/ash
eUc()
{	s0=$1
	s1=${s0//=/%3D}
 	s2=${s1//&/%26}
 	s3=${s2//:/%3A}
	s4=${s3//\//%2F}
 	s5=${s4//%/%25}
 	echo $s5
 	return 0
}
getQs()
{
  info=$(wget http://222.201.54.55 -O -)
  s1=${info#*\?}
  s2=${s1%\'*}
  echo $(eUc $s2)
}

login()
{
 s0=$(curl -d "userId=$1&password=$2&service=&queryString=$3&operatorPwd=&operatorUserId=&validcode=&passwordEncrypt=false" "http://222.201.54.55/eportal/InterFace.do?method=login")
 s1=${s0#*:\"}
 s2=${s1%%\"*}
 echo $s2
}
logout()
{
 curl -d "userId=$1" "http://222.201.54.55/eportal/InterFace.do?method=logout"
}
logoutAll()
{
 curl -d "userId=$1&pass=$2" "http://222.201.54.55/eportal/InterFace.do?method=logoutByUserIdAndPass"
}
id=2006200014
psw=147258
#init 
logoutAll $id $psw
qS=$(getQs)
userId=$(login $id $psw $qS)

#login
login()
{
 logout userId
 qS=$(getQs)
 userId=$(login $id $psw $qS)
}
#end