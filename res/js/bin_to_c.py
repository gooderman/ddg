#!/usr/bin/python
# -*- coding: UTF-8 -*-
import os
import sys,re
print "sys.arg ",len(sys.argv)
def isconvert(infile,end):
	return re.match(".+"+end+"$",infile)
def bintoc(infile,outfile):
	f=open(os.path.join(os.getcwd(),infile),"rb")
	o=open(os.path.join(os.getcwd(),outfile),"wb")
	s=os.path.getsize(os.path.join(os.getcwd(),infile))
	buff = f.read(s)
	print "		===size",s
	con="const char B[]={\n"
	line=0
	for i in xrange(0,s):		
		con=con+'{byte},'.format(byte=hex(ord(buff[i])))
		line=line+1
		if line==16:
			line=0
			con=con+"\n"
	l=len(con)
	con=con[0:l-1]
	con=con+"\n};"
	f.close()
	o.write(con)
	o.close()
def bintocdir(dir,end):	
	for parent,dirnames,filenames in os.walk(dir):	#三个参数：分别返回1.父目录 2.所有文件夹名字（不含路径） 3.所有文件名字
		for dirname in dirnames:	#输出文件夹信息
			#print "parent is:" + parent
			#print "dirname is" + dirname
			print "dir : "+os.path.join(parent,dirname)
		for filename in filenames:                        #输出文件信息
			#print "parent is:" + parent
			#print "filename is:" + filename
			print "file: " + os.path.join(parent,filename) #输出文件路径信息
			if isconvert(filename,end):
				print "bintoc: ",filename
				bintoc(filename,"aa__"+filename+"__.h")

bintocdir(os.getcwd(),R".js")