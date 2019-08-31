<%@ page import="ru.ifmo.se.lab2.model.Check" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=utf-8" %>
<% List<Check> checks = (List<Check>) request.getSession(true).getAttribute("checks"); %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/webjars/bootstrap/4.1.3/css/bootstrap.min.css">
    <style>
        body {
            min-width: 370px;
        }
    </style>
    <script>
        window.contextApi = '<%= request.getContextPath() %>';
        <% if (checks != null) { %>
        window.checks = [
            <%
                for (int i = 0; i < checks.size(); i++) {
                Check check = checks.get(i);
            %>
            {
                x: <%= check.getX() %>, y: <%= check.getY() %>, r: <%= check.getR() %>, result: <%= check.getResult() %>
            },
            <%
                }
            %>
        ];
        window.r = <%= checks.size() > 0 ? checks.get(checks.size()-1).getR() : 0 %>;
        <% } %>
    </script>
</head>
<body>
<nav class="navbar navbar-dark bg-primary">
    <a class="navbar-brand" href="<%= request.getContextPath() %>/">Лабораторная работа #2</a>
    <span class="navbar-text">Хуснутдинова Карина, P3212, #21287 </span>
</nav>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-6">
            <form class="card" action="<%= request.getContextPath() %>/index" method="get">
                <div class="card-body">
                    <h5 class="card-title">Введите координаты</h5>
                    <fieldset class="form-group">
                        <div class="row">
                            <legend class="col-form-label col-sm-2 pt-0">X</legend>
                            <div class="col-sm-10">

                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="x" id="x_-5" value="-5">
                                    <label class="form-check-label" for="x_-5">-5</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="x" id="x_-4" value="-4">
                                    <label class="form-check-label" for="x_-4">-4</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="x" id="x_-3" value="-3">
                                    <label class="form-check-label" for="x_-3">-3</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="x" id="x_-2" value="-2">
                                    <label class="form-check-label" for="x_-2">-2</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="x" id="x_-1" value="-1">
                                    <label class="form-check-label" for="x_-1">-1</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="x" id="x_0" value="0">
                                    <label class="form-check-label" for="x_0">0</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="x" id="x_1" value="1">
                                    <label class="form-check-label" for="x_1">1</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="x" id="x_2" value="2">
                                    <label class="form-check-label" for="x_2">2</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="x" id="x_3" value="3">
                                    <label class="form-check-label" for="x_3">3</label>
                                </div>


                            </div>
                        </div>
                    </fieldset>
                    <div class="form-group row">
                        <label for="y" class="col-sm-2 col-form-label">Y</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="y" id="y" placeholder="Y">
                            <small id="y_help" class="form-text text-muted">-3 ... 5</small>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-sm-2">R</div>
                        <div class="col-sm-10">
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="checkbox" name="r" id="r_2" value="2">
                                <label class="form-check-label" for="r_2">2</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="checkbox" name="r" id="r_3" value="3">
                                <label class="form-check-label" for="r_3">3</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="checkbox" name="r" id="r_4" value="4">
                                <label class="form-check-label" for="r_4">4</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="checkbox" name="r" id="r_5" value="5">
                                <label class="form-check-label" for="r_5">5</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-sm-10">
                            <button type="submit" class="btn btn-primary">Отправить</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Координатная плоскость</h5>
                    <canvas id="plot" width="300" height="300">
                        CANVAS NOT SUPPORTED IN THIS BROWSER!
                    </canvas>
                </div>
            </div>
        </div>
    </div>
    <% if (checks != null) { %>
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Результаты</h5>
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">X</th>
                            <th scope="col">Y</th>
                            <th scope="col">R</th>
                            <th scope="col">RES</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            for (int i = 0; i < checks.size(); i++) {
                                Check check = checks.get(i);
                                if (check.getResult()) {
                        %>
                        <tr class="table-success">
                                <% } else { %>
                        <tr class="table-danger">
                            <% } %>
                            <th scope="row"><%= i + 1 %></th>
                            <td><%= check.getX() %></td>
                            <td><%= check.getY() %></td>
                            <td><%= check.getR() %></td>
                            <td><%= check.getResult() %></td>
                        </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </table>
                    <a href="<%= request.getContextPath() %>/index?clearSession=true" class="btn btn-primary">Очистить сессию</a>
                </div>
            </div>
        </div>
    </div>

    <% } %>
</div>
<script src="<%= request.getContextPath() %>/js/main.js"></script>
<script src="<%= request.getContextPath() %>/webjars/jquery/3.3.1-1/jquery.min.js"></script>
<script src="<%= request.getContextPath() %>/webjars/bootstrap/4.1.3/js/bootstrap.min.js"></script>
</body>
</html>
