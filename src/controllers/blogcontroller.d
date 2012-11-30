import arsd.cgi;
import controllers.controller;
import views.blogfrontview;

class BlogController : Controller {
    public:
    this (Cgi cgi){
        _blogFrontView = new BlogFrontView(cgi);
        super(cgi);
    }
    this (Cgi cgi, string post){
        _blogFrontView = new BlogFrontView(cgi,post);
        super(cgi);
    }
    override void invoke(){
        _blogFrontView.display();
        
    }
    private:
        BlogFrontView _blogFrontView;
}
