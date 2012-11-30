import arsd.cgi;
import controllers.controller;
import views.welcomeview;
import models.usermodel;
import utils.crypto;

class WelcomeController : Controller {
    public:
    this (Cgi cgi){
        _view = new WelcomeView(cgi);
        super(cgi);
    }
    override void invoke(){
        if ("userid" in _cgi.cookies){
            auto useridCookie = _cgi.cookies["userid"];
            auto userid = ValidateCookie(useridCookie);
            if (userid != null){
                auto user = new User();
                user.GetUserById(userid);
                _view.display(user._username);
            }
        }
        _cgi.setResponseLocation("http://www.lundberg.li/blog/signup");

    }
    private:
        WelcomeView _view;
}

