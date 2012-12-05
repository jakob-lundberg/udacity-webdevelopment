import arsd.cgi;
import controllers.wikicontroller;
import views.showpageview;
import models.wikipagemodel;

class ShowPageController: WikiController{
    public:
    this (Cgi cgi, string pageName){
        _pageName = pageName;
        _showPageView = new ShowPageView(cgi);
        super(cgi);
    }
    override void invoke(){
        auto wikiPage = new WikiPage(_pageName);
        if (wikiPage.content == ""){
            _cgi.setResponseLocation("/_edit/"
                                     ~_pageName);
            return;
        }
        _showPageView.display(wikiPage);
        
    }
    private:
        ShowPageView _showPageView;
        string _pageName;
}
