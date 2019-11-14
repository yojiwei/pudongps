package com.util;

public class BusyFlag {

	public BusyFlag() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected Thread busyflag = null;
	
	protected int busycount = 0;
	
	public synchronized void getBusyFlag(){
		while(tryGetBusyFlag() == false){
			try{
				wait();
			}catch(Exception e){
				System.out.println(e.getMessage());
			}
		}
	}
	
	private synchronized boolean tryGetBusyFlag(){
		if(busyflag == null){
			busyflag = Thread.currentThread();
			busycount = 1;
			return true;
		}
		if(busyflag == Thread.currentThread()){
			busycount++;
			return true;
		}
		return false;
	}
	
	public synchronized Thread getOwner(){
		return busyflag;
	}
	
	public synchronized void freeBusyFlag(){
		if(getOwner() == Thread.currentThread()){
			busycount--;
			if(busycount == 0){
				busyflag = null;
				notify();
			}
		}
	}
	
	
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
