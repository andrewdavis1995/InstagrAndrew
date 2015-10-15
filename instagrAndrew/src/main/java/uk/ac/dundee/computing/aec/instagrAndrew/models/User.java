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
import java.util.Set;
import java.util.TreeSet;
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
    
    public Validation checkDetails(String fName, String surname, String email, String username, String password, String confPassword){
        
        //check first name:
        
        
            //  -   not blank
            if (fName.equals("")){ 
                Validation v = new Validation("Please a valid First Name", false); 
                return v;
            }
            //  -   no illegal characters -->     `¬!"£$%^&*()_-+='~#/?>,<|\
            if (fName.contains("`¬!\"£$%^&*()_-+='~#/?>,<|\\)")){ 
                Validation v = new Validation("Please a valid First Name - only standard characters are permitted", false); 
                return v;
            }
        
        //check surname
            //  -   not blank
            if (surname.equals("")){ 
                Validation v = new Validation("Please a valid Surname", false); 
                return v;
            }
            //  -   no illegal characters -->     `¬!"£$%^&*()_-+='~#/?>,<|\
            if (surname.contains("`¬!\"£$%^&*()_-+='~#/?>,<|\\)")){ 
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
    
    public UserDetails getProfileInfo(String user){
        UserDetails ud = null;
        
        Session session = cluster.connect("instagrAndrew");
        System.out.println("USER = " + user);
        PreparedStatement ps = session.prepare("select first_name,last_name,email from userprofiles WHERE login = ?");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        user));
        if (!rs.isExhausted()){
            
            for (Row row : rs) {
               String FN = row.getString("first_name");
               String SN = row.getString("last_name");
               Set<String> email = row.getSet("email", String.class);
               String banana = email.toString();
               
               System.out.println(FN + " " + SN + " ----> " + banana);
               
               ud = new UserDetails(FN, SN, email);
               
               break;
            }
        }
        
        return ud;
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
        
        session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        username, em, fName, surname, EncodedPassword));
        //We are assuming this always works.  Also a transaction would be good here !
        
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

    public ArrayList<String> getMatchingUsers(String name){
        ArrayList<String> profileList = new ArrayList<String>();
                
        Session session = cluster.connect("instagrAndrew");
        PreparedStatement ps = session.prepare("select login from userprofiles LIMIT 2000");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute(boundStatement);
        if (rs.isExhausted()) {
            System.out.println("No Images returned");
            return new ArrayList<String>();
        } else {
            for (Row row : rs) {
               
                String username = row.getString("login");
                if (username.toLowerCase().contains(name.toLowerCase())){
                    profileList.add(username);
                }
                    
            }
        }
        
        
        return profileList;
    }
       
}
