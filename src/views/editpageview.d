import arsd.cgi;
import views.view;
class EditPageView : View{
    public:
    this(Cgi cgi){
        _cgi = cgi;
    }
    void display(string pageName = "", 
            string content = "", 
            string error = ""){
        _template = "EditPage";
        auto _context = new Mustache.Context;
        _context["pageName"] = pageName;
        _context["content"] = content;
        _context["error"] = error;
        render(_context);
    } 
    private: 
}
