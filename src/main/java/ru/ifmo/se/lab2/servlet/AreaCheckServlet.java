package ru.ifmo.se.lab2.servlet;

import ru.ifmo.se.lab2.model.Check;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import static java.lang.Math.pow;

public class AreaCheckServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(true);

        List<Check> checks = (List<Check>) session.getAttribute("checks");


        if (checks == null) checks = new ArrayList<>();

        Check check = new Check();
        check.setX(Double.valueOf(request.getParameter("x")));
        check.setY(Double.valueOf(request.getParameter("y")));
        check.setR(Double.valueOf(request.getParameter("r")));

        check.setResult((check.getX() >= 0 && check.getY() <= 0 && check.getY() >= 0.5 * check.getX() - check.getR() / 2)
                || (check.getX() <= 0 && check.getY() >= 0 && pow(check.getX(), 2) + pow(check.getY(), 2) <= pow(check.getR() / 2, 2))
                || (check.getX() >= 0 && check.getY() >= 0) && check.getX() <= check.getR() && check.getY() <= check.getR());

        checks.add(check);

        session.setAttribute("checks", checks);
        session.setAttribute("r",request.getParameter("r"));

        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/index.jsp");
        dispatcher.forward(request, response);
    }
}
