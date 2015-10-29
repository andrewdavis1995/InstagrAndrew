/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package uk.ac.dundee.computing.aec.instagrAndrew.models;

import com.datastax.driver.core.BoundStatement;
import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.PreparedStatement;
import com.datastax.driver.core.ResultSet;
import com.datastax.driver.core.Row;
import com.datastax.driver.core.Session;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.security.NoSuchAlgorithmException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Set;
import java.util.TreeSet;
import java.util.UUID;
import uk.ac.dundee.computing.aec.instagrAndrew.lib.AeSimpleSHA1;
import uk.ac.dundee.computing.aec.instagrAndrew.stores.Pic;

/**
 *
 * @author Administrator
 */
public class User {
    Cluster cluster;
    public User(){
        
    }
    
    public Validation checkDetails(String fName, String surname, String email, String username, String password, String confPassword, boolean update){
        
        //check first name:
        
        
            //  -   not blank
            if (fName.equals("")){ 
                Validation v = new Validation("Please a valid First Name", false); 
                return v;
            }
            //  -   no illegal characters -->     `Â¬!"Â£$%^&*()_-+='~#/?>,<|\
            if (fName.contains("`Â¬!\"Â£$%^&*()_-+='~#/?>,<|\\)")){ 
                Validation v = new Validation("Please a valid First Name - only standard characters are permitted", false); 
                return v;
            }
        
        //check surname
            //  -   not blank
            if (surname.equals("")){ 
                Validation v = new Validation("Please a valid Surname", false); 
                return v;
            }
            //  -   no illegal characters -->     `Â¬!"Â£$%^&*()_-+='~#/?>,<|\
            if (surname.contains("`Â¬!\"Â£$%^&*()_-+='~#/?>,<|\\)")){ 
                Validation v = new Validation("Please a valid Surname - only standard characters are permitted", false); 
                return v;
            }
        
        //check email
            //  -   not blank
            if (email.equals("")){ 
                Validation v = new Validation("Please enter a valid Email address", false); 
                return v;
            }
            //  -   contains '@' and '.'
            if(!((email.contains("@")) && (email.contains(".")))){ 
                Validation v = new Validation("Please enter a valid email address - must contain '.' and '@'", false); 
                return v;
            }
        
            if(!update){
               //check username
                //  -   not blank
                if (username.equals("")){ 
                    Validation v = new Validation("Please enter a valid username", false); 
                    return v;
                }
                //  -   doesn't exist already - select from userprofiles where login = ?
                    //  -   ? = username
                    //  -   if returns 0, username is not taken --> valid
                    //  -   else, invalid
                boolean taken = checkUsername(username);
                if (taken){
                    Validation v = new Validation("Username Exists already. Please choose another", false); 
                    return v;
                }
            }
        
        //check password
            //  -   not blank
            if (password.equals("")){ 
                Validation v = new Validation("Please enter a valid Password", false); 
                return v;
            }
            //  -   compare password to confPassword
                //  -   if not a match, invalid
                if (! password.equals(confPassword)){ 
                Validation v = new Validation("Passwords Entered Do Not Match", false); 
                return v;
            }
        
                
             
            Validation v = new Validation("SUCCESS", true); 
            return v;
            
    }
    
    public boolean checkUsername(String username){
        Session session = cluster.connect("instagrAndrew");
        PreparedStatement ps = session.prepare("select * from userprofiles where login =?");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        username));
        if (rs.isExhausted()) {
            System.out.println("No Such Profile - SUCCESS!!!");
            return false;
        } else {
            System.out.println("Username Exists - FAILED!");
            return true;
        }
    }
    
     public boolean updateDetails(String fName, String surname, String email, String username, String password){
        Session session = cluster.connect("instagrAndrew");
        
        AeSimpleSHA1 sha1handler=  new AeSimpleSHA1();
        String EncodedPassword=null;
        try {
            EncodedPassword= sha1handler.SHA1(password);
        }catch (UnsupportedEncodingException | NoSuchAlgorithmException et){
            System.out.println("Can't check your password");
            return false;
        }        
        
        Set<String> em = new TreeSet<String>();
        em.add(email);    
        
        PreparedStatement ps = session.prepare("UPDATE userprofiles SET first_name=?, last_name=?, email=?, password=? WHERE login=?");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        fName, surname, em, EncodedPassword, username));
        if (rs.isExhausted()) {
            return false;
        } else {
            return true;
        }
    }
    
    
    public UserDetails getProfileInfo(String user, boolean change){
        UserDetails ud = null;
        
        Session session = cluster.connect("instagrAndrew");
        PreparedStatement ps = session.prepare("select * from userprofiles WHERE login = ?");
        ResultSet rs = null;
        try{
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        user));
        }catch(Exception exc){
            System.out.println("Error" + exc.getMessage());
        }
        
        if (rs != null && !rs.isExhausted()){
            
            for (Row row : rs) {
               String FN = row.getString("first_name");
               String SN = row.getString("last_name");
               String usern = row.getString("login");
               UUID PP = row.getUUID("profilepic");
               String password = row.getString("password");
               Set<String> email = row.getSet("email", String.class);
               String banana = email.toString();
               
               if(!change){
                   ud = new UserDetails(usern, FN, SN, PP, email);
               }else{
                   ud = new UserDetails(usern, FN, SN, password, email);
               }
               break;
            }
        }
        
        return ud;
    }
    
    
    public void removeFollow(String userToUnFollow, String currentUser){
        Session session = cluster.connect("instagrAndrew");
        PreparedStatement ps = session.prepare("delete from follows WHERE follower=? AND followee=?");
       
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        currentUser, userToUnFollow));
    }
    
    public void addFollow(String userToFollow, String currentUser){
        Session session = cluster.connect("instagrAndrew");
        PreparedStatement ps = session.prepare("insert into follows (follower, followee) VALUES (?,?)");
       
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        currentUser, userToFollow));
    }
    
    
    
    public ArrayList<String> getFollowers(String user){
        ArrayList<String> followers = new ArrayList<String>();
                
        Session session = cluster.connect("instagrAndrew");
        PreparedStatement ps = session.prepare("select follower from follows WHERE followee = ? ALLOW FILTERING");
        ResultSet rs = null;
        try{
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        user));
        }catch(Exception exc){
            System.out.println("Error" + exc.getMessage());
        }
        
        if (rs != null && !rs.isExhausted()){
            
            for (Row row : rs) {
               String name = row.getString("follower");
               followers.add(name);
            }
        }
        
        return followers;
    }
    
    public ArrayList<String> getFollowees(String user){
        
        ArrayList<String> followees = new ArrayList<String>();
        
        Session session = cluster.connect("instagrAndrew");
        PreparedStatement ps = session.prepare("select followee from follows WHERE follower = ?");
        ResultSet rs = null;
        try{
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        user));
        }catch(Exception exc){
            System.out.println("Error" + exc.getMessage());
        }
        
        if (rs != null && !rs.isExhausted()){
            for (Row row : rs) {
               String name = row.getString("followee");
               followees.add(name);
            }
        }
            
        return followees;
    }
    
    public boolean RegisterUser(String fName, String surname, String email, String username, String Password){
        AeSimpleSHA1 sha1handler=  new AeSimpleSHA1();
        String EncodedPassword=null;
        try {
            EncodedPassword= sha1handler.SHA1(Password);
        }catch (UnsupportedEncodingException | NoSuchAlgorithmException et){
            System.out.println("Can't check your password");
            return false;
        }
        Session session = cluster.connect("instagrAndrew");
        PreparedStatement ps = session.prepare("insert into userprofiles (login, email, first_name, last_name, password) Values(?,?,?,?,?)");
       
        BoundStatement boundStatement = new BoundStatement(ps);
        
        Set<String> em = new TreeSet<String>();
        em.add(email);
        
        try{
            session.execute(
                boundStatement.bind(
                    username, em, fName, surname, EncodedPassword));
        }catch(Exception exc){
            return false;
        }
        
        return true;
    }
    
    public boolean IsValidUser(String username, String Password){
        AeSimpleSHA1 sha1handler = new AeSimpleSHA1();
        String EncodedPassword=null;
        try {
            EncodedPassword= sha1handler.SHA1(Password);
        }catch (UnsupportedEncodingException | NoSuchAlgorithmException et){
            System.out.println("Can't check your password");
            return false;
        }
        Session session = cluster.connect("instagrAndrew");
        PreparedStatement ps = session.prepare("select password from userprofiles where login =?");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        username));
        if (rs.isExhausted()) {
            System.out.println("No Images returned");
            return false;
        } else {
            for (Row row : rs) {
               
                String StoredPass = row.getString("password");
                if (StoredPass.compareTo(EncodedPassword) == 0)
                    return true;
            }
        }
   
    
    return false;  
    }
    
    public void setCluster(Cluster cluster) {
        this.cluster = cluster;
    }

    public ArrayList<UserDetails> getMatchingUsers(String name){
        ArrayList<UserDetails> profileList = new ArrayList<UserDetails>();
                
        Session session = cluster.connect("instagrAndrew");
        PreparedStatement ps = session.prepare("select login,first_name,last_name,profilePic from userprofiles");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute(boundStatement);
        if (rs.isExhausted()) {
            System.out.println("No Images returned");
            return new ArrayList<UserDetails>();
        } else {
            for (Row row : rs) {
               
                String username = row.getString("login");
                
                if (username.toLowerCase().contains(name.toLowerCase())){
                    String firstname = row.getString("first_name");
                    String surname = row.getString("last_name");
                    UUID profPic = row.getUUID("profilePic");
                    
                    UserDetails UD = new UserDetails(username, firstname, surname, profPic);
                    
                    profileList.add(UD);
                }
                    
            }
        }
        
        
        return profileList;
    }
 
    public UUID getProfilePicture(String username){
        UUID toReturn = new UUID(0, 0);
        
        Session session = cluster.connect("instagrAndrew");
        PreparedStatement ps = session.prepare("select profilePic from userprofiles WHERE login=?");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        username));
        if (rs.isExhausted()) {
            System.out.println("No Image found");
            return null;
        } else {
            for (Row row : rs) {
                toReturn = row.getUUID("profilePic");
                break;    
            }
        }
        
        return toReturn;
    }
    
    public ArrayList<Pic> getFeedItems(String user, ArrayList<String> followees){
        ArrayList<Pic> pictures = new ArrayList<Pic>();
        ArrayList<Pic> picturesToReturn = new ArrayList<Pic>();
                
        Session session = cluster.connect("instagrAndrew");
        
        if(followees.size() > 0){
            
            String output = " WHERE user IN(";
        
        
            for(int i = 0; i < followees.size(); i++){
                output += "'" + followees.get(i) + "', ";
            }

            output = output.substring(0, output.length()-2);

            String statement = "select * from userpiclist" + output + ");";

            
            PreparedStatement ps = session.prepare(statement);
            
            ResultSet rs = null;
            BoundStatement boundStatement = new BoundStatement(ps);
            
            rs = session.execute(boundStatement);
            if (rs.isExhausted()) {
                System.out.println("No Images returned");
                return new ArrayList<Pic>();
            } else {
                for (Row row : rs) {
                    
                    
                    String username = row.getString("user");
                    UUID imageID = row.getUUID("picid");
                    Date origDate = row.getDate("pic_added");
                    long time = origDate.getTime();
                    Timestamp date = new Timestamp(time);
                    String hashtag = row.getString("hashtag");
                    
                    Pic p = new Pic();
                    p.setUUID(imageID);
                    p.setHashtag(hashtag);
                    p.setUser(username);
                    p.setDate(date);
                    pictures.add(p);

                }
            }
            
            //sort images by date
            
            while(picturesToReturn.size() < 20 && pictures.size() > 0){
                
                Timestamp currHighest = pictures.get(0).getDate();
                System.out.println("TIMESTAMP: " + currHighest);
                
                int mostRecentIndex = 0;
                for(int i = 1; i < pictures.size(); i++){
                    Timestamp current = pictures.get(i).getDate();
                    if(current.after(currHighest)){
                        currHighest = current;
                        mostRecentIndex = i;
                    }
                }
                
                picturesToReturn.add(pictures.get(mostRecentIndex));
                pictures.remove(mostRecentIndex);
                
            }
            
        }
        return picturesToReturn;
    }
    
}
