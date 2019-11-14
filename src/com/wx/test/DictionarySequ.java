package com.wx.test;
import java.util.Comparator;
import java.util.ArrayList;
import java.util.Collections;

public class DictionarySequ {
	public static void main(String[] args) {
		ArrayList list = new ArrayList();
		list.add("helloworld");
		list.add("1387947260");
		list.add("1387481411");
		
		/*
		 * 运用Collections的sort（）方法对其进行排序 sort（）方法需要传 连个参数，一个是需要进行排序的Collection
		 * 另一个是一个Comparator
		 */
		Collections.sort(list, new SpellComparator());
		for (int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i));
		}
		
	}
	
	public ArrayList reBackLists(ArrayList lists){
		/*
		 * 运用Collections的sort（）方法对其进行排序 sort（）方法需要传 连个参数，一个是需要进行排序的Collection
		 * 另一个是一个Comparator
		 */
		ArrayList al = new ArrayList();
		Collections.sort(lists, new SpellComparator());
		for (int i = 0; i < lists.size(); i++) {
			al.add(lists.get(i));
		}
		return al;
	}
	
}

/**
 * 汉字拼音排序比较器
 */
class SpellComparator implements Comparator {
	public int compare(Object o1, Object o2) {
		try {
			// 取得比较对象的汉字编码，并将其转换成字符串
			String s1 = new String(o1.toString().getBytes("GB2312"),
					"ISO-8859-1");
			String s2 = new String(o2.toString().getBytes("GB2312"),
					"ISO-8859-1");
			// 运用String类的 compareTo（）方法对两对象进行比较
			return s1.compareTo(s2);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
}