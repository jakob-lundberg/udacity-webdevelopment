import models.model;

class WikiPage:Model{
    public:
        string pageName;
        string content;
        this(){};
        this(string oldPageName){
            pageName = oldPageName;
            GetContentOfPage();
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
        void GetContentOfPage(){
            auto db = OpenDb("mywiki");
            if (!db){
                return ;
            }
            string queryString;
            queryString = "SELECT * FROM wiki_pages WHERE page_name = '"
                ~pageName~"'";
            auto queryResult = db.query(queryString); 

            if (queryResult.length() == 0){
                pageName = null;
                return;
            }
            content = queryResult.front()["content"];
        }
}

