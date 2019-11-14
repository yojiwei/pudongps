
This directory has a special behavior. When the server
is running in development mode, applications or modules placed in
this directory deploy automatically.

The file (or files) you place in this directory can
be:

* A J2EE application EAR file
* A WAR, EJB JAR, RAR, or CAR archived module
* An exploded directory structure, either for an
application or a module

To auto deploy, all you need to do is:

* Start the server in development mode.
* Place the exploded directory structure or archive file 
in this directory. 

When you auto deploy, the server automatically adds an
entry for your application or module to the domain's 
config.xml file. You do not need to edit config.xml directly.




UNDERSTANDING THE DOMAIN DEFAULT BEHAVIORS

If you have reached this file, you are in the 
mydomain, examples, or petstore domain.

Each domain starts in development or production
mode by default. Development mode enables auto deployment,
and production mode disables it. The default behaviors are:

* examples - development mode, with auto deployment
* petstore - production mode, no auto deployment
* mydomain - production mode, no auto deployment



STARTING THE SERVER IN DEVELOPMENT MODE

You now need to start one of the servers.

If you are in the examples domain, you will start the
examples server; in the petstore domain, the Pet Store
server; in mydomain, a WebLogic administration server. 

To start one of the servers in development mode, do
either of the following:


1) Edit the server's start script, then use the 
script to start the server.

The start script has a file suffix of either .cmd 
(for Windows) or .sh (for Unix).

* For the examples domain, edit startExamplesServer.
* For the petstore domain, edit startPetStore.
* For mydomain, edit startWebLogic.

Use a text editor to edit this line in the start script:

set STARTMODE=

For production mode, set the value to TRUE. For development mode 
and auto deployment, set it to FALSE or leave it blank.



2) Start the server from the command line with the
ProductionModeEnabled flag set to false.

Start the server using a Java interpreter command line
appropriate for your server, like this one, but all 
on one line:

% java -ms200m -mx200m -classpath $CLASSPATH
	-Dweblogic.Name=myserver
	-Dweblogic.ProductionModeEnabled=false
	-Dweblogic.management.username=myUserName
	-Dweblogic.management.password=myPassword
	weblogic.Server

For more details on how to start a server from the command line,
see the BEA WebLogic Server Administration Guide on
http://e-docs.bea.com/wls/docs70/adminguide/startstop.html.







