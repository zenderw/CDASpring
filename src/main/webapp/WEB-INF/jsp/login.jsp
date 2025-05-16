<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>
<h2>Login</h2>

<form:form class="form-signin" method="POST" action="login">
    <h2 class="form-signin-heading">Connexion</h2>
    <p>
        <label for="username" class="sr-only">Identifiant</label> <input
            type="text" id="username" name="username" class="form-control"
            placeholder="Username" required autofocus />
    </p>
    <p>
        <label for="password" class="sr-only">Mot de passe</label> <input
            type="password" id="password" name="password" class="form-control"
            placeholder="Password" required />
    </p>

    <button class="btn btn-lg btn-primary btn-block" type="submit">Connexion</button>
</form:form>
</body>
</html>
