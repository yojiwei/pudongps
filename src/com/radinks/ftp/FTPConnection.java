/*
 * @(#)FTPConnection.java
 * Copyright: Copyright (c) 2003, 2004 Rad Inks (Pvt) Ltd.
 * Company: Rad Inks (Pvt) Ltd.</p>
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

package com.radinks.ftp;

import com.radinks.net.*;
import java.net.*;
import java.io.*;
import java.util.*;


import java.util.*;



/**
 * <p>Implements an RFC 959 ftp class. It should be noted that many FTP servers
 * do not provide a complete implementation of this RFC. There for this class
 * does not attempt to support the full RFC either.
 * </p>
 *
 * <p>The most notable feature of this class is that when a '5xx' response is
 * returned by the server the method that recieved this response will return a
 * 0 or a null, instead of throwing an exception.</p>
 *
 * <p>Exceptions will only be thrown when we run into an unexpected error such
 * as socket time out or server disconnection.</p>
 *
 * <p> NOTE: This class is based on the FTPConnection class used in the
 * <a href="http://www.radinks.com/ftp/applet/">Rad FTP applet</a>
 *
 * @author Raditha Dissanayake
 * @version 1.1
 */


public class FTPConnection extends com.radinks.net.FTPConnection {

	private boolean showHiddenFiles;
	/**
	 * Open the connection.
	 * Note that this method does not override the
	 * {@link com.radinks.net.FTPConnection#openConnection openConnection()} method
	 * in it's superclass but overloads it.
	 *
	 * @param host Name or IP of the FTP server
	 * @param port the port that the FTP server has bound to.
	 * @throws IOException
	 * @throws UnknownHostException
	 */
	public void openConnection(String host,int port) throws IOException, UnknownHostException
	{
		sock_control = new Socket();//
		port = (port == 0) ? 21 : port;
		InetSocketAddress addr = new InetSocketAddress(host,port);
		sock_control.connect(addr);


		sock_control.setSoTimeout(timeout);
		in = sock_control.getInputStream();
		out = sock_control.getOutputStream();
		writer = new OutputStreamWriter(out);
	}

	/**
	 * Retrieves the path to the current working directory by executing
	 * the PWD command.
	 * @return current directory.
	 * @throws IOException
	 */
	public String pwd() throws IOException
	{
		writeln("PWD");
		if(check_reply("257"))
		{
			/*
			 * in version 1.00 we split by the space (' ') to separate the
			 * path from the status code. But this lead to a situation
			 * where folders which contained spaces were not being handled
			 * correctly.
			 *
			 * the current approach is possibly more efficient since it does
			 * not split the lastMessage into pieces.
			 */
			int strt = lastMessage.indexOf('"');
			if(strt > 0)
			{
				/* we have a path name that is quoted. */
				int end = lastMessage.lastIndexOf('"');
				return lastMessage.substring(strt-1,end+1).trim();
			}
			else
			{
				/* path name is not quoted */
				return lastMessage.substring(4,lastMessage.indexOf("is current directory"));
			}
		}
		else
		{
	        return null;
                }
        }

        /**
         * List the contents of the current working directory.
         * @return file list.
         * @throws IOException
         */
        public java.util.List list() throws IOException
        {
                return list("");
        }

        /**
         * Opens a data connection and retrieves the directory listing. The list
         * is a collection of string objects.
         *
         * @param path The pathname to list.
         * @return file list
         * @throws IOException
         */
        public java.util.List list(String path) throws IOException
        {
                List list = new ArrayList();
                    DataConnection data_sock = makeDataConnection();
                    if(data_sock != null)
                    {
                            String cmd = (showHiddenFiles) ? "LIST -al" : "LIST";
                            if(path == null || path.equals(""))
                            {
                                writeln(cmd);
                            }
                            else
                            {
                                    writeln(cmd +" " + path);
                            }
                            if(check_reply("150") || lastMessage.startsWith("125"))
                            {
                                    /*
                                     * windows ftp server returns 125 at times
                                     */

                                    BufferedReader bin =new BufferedReader(new InputStreamReader(data_sock.getInputStream()));
                                    // here comes the directory listing
                                    while(true)
                                    {
                                            String s = bin.readLine();
                                            if(s==null)
                                            {
                                                    break;
                                            }
                                            IRemoteFile f = RemoteFile.parse(s);
                                            if(f != null)
                                                    list.add(f);
                                    }
                                    bin.close();
                                    //sock_data.close();
                                    return (check_reply("226")) ? list : null;
                        }
                    }
                return null;
        }

	/**
	 * Creates an OutputStream to the file on the remote server. Does not
	 * bother with overwriting existing files. You must call the
	 * {@link com.radinks.net.FTPConnection#isOk isOk()}
	 * method after you complete writing to clean up the control connection
	 * message que
	 *
	 * @param path - path name on the server.
	 * @return <code>OutputStream</code> to which the contents of the file
	 *  should be written.
	 * @throws IOException
	 */
	public OutputStream put(String path) throws IOException
	{
		/* switch to passive mode */
		DataConnection data_sock = makeDataConnection();
		if(data_sock != null)
		{
			if(path == null || path.equals(""))
			{
			    return null;
			}
			else
			{
				writeln("STOR " + path);
			}
			if(check_reply("150") || lastMessage.startsWith("125"))
			{
				return data_sock.getOutputStream();
			}
		}

		return null;
	}
	/**
	 * Returns an inputstream to the file on the remote server. Once the
	 * file tranfer has been completed, you need to call is the
	 * * {@link com.radinks.net.FTPConnection#isOk isOk()} method
	 * to remove the response from the control connection's message que.
	 *
	 * @param path the name of the file to retrieve.
	 * @return the InputStream for the data connection.
	 *
	 * @throws IOException
	 */
	public InputStream get(String path) throws IOException
	{
		/* switch to passive mode */
		DataConnection data_sock = makeDataConnection();
		if(data_sock != null)
		{
			if(path == null || path.equals(""))
			{
			    return null;
			}
			else
			{
				writeln("RETR " + path);
			}
			if(check_reply("150") || lastMessage.startsWith("125"))
			{
				return data_sock.getInputStream();
			}
		}
		return null;
	}


	/**
	 * Deletes specified path. Does not glob.
	 *
	 * @param path the file to delete
	 * @return success or failure
	 * @throws IOException
	 */
	public boolean rm(String path) throws IOException
	{
	    writeln("DELE " +path);
		return check_reply("250");
	}

	/**
	 * Deletes specified directory. Does not glob. failes if empty
	 * @param path the directory to delete
	 * @return success or failure
	 * @throws IOException
	 */
	public boolean rmd(String path) throws IOException
	{
		writeln("RMD " +path);
		return check_reply("250");
	}

	/**
	 * First step in the rename operation.
	 * @param path for the victim
	 * @return did it work?
	 * @throws IOException
	 */
	public boolean rnfr(String path) throws IOException
	{
		writeln("RNFR " + path);
		return check_reply("350");
	}

	/**
	 * the second part of the rename operation.
	 * @param path the new name
	 * @return how did it go?
	 * @throws IOException
	 */
	public boolean rnto(String path) throws IOException
	{
		writeln("RNTO " + path);
                return check_reply("250");
        }

        /**
         * Overrides the {@link com.radinks.net.FTPConnection#initStream initStream()}
         * initStream() method in {@link com.radinks.net.FTPConnection}.
         *
         * we collect information about the operating system in this method. We
         * need to know if we are dealing with the redmond stuff.
         *
         * @throws IOException
         */

        public void initStream() throws IOException
        {
                /** @todo collect the welcome message */
                while(true)
                {
                        if(check_reply("220"))
                        {
                                if(lastMessage.indexOf("Microsoft") != -1)
                                {
                                        RemoteFile.setServerType("MS");
                                }
                                break;
                        }
                }
        }

        /**
         * Switch between ascii and binary modes.
         * @param mode A for ASCII or I for Binary.
         * @return success ir failure
         * @throws IOException
         */
        public boolean type(String mode) throws IOException
        {
                writeln("TYPE "+mode);
		try {
			return check_reply("200");
		}
		catch (IOException ex) {
			return false;
		}
	}

	public void setShowHiddenFiles(boolean showHiddenFiles) {
		this.showHiddenFiles = showHiddenFiles;
	}

	public boolean isShowHiddenFiles() {
		return showHiddenFiles;
	}
}
