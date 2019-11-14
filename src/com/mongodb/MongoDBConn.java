package com.mongodb;
/**
 * mongodbÊý¾Ý¿â²Ù×÷
 * @author Administrator
 * http://www.cnblogs.com/xumingxiang/archive/2012/04/08/2437468.html
 * http://www.csdn.net/article/2012-07-04/2807109
 *
 */
public class MongoDBConn {
	public static void main(String[] args) {    
	    
		  try {    
		    
		   Mongo mongo = new Mongo("localhost", 27017);    
		    
		   DB db = mongo.getDB("cnblogs");    
		    
		   DBCollection collection = db.getCollection("users");    
		    
		   BasicDBObject employee = new BasicDBObject();    
		   employee.put("name", "Hannah");    
		   employee.put("age", 2);    
		    
		   collection.insert(employee);    
		    
		   BasicDBObject searchEmployee = new BasicDBObject();    
		   searchEmployee.put("age", 2);    
		    
		   DBCursor cursor = collection.find(searchEmployee);    
		    
		   while (cursor.hasNext()) {    
		    System.out.println(cursor.next());    
		   }    
		    
		   System.out.println("The Search Query has Executed!");    
		    
		  } catch (Exception e) {    
		   e.printStackTrace();    
		  }    
		    
		 } 
}
