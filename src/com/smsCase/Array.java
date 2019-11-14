package com.smsCase;
public class Array {

	public String[] getArrays(String[] aa, String bb[]) {
		int i = 0;
		int a = aa.length;
		int b = bb.length;
		i = a + b;
		String[] arrays = new String[i];
		String[] myarrays = new String[i];
		System.arraycopy(aa, 0, arrays, 0, a);
		System.arraycopy(bb, 0, arrays, a, b);
		// 一种去掉重复的东西不过不知道怎么用？
		// List list = Arrays.asList(arrays);
		// Set set = new HashSet(list);
		// myarrays=(String[])set.toArray();
		// 另一种去掉重复的东西的方法
		int index = 0;
		for (int m = 0; m < arrays.length; m++) {
			if (!this.isExistString(myarrays, arrays[m])
					&& !arrays[m].equals("")) {
					myarrays[index++] = arrays[m];
			}
		}
		return myarrays;
	}

	public boolean isExistString(String[] dest, String str) {
		boolean flag = false;
		for (int i = 0; i < dest.length; i++) {
			if (str.equals(dest[i])) {
				flag = true;
			}
		}
		return flag;
	}
    public String[] getarr(String[] aa,String[] bb){
	
		int b = bb.length;
		
		int count=0;
		String[] arrays = new String[b];
		for(int d=0;d<bb.length;d++){
			int wo=0;
			for(int c=0;c<aa.length;c++){
				if(bb[d]==aa[c]){
					wo=1;
					break;
					}
				}
			if(wo==0)
			{
				arrays[count++]=bb[d];
			}
		}
		return arrays;
    }
    
    public String[] getarr1(String[] aa,String[] bb){
    	
		int a = aa.length;
		
		int count1=0;
		String[] arrays1 = new String[a];
		for(int d=0;d<aa.length;d++){
			int wo=0;
			for(int c=0;c<bb.length;c++){
				if(aa[c]==bb[d]){
					wo=1;
					break;
					}
				}
			if(wo==0)
			{
				arrays1[count1++]=aa[d];
			}
		}
		return arrays1;
    }
    
	public static void main(String args[]) {
		Array arr = new Array();
		String xiaowei[] = { "1","2","3" };
		String xiaoling[] = { "1","2"};
//		String xiaoli[] = arr.getArrays(xiaowei,xiaoling);
//		for (int j = 0; j < xiaoli.length; j++) {
//			System.out.println("组合后的数组为：第" + j + "个数为：" + xiaoli[j]);
//		}
//		System.out.println(xiaoli.length);
		String xiaosuo[]=arr.getarr(xiaowei, xiaoling);
		for (int j = 0; j < xiaosuo.length; j++) {
			if(xiaosuo[j]!=null)			
			System.out.println("xiaowei.xiaoling不相同数为：第" + j + "个数为：" + xiaosuo[j]);
		}
		String xiaosuo1[]=arr.getarr( xiaoling,xiaowei);
		for (int j = 0; j < xiaosuo1.length; j++) {
			if(xiaosuo1[j]!=null)			
			System.out.println("xiaoling.xiaowei不相同数为：第" + j + "个数为：" + xiaosuo1[j]);
		}
	}

}
