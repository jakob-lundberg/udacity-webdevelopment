import arsd.cgi;
import views.view;
class NewPostView : View{
    public:
    this(Cgi cgi){
        _cgi = cgi;
    }
    void display(string subject = "", 
            string content = "", 
            string error = ""){
        _template = "PostForm";
        auto _context = new Mustache.Context;
        _context["subject"] = subject;
        _context["content"] = content;
        _context["error"] = error;
        render(_context);
    } 
    private: 
}
