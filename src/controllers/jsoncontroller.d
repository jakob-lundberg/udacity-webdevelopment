import arsd.cgi;
import controllers.controller;
import views.jsonview;
import std.json;
import models.postmodel;

class JsonController : Controller {
    public:
    this (Cgi cgi){
        _view = new JsonView(cgi);
        _postIndex = "";
        super(cgi);
    }
    this (Cgi cgi, string post){
        _view = new JsonView(cgi);
        _postIndex = std.array.split(post, ".")[0];
        stderr.writeln("index:",_postIndex);
        super(cgi);
    }
    override void invoke(){


        stderr.writeln("index:",_postIndex);
        BlogPost dummy = new BlogPost();
        BlogPost[] blogPosts;
        blogPosts = dummy.GetPosts(_postIndex);
        JSONValue posts;
        posts.type = JSON_TYPE.ARRAY;
        posts.array.length = blogPosts.length;
        foreach(int index, BlogPost blogPost; blogPosts){
            JSONValue post;
            post.type = JSON_TYPE.OBJECT;
            JSONValue subject;
            subject.str = blogPost._subject;
            subject.type = JSON_TYPE.STRING;
            JSONValue content;
            content.type = JSON_TYPE.STRING;
            content.str = blogPost._content;
            post.object["subject"] = subject;
            post.object["content"] = content;
            posts[index] = post;

        }
        _view.display(posts);

    }
    protected:
        string _postIndex;
        JsonView _view;
}
