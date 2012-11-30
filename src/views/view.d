import arsd.cgi;
import utils.mustache;
class View{
    protected:
    string _template;
    Cgi _cgi;
    alias MustacheEngine!(string) Mustache;
    Mustache mustache;
    void render(Mustache.Context _context){
        string html;
        mustache.path = "/var/www/templates";
        mustache.level = Mustache.CacheLevel.no;
        html = mustache.render(_template,_context);
        _cgi.write(html);
    } 
}
