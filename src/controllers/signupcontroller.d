import arsd.cgi;
import controllers.controller;
import views.signupview;
import models.usermodel;
import utils.crypto;
import std.regex;

class SignupController : Controller {
    public:
    this (Cgi cgi){
        _signupView = new SignupView(cgi);
        super(cgi);
    }
    override void invoke(){
        string username = GetPostData("username");
        string password = GetPostData("password");
        string verify = GetPostData("verify");
        string email = GetPostData("email");
        string usernameError;
        string passwordError;
        string passwordMatchError;
        string emailError;

        if (_cgi.requestMethod == _cgi.RequestMethod.POST){
            usernameError = validateUsername(username);
            passwordError = validatePassword(password);
            passwordMatchError = verifyPassword(password,verify);
            emailError = validateEmail(email);

            if (usernameError == ""
                    && passwordError == ""
                    && passwordMatchError == ""
                    && emailError == ""){
                // Create user
                int userid = CreateUser(username, password, email);
                // Add userid cookie
                string useridCookie = CreateUserIdCookie(to!string(userid));
                _cgi.setCookie("userid",useridCookie);
                _cgi.setResponseLocation("http://www.lundberg.li/blog/welcome");
            }
            _signupView.display(
                    username = username,
                    usernameError = usernameError,
                    passwordError = passwordError,
                    passwordMatchError = passwordMatchError,
                    email = email,
                    emailError = emailError);
        }else{
            _signupView.display();
        }

        
    }
    private:
        SignupView _signupView;

        string GetPostData(string value){
            auto hasData = (value in _cgi.post);
            if (hasData != null)
            {
                return _cgi.post[value];
            } else {
                return "";
            }
        }
        string validateUsername(string text){
            enum re = ctRegex!("^[a-zA-Z0-9_-]{3,20}$");
            auto m = match(text, re);
            if (m){
                return "";
            } else {
                return "That's not a valid username.";

            }
        }
        string validatePassword(string text){
            enum re = ctRegex!("^.{3,20}$");
            auto m = match(text, re);
            if (m){
                return "";
            } else {
                return "That wasn't a valid password.";

            }
        }
        string validateEmail(string text){
            auto re = regex(r"^[\S]+@[\S]+\.[\S]+$");
            auto m = match(text, re);
            if (m || text == ""){
                return "";
            } else {
                return "That's not a valid email.";

            }
        }
        string verifyPassword(string password, string verify){
            if (password == verify){
                return "";
            } else {
                return "Your passwords didn't match.";

            }
        }
        // Create user
        int CreateUser(string username, string password, string email){
            auto userHash = CreateUserHash(username, password);
            auto user = new User(username, userHash, email);
            auto userid = user.put();
            return userid; 
        }
        // Create userid cookie
        string CreateUserIdCookie(string userid){
            string useridHash = HashCookie(userid);
            return userid~"|"~useridHash;
        }
}
