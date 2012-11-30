import controllers.controller;
import arsd.cgi;
class UnknownController : Controller {
    public:
    this (Cgi cgi){
        super(cgi);
    }
    override void invoke(){
        _cgi.write("404!!!");
    }
}
