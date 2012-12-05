import arsd.cgi;
import controllers.wikicontroller;
import views.editpageview;
import models.wikipagemodel;
import std.stdio;

class EditPageController : WikiController {
    public:
    this (Cgi cgi, string pageName){
        _view = new EditPageView(cgi);
        super(cgi);
        _pageName = pageName;
    }

    override void InvokeGet(){
        SendToLogin();
        auto wikiPage = new WikiPage(_pageName);
        _view.display(_pageName,wikiPage.content);
        return;
    }
    override void InvokePost(){
        SendToLogin();
        _pageName = GetPostData("pageName");
        _content = GetPostData("content");
        ValidateInput();
        writeln("put to db:"~_content);

        auto newWikiPage = new WikiPage(_pageName, _content);
        newWikiPage.put();
        _cgi.setResponseLocation("/"~_pageName);

    }

    private:
    EditPageView _view;
    string _pageName;
    string _content;

    void ValidateInput() {
        if (_content==""){
            string error="Content, please!";
            _view.display(_pageName,_content,error);
            return;
        }
    }
}