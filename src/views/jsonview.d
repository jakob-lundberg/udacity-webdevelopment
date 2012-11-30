import arsd.cgi;
import std.json;
import views.view;

class JsonView:View{
    protected: 
    string _postIndex;
    public:
    this(Cgi cgi, string postIndex=""){
        _cgi = cgi;
        _postIndex = postIndex;
    }
    void display(JSONValue json){
        string html = toJSON(&json);
        _cgi.setResponseContentType("application/json");
        _cgi.write(html);
    } 
}

