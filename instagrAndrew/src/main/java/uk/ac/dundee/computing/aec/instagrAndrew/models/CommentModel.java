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
import java.util.Calendar;
import java.util.Set;
import java.util.TreeSet;
import java.util.UUID;
import uk.ac.dundee.computing.aec.instagrAndrew.lib.AeSimpleSHA1;
import uk.ac.dundee.computing.aec.instagrAndrew.lib.Convertors;
import uk.ac.dundee.computing.aec.instagrAndrew.stores.Pic;

/**
 *
 * @author Administrator
 */
public class CommentModel {
    Cluster cluster;
    
    String content;
    String username;
    
    public CommentModel(){
        
    }
    
    public void setCluster(Cluster cluster) {
        this.cluster = cluster;
    }
   
    public CommentModel(String c, String u){
        this.content = c;
        this.username = u;
    }
    
    public String getUsername(){
        return this.username;
    }
    
    public String getContent(){
        return this.content;
    }
    
    
    public ArrayList<CommentModel> getComments(UUID id){
        
        //setup arraylist
        ArrayList<CommentModel> comments = new ArrayList<CommentModel>();
                
        Session session = cluster.connect("instagrAndrew");
        //create prepared statement
        PreparedStatement ps = session.prepare("select content,username,date from comments where image_id=? ORDER BY date DESC");
        
        BoundStatement boundStatement = new BoundStatement(ps);
        
        ResultSet rs = null;
        
        //bind the statement and execute
        rs = session.execute( // this is where the query is executed
                boundStatement.bind(id));
        if (rs.isExhausted()) {
            System.out.println("No Images returned");
            return null;
        } else {
            //for each row, get the username and content and create a CommentModel object (adding it to list)
            for (Row row : rs) {
                String name = row.getString("username");
                String words = row.getString("content");
                //date
                CommentModel cm = new CommentModel(words, name);
                comments.add(cm);                
            }
        }
        
        return comments;
    }
    
    
    public boolean insertComment(UUID imageID, String username, String content){
        
        //get the current time/date. Derived from:         
        //http://alvinalexander.com/java/java-timestamp-example-current-time-now
        Calendar calendar = Calendar.getInstance();
        java.util.Date now = calendar.getTime();
        java.sql.Timestamp time = new java.sql.Timestamp(now.getTime());
              
        //create prepared statement
        Session session = cluster.connect("instagrAndrew");
        PreparedStatement ps = session.prepare("insert into comments (image_id, username, content, date) Values (?,?,?,?)");
               
        BoundStatement boundStatement = new BoundStatement(ps);
        
        //bind the statement and execute
        try{
            session.execute( 
                boundStatement.bind(
                        imageID, username, content, time));
        }catch(Exception exc){
            return false;
        }
                
        return true;
    }
    
    
    
    public ArrayList<String> getLikes(UUID id){
        //create arrayList
        ArrayList<String> likers = new ArrayList<String>();
        
        //create bound statement
        Session session = cluster.connect("instagrAndrew");
        PreparedStatement ps = session.prepare("select liker from likes where image_id =? order by liker ASC");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        
        //bind the statement and execute
        rs = session.execute( 
                boundStatement.bind( 
                        id));
        //if no results, return null
        if (rs.isExhausted()) {
            return null;
        } else {
            
            //otherwise, loop through all items and add to list
            for (Row row : rs) {
                String name = row.getString("liker");
                likers.add(name);
            }
        }
        
        return likers;
    }
    
    
    public void deleteLike(String user, UUID image){
        
        //create prepared statement
        Session session = cluster.connect("instagrAndrew");
        PreparedStatement ps = session.prepare("delete from likes WHERE liker=? AND image_id=?");
       
        //execute bound statement
        BoundStatement boundStatement = new BoundStatement(ps);
        session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        user, image));
    }
    
    public void insertLike(String user, UUID image){
        Session session = cluster.connect("instagrAndrew");
        PreparedStatement ps = session.prepare("insert into likes (image_id, liker) VALUES (?,?)");
       
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        image, user));
    }
    
}
