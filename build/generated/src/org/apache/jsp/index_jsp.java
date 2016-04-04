package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.HashMap;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList<String>(3);
    _jspx_dependants.add("/default-stylesheets.jsp");
    _jspx_dependants.add("/header.jsp");
    _jspx_dependants.add("/clearance-check.jsp");
  }

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE HTML>\n");
      out.write("\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("    ");
      out.write("<title>Cashmere Freeway</title>\n");
      out.write("<meta http-equiv=\"content-type\" content=\"text/html; charset=utf-8\" />\n");
      out.write("\n");
      out.write("<!--[if lte IE 8]><script src=\"js/html5shiv.js\"></script><![endif]-->\n");
      out.write("<script src=\"js/jquery.min.js\"></script>\n");
      out.write("<script src=\"js/skel.min.js\"></script>\n");
      out.write("<script src=\"js/skel-layers.min.js\"></script>\n");
      out.write("<script src=\"js/init.js\"></script>\n");
      out.write("<script src='http://code.jquery.com/jquery-1.10.1.min.js'></script>\n");
      out.write("<script src=\"jquery-1.10.2.min.js\" type=\"text/javascript\"></script>\n");
      out.write("<script src=\"http://d1ml0gfpm9yj9s.cloudfront.net/scrollIt.min.js\"></script>\n");
      out.write("<script src=\"js/scrollIt.min.js\" type=\"text/javascript\"></script>\n");
      out.write("\n");
      out.write("<noscript>\n");
      out.write("    <link type=\"text/css\" rel=\"stylesheet\" href=\"css/style.css\"/>\n");
      out.write("    <link type=\"text/css\" rel=\"stylesheet\" href=\"css/skel.css\"/>\n");
      out.write("    <link type=\"text/css\" rel=\"stylesheet\" href=\"css/style-large.css\"/>\n");
      out.write("</noscript>\n");
      out.write("\n");
      out.write("<!--<noscript>\n");
      out.write("<link rel=\"stylesheet\" href=\"css/skel.css\" />\n");
      out.write("<link rel=\"stylesheet\" href=\"css/style.css\" />\n");
      out.write("<link rel=\"stylesheet\" href=\"css/style-large.css\" />\n");
      out.write("</noscript>\n");
      out.write("-->\n");
      out.write("<script>$(function() { $.scrollIt(); });</script>");
      out.write("\n");
      out.write("\n");
      out.write("</head>\n");
      out.write("<body id=\"top\">\n");
      out.write("<!-- Website by Brett Morrison - All rights reserved.\n");
      out.write("        Contact: ca.linkedin.com/in/schlaBAM -->\n");
      out.write("<!-- Header -->\n");
      out.write("\n");
      out.write("\n");
      out.write("<header id=\"header\" class=\"skel-layers-fixed\">\n");
      out.write("    <h1><a href=\"index.jsp\"><img id=\"bannerLogo\" src=\"images/cashmere.png\"/></a></h1>\n");
      out.write("    <nav id=\"nav\">\n");
      out.write("        <ul>\n");
      out.write("            ");

    Boolean b = false;
    if (session.getAttribute("clearance") != null)
        b = true;


    int c = 0;
    if (b) {
        c = (Integer) session.getAttribute("clearance");
    }



      out.write("\n");
      out.write("            ");

                //Find Permissions
                if (b) {
                    if (c == 1) {
                        out.print("<li>Admin Signed in<ul><li><a href='update-items-page.jsp'>Update Items</a></li></li>");
                        out.print("<li><a href='sales.jsp'>Sales</a></li></ul>");
                    }
                }
                HashMap productlist = (HashMap) session.getAttribute("productList");
                if (productlist != null) {
                    out.print("<li><a href='showcart.jsp'>Shopping Cart</a></li>");

                }
            
      out.write("\n");
      out.write("            <li><a href=\"listprod.jsp\">Buy Drugs</a>\n");
      out.write("                <ul id=\"nav_about\">\n");
      out.write("                    <li><a href=\"listprod.jsp?categoryName=Weed\">Marijuana</a></li>\n");
      out.write("                    <li><a href=\"listprod.jsp?categoryName=Opioids\">Opioids</a></li>\n");
      out.write("                    <li><a href=\"listprod.jsp?categoryName=Meth\">Methamphetamines</a></li>\n");
      out.write("                    <li><a href=\"listprod.jsp?categoryName=Hallucinogens\">Hallucinogens</a></li>\n");
      out.write("                    <li><a href=\"listprod.jsp?categoryName=Pills\">Pills</a></li>\n");
      out.write("                    <li><a href=\"listprod.jsp\">Other</a></li>\n");
      out.write("                </ul>\n");
      out.write("            </li>\n");
      out.write("            <li><a href=\"contactus.html\">Contact</a></li>\n");
      out.write("            <li>\n");
      out.write("                ");

                    if (request.getSession().getAttribute("curUser") != null) {
                        out.print("<a href=\"user-page.jsp\" class=\"button special\">" + request.getSession().getAttribute("curName") + "</a>" +
                                "<ul><li><a href=\"user-page.jsp\">View Profile</a></li>" +
                                "<li><a href=\"sign-out.jsp\">Sign out</a></li></ul>");
                    } else {

                        out.print("<a href=\"login.jsp\" class=\"button special\">Login</a>");
                    }
                
      out.write("\n");
      out.write("            </li>\n");
      out.write("        </ul>\n");
      out.write("    </nav>\n");
      out.write("</header>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!-- Banner -->\n");
      out.write("<section id=\"banner\" data-scroll-index=\"0\">\n");
      out.write("    <div class=\"inner\">\n");
      out.write("        <h2 class=\"bannertext\">Divine. Luxury. Drugs.</h2>\n");
      out.write("\n");
      out.write("        <p class=\"bannertext\" style=\"color: white\">Try a new life destroyer today!</p>\n");
      out.write("        <ul class=\"actions\">\n");
      out.write("            <li><a href=\"register.jsp\"\n");
      out.write("                   class=\"button big special\">Apply Now</a></li>\n");
      out.write("            <li><a href=\"http://dea.gov/\" class=\"button big special\">Learn More</a></li>\n");
      out.write("        </ul>\n");
      out.write("    </div>\n");
      out.write("</section>\n");
      out.write("\n");
      out.write("\n");
      out.write("<!-- Footer -->\n");
      out.write("<footer id=\"footer\">\n");
      out.write("    <div class=\"container\">\n");
      out.write("        <div class=\"9u\">\n");
      out.write("            <br>\n");
      out.write("            <h3>Follow Us On Social Media!</h3>\n");
      out.write("\n");
      out.write("            <p>We don't actually post anywhere; you know, for legal reasons, but it's the thought that counts. </p>\n");
      out.write("        </div>\n");
      out.write("        <ul class=\"copyright\">\n");
      out.write("            <li>&copy;Jeff Soloshy &amp; <a style=\"color: #bbb\"\n");
      out.write("                                                                      href=\"http://ca.linkedin.com/in/schlaBAM\">Brett\n");
      out.write("                Morrison.</a> All rights reserved.\n");
      out.write("            </li>\n");
      out.write("        </ul>\n");
      out.write("    </div>\n");
      out.write("</footer>\n");
      out.write("\n");
      out.write("</body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
