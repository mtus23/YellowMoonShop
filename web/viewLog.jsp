<%-- 
    Document   : viewLog
    Created on : Oct 18, 2020, 2:15:41 PM
    Author     : DELL
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Log Page</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <!-- JS, Popper.js, and jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>

    </head>
    <body>
        <nav class="navbar navbar-light" style="background-color: #e3f2fd;">
            <a class="nav-item" href="search.jsp">Search Page</a>
            <a class="nav-item" href="ListAllCakeController">List all Cake</a>
            <a class="nav-item" href="ListLogController">List all Log</a>
            <a class="nav-item" href="ListAllCategoryController">List all Category</a>
            <a class="nav-item my-2" href="LogoutController"><button class="btn btn-primary">Logout</button></a>
        </nav>
        <div class="container mt-5">
            <div class="d-flex justify-content-center row">
            <c:if test="${not empty requestScope.ListAllLogError}">
                <h3 style="color: red;">${requestScope.ListAllLogError}</h3>
            </c:if>
            </div>
            <div class="lign-self-center justify-content-center row">
            <c:if test="${not empty requestScope.ListLog}">
                
                  <c:forEach var="log" items="${requestScope.ListLog}"> 
                        <div class="col-9 justify-content-center m-3 rounded border border-primary">
                                    <strong>
                                        ${requestScope.MapUserName[log.userId]} has updated ${log.productId} - (${requestScope.MapProductName[log.productId]})
                                        <p class="date">${log.date}</p>
                                    </strong>
                        </div>
                    </c:forEach>  
                
            </c:if>
                </div>
        </div>
    </body>
</html>
