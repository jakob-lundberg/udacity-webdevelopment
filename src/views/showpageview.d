import arsd.cgi;
import views.view;
import models.wikipagemodel;

class ShowPageView:View{
    protected: 
    string _postIndex;
    public:
    this(Cgi cgi, string postIndex=""){
        _cgi = cgi;
        _postIndex = postIndex;
    }
    void display(WikiPage wikiPage){
        _template = "WikiPage";
        auto _context = new Mustache.Context;
        _context["title"] = "My Wiki";
        _context["page_name"] = wikiPage.pageName;
        _context["content"] = wikiPage.content;
        render(_context);
    } 
}
