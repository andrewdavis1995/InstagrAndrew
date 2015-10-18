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
        PreparedStatement ps = session.prepare("select image_id,content,username,date from comments");
       
        BoundStatement boundStatement = new BoundStatement(ps);
        
        ResultSet rs = null;
        
        rs = session.execute( // this is where the query is executed
                boundStatement.bind());
        if (rs.isExhausted()) {
            System.out.println("No Images returned");
            return null;
        } else {
            for (Row row : rs) {
                java.util.UUID currentID = row.getUUID("image_id");
                String name = row.getString("username");
                String words = row.getString("content");
                
                if(id.equals(currentID)){
                    CommentModel cm = new CommentModel(words, name);
                    comments.add(cm);
                }
            }
        }
        
        return comments;
        
    }
    
    
    public boolean insertComment(UUID imageID, String username, String content){
        
        //http://alvinalexander.com/java/java-timestamp-example-current-time-now
        // 1) create a java calendar instance
        Calendar calendar = Calendar.getInstance();

        // 2) get a java.util.Date from the calendar instance.
        //    this date will represent the current instant, or "now".
        java.util.Date now = calendar.getTime();
        
        Timestamp time = new Timestamp(now.getTime());
        
        Convertors convertor = new Convertors();
        java.util.UUID commentID = convertor.getTimeUUID();
        
        Session session = cluster.connect("instagrAndrew");
        PreparedStatement ps = session.prepare("insert into comments (image_id, username, content, comment_id, date) Values(?,?,?,?,?)");
       
        BoundStatement boundStatement = new BoundStatement(ps);
        
        session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        imageID, username, content, commentID, time));
        //We are assuming this always works.  Also a transaction would be good here !
        
        return true;
    }
    
    public void setCluster(Cluster cluster) {
        this.cluster = cluster;
    }
   
}
