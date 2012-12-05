import arsd.postgres;
import std.conv;

class Model{
    protected:
        auto OpenDb(string dbName){
            try{
                auto db = new arsd.postgres.PostgreSql("dbname = "~dbName);
                return db;
            }
            catch (Exception e){
                return null;
            }
        }
}
