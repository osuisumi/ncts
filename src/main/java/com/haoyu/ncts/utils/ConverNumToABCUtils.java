package com.haoyu.ncts.utils;

public class ConverNumToABCUtils {
	
	public  static char conver(int num){
		char [] map = {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};
		if(num>=25){
			return 'Z';
		}else if(num<=0){
			return 'A';
		}else{
			return map[num];
		}
	}

}
