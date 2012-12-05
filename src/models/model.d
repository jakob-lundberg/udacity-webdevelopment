import arsd.postgres;
import std.conv;
import std.stdio;

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
