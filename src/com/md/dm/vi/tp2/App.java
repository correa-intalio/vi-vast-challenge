package com.md.dm.vi.tp2;

import org.mortbay.jetty.Server;
import org.mortbay.jetty.webapp.WebAppContext;

public class App {

	/**
	 * @see http://wiki.eclipse.org/Jetty/Tutorial/Embedding_Jetty#Setting_a_Web_Application_Context
	 * @param args
	 * @throws Exception
	 */
	public static void main(String[] args) throws Exception {

	      Server server = new Server(8080);
	      
	        WebAppContext context = new WebAppContext();
	        context.setDescriptor("webapp/WEB-INF/web.xml");
	        context.setResourceBase("./webapp");
	        context.setContextPath("/vast-challenge");
	        context.setParentLoaderPriority(true);
	 
	        server.setHandler(context);
	 
	        server.start();
	        server.join();
	}
}
