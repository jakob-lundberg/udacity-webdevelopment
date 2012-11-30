import arsd.cgi;
import views.view;
class SignupView : View{
    public:
    this(Cgi cgi){
        _cgi = cgi;
    }
    void display(
            string username = "", 
            string usernameError = "", 
            string passwordError = "", 
            string passwordMatchError = "", 
            string email = "", 
            string emailError = ""){
        _template = "Signup";
        auto _context = new Mustache.Context;
        _context["username"] = username;
        _context["usernameError"] = usernameError;
        _context["passwordError"] = passwordError;
        _context["passwordMatchError"] = passwordMatchError;
        _context["email"] = email;
        _context["emailError"] = emailError;
        render(_context);
    } 
    private: 
}
