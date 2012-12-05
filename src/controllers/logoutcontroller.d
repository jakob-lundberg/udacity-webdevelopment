import controllers.controller;
import arsd.cgi;
class LogoutController : Controller {
    public:
    this (Cgi cgi){
        super(cgi);
    }
    override void invoke(){
        _cgi.clearCookie("userid");
        _cgi.setResponseLocation("/");

    }
    private:
}
