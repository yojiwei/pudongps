/*
 * @(#)MSRemoteFile.java
 * <p>Copyright: Copyright (c) 2003,2004 Rad Inks (Pvt) Ltd  </p>
 * <p>Company: Rad Inks (Pvt) Ltd</p>
 */

/*
 * License
 *
 * The contents of this file are subject to the Jabber Open Source License
 * Version 1.0 (the "JOSL").  You may not copy or use this file, in either
 * source code or executable form, except in compliance with the JOSL. You
 * may obtain a copy of the JOSL at http://www.jabber.org/ or at
 * http://www.opensource.org/.
 *
 * Software distributed under the JOSL is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied.  See the JOSL
 * for the specific language governing rights and limitations under the
 * JOSL.
 */

package com.radinks.net;


/**
 * Represents a file on a FTP server running on the windows platform.
 * @author Raditha Dissanayake
 * @version 1.01
 */

import java.text.*;
import java.util.*;

public class MSRemoteFile extends RemoteFile {

        /**
         * This defaults constructor with package access is intended for use by
         * the {@link RemoteFile} class.
	 */

	MSRemoteFile()
	{
	}

	/**
	 * Creates the new instance based by parsing the data provided in the
	 * input string.
	 *
         * @param s
         */
	public MSRemoteFile(String s) {
		attrs = new FileAttrs();
		/*
		 * the order of the parts are
		 * date time <dir> size filename
		 * mm-dd-yy hh:mm(AM/PM)
		 */

		/* is this is a directory */
		if(s.substring(24,29).equals("<DIR>"))
		{
		attrs.setDir(true);
		}
		else
		{
			/*
			 *the file size in bytes, in windows a file size is
			 * not assigned to directories
			 */
			String num = s.substring(30,39);
			if(num == null)
			{
				num ="0";
			}
			try {
				attrs.setSize(Long.parseLong(num.trim()));
			} catch (Exception ex1) {
				return ;
			}
       		 }

		Calendar cal = Calendar.getInstance();
		String dateTime ="";
	
		/* grab the date and time (first two columns) */
		dateTime = s.substring(0,9) + s.substring(10,17);
		SimpleDateFormat dateFormat = new SimpleDateFormat("MM-DD-yyHH:mm");
		try {
		Date date =  dateFormat.parse(dateTime);
		attrs.setTime(date.getTime());
		}
		catch (ParseException ex) {
		//ex.printStackTrace();
		}
	
		/* grab the file name */
		fileName = s.substring(39,s.length());
	}
}