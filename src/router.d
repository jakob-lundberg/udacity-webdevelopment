import std.regex;
import std.array;
import arsd.cgi;
import controllers.controller;
import controllers.blogcontroller;
import controllers.newpostcontroller;
import controllers.signupcontroller;
import controllers.welcomecontroller;
import controllers.logincontroller;
import controllers.logoutcontroller;
import controllers.unknowncontroller;
import controllers.jsoncontroller;

void router(Cgi cgi)
{
    Controller controller;
    auto path = cgi.pathInfo;
    auto urlArray = std.array.split(path, "/");
    if (match(path, regex("^/blog/[0-9]+[/]?$"))){
        controller = new BlogController(cgi,urlArray[2]);
    } else if (match(path, regex("^[/]?$"))){
        controller = new BlogController(cgi);
    } else if (match(path, regex("^/blog[/]?$"))){
        controller = new BlogController(cgi);
    } else if (match(path, regex("^/blog/\\.json[/]?$"))){
        controller = new JsonController(cgi);
    } else if (match(path, regex("^/blog/[0-9]+\\.json[/]?$"))){
        controller = new JsonController(cgi,urlArray[2]);
    } else if (match(path, regex("^/blog/newpost[/]?$"))){
        controller = new NewPostController(cgi);
    } else if (match(path, regex("^/blog/signup[/]?$"))){
        controller = new SignupController(cgi);
    } else if (match(path, regex("^/blog/welcome[/]?$"))){
        controller = new WelcomeController(cgi);
    } else if (match(path, regex("^/blog/login[/]?$"))){
        controller = new LoginController(cgi);
    } else if (match(path, regex("^/blog/logout[/]?$"))){
        controller = new LogoutController(cgi);
    } else {
        controller = new UnknownController(cgi);
    } 
    controller.invoke();
}


mixin GenericMain!router;
