import std.regex;
import std.array;
import arsd.cgi;
import controllers.controller;
import controllers.editpagecontroller;
import controllers.showpagecontroller;
import controllers.signupcontroller;
import controllers.logincontroller;
import controllers.logoutcontroller;
import controllers.unknowncontroller;

void router(Cgi cgi)
{
    Controller controller;
    auto path = cgi.pathInfo;
    auto urlArray = std.array.split(path, "/");
    string PAGE_RE = "(/(?:[a-zA-Z0-9_-]+/?)*)";
    if (match(path, regex("^/signup[/]?$"))){
        controller = new SignupController(cgi);
    } else if (match(path, regex("^/login[/]?$"))){
        controller = new LoginController(cgi);
    } else if (match(path, regex("^/logout[/]?$"))){
        controller = new LogoutController(cgi);
    } else if (auto regMatch = match(path, regex("^/_edit"~PAGE_RE~"[/]?$"))){
        controller = new EditPageController(cgi,urlArray[2]);
    } else if (auto regMatch = match(path, regex("^"~PAGE_RE~"[/]?$"))){
        controller = new ShowPageController(cgi,urlArray[1]);
    } else {
        controller = new UnknownController(cgi);
    } 
    controller.invoke();
}


mixin GenericMain!router;
