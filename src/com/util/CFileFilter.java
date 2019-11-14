package com.util;

import java.io.*;

public class CFileFilter implements FilenameFilter{
String _extension[] = {".*"};

  public CFileFilter() {
  }

  public CFileFilter(String[] extension)
  {
    _extension = new String[extension.length];
    for (int i=0;i<extension.length ;i++)
    {
      _extension[i] = "." + extension[i].toUpperCase() ;
    }
  }

  public boolean accept(File dir,String name)
  {
    for(int i=0;i<_extension.length ;i++)
    {
      if (new File(dir + File.separator + name).isFile() )
      {
        if (_extension[i].equals(".*")) return true;
        if (_extension[i].equals("."))
        {
          if (name.indexOf(".") < 0) return true;
        }
        if (name.toUpperCase().endsWith(_extension[i]) ) return true;
      }
    }

    return false;
  }
}