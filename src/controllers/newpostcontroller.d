import arsd.cgi;
import controllers.controller;
import views.newpostview;
import models.postmodel;

class NewPostController : Controller {
    public:
    this (Cgi cgi){
        _view = new NewPostView(cgi);
        super(cgi);
    }
    override void invoke(){
        if (_cgi.requestMethod == _cgi.RequestMethod.GET){
            _view.display();
            return;
        }
        string subject = GetPostData("subject");
        string content = GetPostData("content");
        if (subject==""
                || content==""){
            string error="subject and content, please!";
            _view.display(subject,content,error);
            return;
        }

        auto newPost = new BlogPost(subject, content);
        string id_index = newPost.put();
        _cgi.setResponseLocation("http://www.lundberg.li/blog/"~id_index);

    }
    private:
        NewPostView _view;
}
