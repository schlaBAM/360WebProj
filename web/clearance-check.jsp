<%
    Boolean b = false;
    if (session.getAttribute("clearance") != null)
        b = true;


    int c = 0;
    if (b) {
        c = (Integer) session.getAttribute("clearance");
    }


%>