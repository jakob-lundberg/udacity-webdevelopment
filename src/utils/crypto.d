import arsd.sha;
import std.random;
import std.ascii;
import std.array;
import std.stdio;

string HashString(string inputString){
    return hashToString(SHA256(inputString));
}

string MakeSalt(){
    string salt = "";
    for (int i; i < 5; i++){
        auto randomLetter = uniform(1,26*2);
        salt ~= letters[randomLetter];
    } 
    return salt;
}

string CreateUserHash(string username, string password, string salt = ""){
    if (salt == ""){
        salt = MakeSalt();
    }
    auto hash = HashString(username~password~salt);
    return hash~","~salt;
}

string HashCookie(string text){
    string secret = "ieHaiy3ahm8quohkei6j";
    return HashString(secret~text);
}

string ValidateCookie(string cookie){
    if (cookie == "")
        return null;
    auto cookieParts = cookie.split("|");
    if (cookieParts[1] == HashCookie(cookieParts[0])){
        return cookieParts[0];
    }
    return null;
}

bool VerifyPasswordToHash(string username, string password, string userHash){
    auto hashParts = std.array.split(userHash,",");
    if (userHash == CreateUserHash(username, password, hashParts[1])){
        return true;
    }
    return false;
}
