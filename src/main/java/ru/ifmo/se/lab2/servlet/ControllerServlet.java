package ru.ifmo.se.lab2.servlet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class ControllerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(true);

        String clearSession = request.getParameter("clearSession");
        if (clearSession != null && clearSession.equals("true")) {
            session.invalidate();
        }

        RequestDispatcher dispatcher;
        if (checkParams(
                request.getParameter("x"),
                request.getParameter("y"),
                request.getParameter("r"))) {
            dispatcher = getServletContext().getRequestDispatcher("/check");
        } else {
            dispatcher = getServletContext().getRequestDispatcher("/index.jsp");
        }
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    private Boolean checkParams(String xStr, String yStr, String rStr) {
        try {
            Double x = Double.valueOf(xStr);
            Double y = Double.valueOf(yStr);
            Double r = Double.valueOf(rStr);
            if(  y >=-6 && y <=6 && x >=-6 && x <= 6 && r >= 2 && r<=5 )
                return true;
            else return false;
        } catch (Exception e) {
            return false;
        }
    }
}
