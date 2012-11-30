import models.model;
import std.conv;

class User:Model{
    public:
        int _id;
        string _username;
        string _passwordHash;
        string _email;
        this(){};
        this(string username, string passwordHash, string email = ""){
            _username = username;
            _passwordHash = passwordHash;
            _email = email;
        }
        auto put() {
            auto db = new arsd.postgres.PostgreSql("dbname = myblog");
            db.query("INSERT INTO users (username, passwordhash, email) values (?, ?, ?)", _username, _passwordHash, _email);
            auto id = db.query("SELECT last_value FROM users_id_seq;");
            _id = std.conv.to!int(id.front()[0]);
            return _id;

        }

        void GetUserById(string userid){
            auto db = new arsd.postgres.PostgreSql("dbname = myblog");
            string queryString;
                queryString = "SELECT * FROM users WHERE id = "
                    ~userid~" ORDER BY created DESC";
            foreach(line; db.query(queryString)){
                _username = line["username"];
                _passwordHash = line["passwordhash"];
                _email = line["email"];
            }
        }

        void GetUserByName(string username){
            auto db = new arsd.postgres.PostgreSql("dbname = myblog");
            string queryString;
                queryString = "SELECT * FROM users WHERE username = '"
                    ~username~"' ORDER BY created DESC";
            foreach(line; db.query(queryString)){
                _id = to!int(line["id"]);
                _username = line["username"];
                _passwordHash = line["passwordhash"];
                _email = line["email"];
            }
        }
}

