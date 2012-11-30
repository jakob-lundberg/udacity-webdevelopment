import arsd.cgi;
import views.view;
class LoginView : View{
    public:
    this(Cgi cgi){
        _cgi = cgi;
    }
    void display(
            string username = "", 
            string usernameError = "", 
            string passwordError = ""){
        _template = "login";
        auto _context = new Mustache.Context;
        _context["username"] = username;
        _context["usernameError"] = usernameError;
        _context["passwordError"] = passwordError;
        render(_context);
    } 
    private: 
}
