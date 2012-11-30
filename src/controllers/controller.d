import arsd.cgi;
class Controller{
    public:
    this (Cgi cgi){
        _cgi = cgi;
    }
    void invoke(){}
    protected:
    Cgi _cgi;
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
