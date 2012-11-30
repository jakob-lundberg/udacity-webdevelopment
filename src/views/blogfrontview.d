import arsd.cgi;
import views.view;
import models.postmodel;

class BlogFrontView:View{
    protected: 
    string _postIndex;
    public:
    this(Cgi cgi, string postIndex=""){
        _cgi = cgi;
        _postIndex = postIndex;
    }
    void display(){
        _template = "BlogFront";
        auto _context = new Mustache.Context;
        _context["title"] = "My Blog";
        BlogPost dummy = new BlogPost();
        BlogPost[] blogPosts;
        blogPosts = dummy.GetPosts(_postIndex);
        foreach(int index, BlogPost blogPost; blogPosts){
            auto sub = _context.addSubContext("Blogposts");
            sub["index"] = index;
            sub["subject"] = blogPost._subject;
            sub["content"] = blogPost._content;
        }
        render(_context);
    } 
}
