import arsd.cgi;
import controllers.controller;
import utils.crypto;

class WikiController : Controller {
    this (Cgi cgi){
        super(cgi);
    }
    protected:
    string IsLoggedIn(){
        if ("userid" in _cgi.cookies){
            auto useridCookie = _cgi.cookies["userid"];
            auto userid = ValidateCookie(useridCookie);
            return userid;
        }
        return null;
    }
    void SendToLogin(){
        if (IsLoggedIn() == null){
            _cgi.setResponseLocation("/login");
        }
    }
}
