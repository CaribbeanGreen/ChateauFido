<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="site-header site-container">
  <div class="brand">
    <div class="logo">🐩</div>
    <div>
      <h1>Château Fido</h1>
      <div class="small muted">Premium dog boarding & care</div>
    </div>
  </div>
  <nav class="nav">
    <a href="<%= request.getContextPath() %>/home">Home</a>
    <a href="<%= request.getContextPath() %>/booking">Book</a>
    <a href="<%= request.getContextPath() %>/myDogs">My Dogs</a>
    <a href="<%= request.getContextPath() %>/profile">Profile</a>
    <a href="<%= request.getContextPath() %>/dashboard">Dashboard</a>
    <a href="<%= request.getContextPath() %>/logout" class="btn-logout">Logout</a>
  </nav>
</div>
