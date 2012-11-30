import models.model;

class BlogPost:Model{
    public:
        string _subject;
        string _content;
        this(){};
        this(string subject, string content){
            _subject = subject;
            _content = content;
        }
        auto put() {
            auto db = new arsd.postgres.PostgreSql("dbname = myblog");
            db.query("INSERT INTO blog_posts (subject, content) values (?, ?)", _subject, _content);
            auto id = db.query("SELECT last_value FROM blog_posts_id_seq;");
            return id.front()[0];

        }

        BlogPost[] GetPosts(string postIndex){
            BlogPost[] blogPosts;
            auto db = new arsd.postgres.PostgreSql("dbname = myblog");
            string queryString;
            if (postIndex == ""){
                queryString = "SELECT * FROM blog_posts ORDER BY created DESC";
            } else {
                queryString = "SELECT * FROM blog_posts WHERE id = "
                    ~postIndex~" ORDER BY created DESC";
            }
            foreach(line; db.query(queryString)){
                blogPosts ~= new BlogPost(
                        line["subject"],
                        line["content"]);
            }
            return blogPosts;
        }
}

