import arsd.cgi;
import std.stdio;
class Controller{
    public:
    this (Cgi cgi){
        _cgi = cgi;
    }
    void invoke(){
        if (_cgi.requestMethod == _cgi.RequestMethod.GET){
            writeln("Get");
            InvokeGet();
            return;
        }else if (_cgi.requestMethod == _cgi.RequestMethod.POST){
            writeln("Post");
            InvokePost();
            return;
        }
    }
    protected:
    Cgi _cgi;
    void InvokeGet(){}
    void InvokePost(){}
    string GetPostData(string value){
        auto hasData = (value in _cgi.post);
        if (hasData != null)
        {
            return _cgi.post[value];
        } else {
            return "";
        }
    }
}
