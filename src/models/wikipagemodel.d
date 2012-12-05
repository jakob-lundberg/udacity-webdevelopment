import models.model;

class WikiPage:Model{
    public:
        string pageName;
        string content;
        this(){};
        this(string oldPageName){
            auto db = OpenDb("mywiki");
            if (!db){
                return;
            }
            string queryString;
            queryString = "SELECT * FROM wiki_pages WHERE page_name = '"
                ~oldPageName~"'";
            foreach(line; db.query(queryString)){
                pageName = oldPageName;
                content = line["content"];
            }
        }
        this(string newPageName, string newContent){
            pageName = newPageName;
            content = newContent;
        }

        auto put() {
            // Update or Insert
            auto db = OpenDb("mywiki");
            auto res = db.query("SELECT id FROM wiki_pages WHERE page_name = '"
                        ~pageName~"';");
            if (res.empty){
                db.query("INSERT INTO wiki_pages (page_name, content)"
                        ~" values (?, ?)", pageName, content);
            } else{
                db.query("UPDATE wiki_pages SET content = '"~content
                        ~"' WHERE page_name = '"~pageName~"';");
            }
            return;

        }

    private:
        string GetContentOfPage(string pageName){
            auto db = OpenDb("mywiki");
            if (!db){
                return "";
            }
            string queryString;
            queryString = "SELECT * FROM wiki_pages WHERE page_name = '"
                ~pageName~"'";
            auto queryResult = db.query(queryString); 
            if (queryResult.empty()){
                return "";
            }
            return queryResult.front()["content"];
        }
}

