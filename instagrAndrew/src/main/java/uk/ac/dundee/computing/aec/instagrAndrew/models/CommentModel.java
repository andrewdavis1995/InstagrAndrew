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
        
        ArrayList<CommentModel> comments = new ArrayList<CommentModel>();
        
        
        Session session = cluster.connect("instagrAndrew");
        PreparedStatement ps = session.prepare("select content,username,date from comments where image_id=? ORDER BY date DESC");
       
        BoundStatement boundStatement = new BoundStatement(ps);
        
        ResultSet rs = null;
        
        rs = session.execute( // this is where the query is executed
                boundStatement.bind(id));
        if (rs.isExhausted()) {
            System.out.println("No Images returned");
            return null;
        } else {
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
        
        System.out.println("THERE");
        
        //http://alvinalexander.com/java/java-timestamp-example-current-time-now
        Calendar calendar = Calendar.getInstance();
        java.util.Date now = calendar.getTime();
        java.sql.Timestamp time = new java.sql.Timestamp(now.getTime());
        
        
        System.out.println("THING");
        
        Session session = cluster.connect("instagrAndrew");
        PreparedStatement ps = session.prepare("insert into comments (image_id, username, content, date) Values (?,?,?,?)");
       
        
        System.out.println("SGFDAD");
        
        BoundStatement boundStatement = new BoundStatement(ps);
        
        try{
            session.execute( 
                boundStatement.bind(
                        imageID, username, content, time));
        }catch(Exception exc){
            return false;
        }
        
        
        System.out.println("gthyjkl");
        
        return true;
    }
    
    public void setCluster(Cluster cluster) {
        this.cluster = cluster;
    }
   
    
    public ArrayList<String> getLikes(UUID id){
        ArrayList<String> likers = new ArrayList<String>();
        
        Session session = cluster.connect("instagrAndrew");
        PreparedStatement ps = session.prepare("select liker from likes where image_id =? order by liker ASC");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        id));
        if (rs.isExhausted()) {
            System.out.println("NO LIKES");
            return null;
        } else {
            for (Row row : rs) {
                String name = row.getString("liker");
                likers.add(name);
            }
        }
        
        return likers;
    }
    
    public void deleteLike(String user, UUID image){
        Session session = cluster.connect("instagrAndrew");
        PreparedStatement ps = session.prepare("delete from likes WHERE liker=? AND image_id=?");
       
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
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
