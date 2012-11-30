import arsd.cgi;
import controllers.controller;
import views.loginview;
import models.usermodel;
import utils.crypto;
import std.regex;

class LoginController : Controller {
    public:
    this (Cgi cgi){
        _view = new LoginView(cgi);
        super(cgi);
    }
    override void invoke(){
        // Show empty login screen on GET
        if (_cgi.requestMethod == _cgi.RequestMethod.GET){
            _view.display();
            return;
        }

        string username = GetPostData("username");
        string password = GetPostData("password");
        string usernameError;
        string passwordError;

        // Check that valid usernames and passwords have been enterd
        usernameError = validateUsername(username);
        passwordError = validatePassword(password);
        if (usernameError != ""
                || passwordError != ""){
            _view.display(
                    username = username,
                    usernameError = usernameError,
                    passwordError = passwordError);
            return;
        }
        // Validate user and password with user database
        auto user = new User();
        user.GetUserByName(username);
        
        if (user._username == ""){
            _view.display(
                    username = username,
                    usernameError = "Incorrect user or password",
                    passwordError = passwordError);
            return;
        }

        if (VerifyPasswordToHash(username, password, user._passwordHash) == false){
            _view.display(
                    username = username,
                    usernameError = "Incorrect user or password",
                    passwordError = passwordError);
            return;
        }
        // Add userid cookie
        string useridCookie = CreateUserIdCookie(to!string(user._id));
        stderr.writeln(user._id);
        _cgi.setCookie("userid",useridCookie);
        _cgi.setResponseLocation("http://www.lundberg.li/blog/welcome");

        
    }
    private:
        LoginView _view;

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
