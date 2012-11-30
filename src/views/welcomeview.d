import arsd.cgi;
import views.view;
import models.postmodel;

class WelcomeView:View{
    protected: 
    public:
    this(Cgi cgi){
        _cgi = cgi;
    }
    void display(string username){
        _template = "welcome";
        auto _context = new Mustache.Context;
        _context["username"] = username;
        render(_context);
    } 
}

