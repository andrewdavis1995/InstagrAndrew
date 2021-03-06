package uk.ac.dundee.computing.aec.instagrAndrew.models;

/*
 * Expects a cassandra columnfamily defined as
 * use keyspace2;
 CREATE TABLE Tweets (
 user varchar,
 interaction_time timeuuid,
 tweet varchar,
 PRIMARY KEY (user,interaction_time)
 ) WITH CLUSTERING ORDER BY (interaction_time DESC);
 * To manually generate a UUID use:
 * http://www.famkruithof.net/uuid/uuidgen
 */
import com.datastax.driver.core.BoundStatement;
import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.PreparedStatement;
import com.datastax.driver.core.ResultSet;
import com.datastax.driver.core.Row;
import com.datastax.driver.core.Session;
import com.datastax.driver.core.utils.Bytes;
import static com.oracle.jrockit.jfr.ContentType.Timestamp;
import com.sun.corba.se.spi.presentation.rmi.StubAdapter;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;
import java.awt.Image;
import java.awt.Graphics;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.awt.image.RescaleOp;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.ByteBuffer;
import java.util.Date;
import java.util.LinkedList;
import javax.imageio.ImageIO;
import static org.imgscalr.Scalr.*;
import java.awt.Color;
import org.imgscalr.Scalr.Method;
import java.net.URL;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;
import java.util.UUID;

import uk.ac.dundee.computing.aec.instagrAndrew.lib.*;
import uk.ac.dundee.computing.aec.instagrAndrew.stores.Pic;
//import uk.ac.dundee.computing.aec.stores.TweetStore;

public class PicModel {

    Cluster cluster;
    float tintValue;
    float greyValue;
    float contrastValue;
    Rotation flipValue;
    Rotation rotateValue;
    //boolean vignetteOnOff;
    

    public void PicModel() {
    }

    public void setCluster(Cluster cluster) {
        this.cluster = cluster;
    }
    
    public void setTint(String t){
        
        switch (t) {
            case "Red":
                this.tintValue = 0f;
                break;
            case "Blue":
                this.tintValue = 0.56f;
                break;
            case "Yellow":
                this.tintValue = 0.16f;
                break;
            case "Green":
                this.tintValue = 0.33f;
                break;
            default:
                this.tintValue = -1;
                break;
        }
        
    }
    
    public void setGrey(String g){
        if(g.equals("Yes")){
            this.greyValue = 0f;
        }else{
            this.greyValue = -1;
        }
    }
    
    //public void setVignette(String v){
    //    this.vignetteOnOff = !v.equals("On");
    //}
    
    public void setContrast(String c){
        switch (c) {
            case "0":
                this.contrastValue = -0.45f;
                break;
            case "1":
                this.contrastValue = -0.3f;
                break;
            case "2":
                this.contrastValue = -0.15f;
                break;
            case "3":
                this.contrastValue = 0f;
                break;
            case "4":
                this.contrastValue = 0.15f;
                break;
            case "5":
                this.contrastValue = 0.3f;
                break;
            case "6":
                this.contrastValue = 0.45f;
                break;
            default:
                this.contrastValue = 0f;
                break;
        }
    }
    
     public void setRotate(String r){
        switch (r) {
            case "None":
                this.rotateValue = null;
                break;
            case "90CW":
                this.rotateValue = Rotation.CW_90;
                break;
            case "180":
                this.rotateValue = Rotation.CW_180;
                break;            
            default:
                this.rotateValue = Rotation.CW_270;
                break;
        }
    }  
     
     public void setFlip(String f){
        switch (f) {
            case "None":
                this.flipValue = null;
                break;
            case "HorizontalFlip":
                this.flipValue = Rotation.FLIP_HORZ;
                break;            
            default:
                this.flipValue = Rotation.FLIP_VERT;
                break;
        }
    }  
    

    public void insertPic(byte[] b, String type, String name, String user, String h, boolean profilePic) {
             
        
        try {
            Convertors convertor = new Convertors();

            String types[]=Convertors.SplitFiletype(type);
            ByteBuffer buffer = ByteBuffer.wrap(b);
            int length = b.length;
            java.util.UUID picid = convertor.getTimeUUID();
            
            //The following is a quick and dirty way of doing this, will fill the disk quickly !
            Boolean success = (new File("/var/tmp/instagrAndrew/")).mkdirs();
            FileOutputStream output = new FileOutputStream(new File("/var/tmp/instagrAndrew/" + picid));

            output.write(b);
            byte []  thumb = picresize(picid.toString(),types[1], profilePic);
            int thumblength= thumb.length;
            ByteBuffer thumbbuf=ByteBuffer.wrap(thumb);
            byte[] processedb = picdecolour(picid.toString(),types[1], profilePic);
            ByteBuffer processedbuf=ByteBuffer.wrap(processedb);
            int processedlength=processedb.length;
            Session session = cluster.connect("instagrAndrew");

            Date DateAdded = new Date();
            
            PreparedStatement psInsertPic = session.prepare("insert into pics ( picid, hashtag, image,thumb,processed, user, interaction_time,imagelength,thumblength,processedlength,type,name) values(?,?,?,?,?,?,?,?,?,?,?,?)");
            BoundStatement bsInsertPic = new BoundStatement(psInsertPic);
            session.execute(bsInsertPic.bind(picid, h, buffer, thumbbuf,processedbuf, user, DateAdded, length,thumblength,processedlength, type, name));
                        
            if(!profilePic){
                PreparedStatement psInsertPicToUser = session.prepare("insert into userpiclist ( picid, hashtag, user, pic_added ) values(?,?,?,?)");
                BoundStatement bsInsertPicToUser = new BoundStatement(psInsertPicToUser);
                session.execute(bsInsertPicToUser.bind(picid, h, user, DateAdded));
            }else{
                PreparedStatement psInsertProfPicToUser = session.prepare("update userprofiles set profilepic = ? where login = ?");
                BoundStatement bsInsertProfPicToUser = new BoundStatement(psInsertProfPicToUser);
                session.execute(bsInsertProfPicToUser.bind(picid, user));
            }
            session.close();
            
            

        } catch (IOException ex) {
            System.out.println("Error --> " + ex);
        }
    }
    

    public byte[] picresize(String picid,String type, boolean profPic) {
        try {
            BufferedImage BI = ImageIO.read(new File("/var/tmp/instagrAndrew/" + picid));
            BufferedImage thumbnail = doTints(BI, this.tintValue, this.greyValue, true, profPic);
                                    
            if(this.contrastValue != 0f){
                thumbnail = doContrast(thumbnail, this.contrastValue);
            }
            
            
            if(this.rotateValue != null){
                thumbnail = rotate(thumbnail, rotateValue, null);
            }
            if(this.flipValue != null){
                thumbnail = rotate(thumbnail, flipValue, null);
            }
            
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            ImageIO.write(thumbnail, type, baos);
            baos.flush();
            
            byte[] imageInByte = baos.toByteArray();
            baos.close();
            return imageInByte;
        } catch (IOException et) {

        }
        return null;
    }
    
    public byte[] picdecolour(String picid,String type, boolean profPic) {
        try {
            BufferedImage BI = ImageIO.read(new File("/var/tmp/instagrAndrew/" + picid));
            BufferedImage processed = doTints(BI, this.tintValue, this.greyValue, false, profPic);
            
            
            if(this.contrastValue != 0f){
                processed = doContrast(processed, this.contrastValue);
            }
            
            
            if(this.rotateValue != null){
                processed = rotate(processed, rotateValue, null);
            }
            if(this.flipValue != null){
                processed = rotate(processed, flipValue, null);
            }
            
            
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            ImageIO.write(processed, type, baos);
            baos.flush();
            byte[] imageInByte = baos.toByteArray();
            baos.close();
            return imageInByte;
        } catch (IOException et) {

        }
        return null;
    }

    //public static BufferedImage createThumbnail(BufferedImage img) {
        //img = resize(img, Method.SPEED, 250, OP_ANTIALIAS, OP_GRAYSCALE);
        // Let's add a little border before we return result.
        //return pad(img, 2);
    //}
    
    public static BufferedImage doContrast(BufferedImage img, float f){
        float brightenFactor = 1+f;
        
        RescaleOp op = new RescaleOp(brightenFactor, 0, null);
        img = op.filter(img, img);
        
        return img;
        
    }
    
    
    
    
    
    
    public static BufferedImage doTints(BufferedImage img, float tint, float grey, boolean thumb, boolean profPic){
        
        int WIDTH = img.getWidth();
        int HEIGHT = img.getHeight();
       
        for (int x = 0; x < WIDTH; ++x){
            for (int y = 0; y < HEIGHT; ++y)
            {
                Color c = new Color(img.getRGB(x, y));
                int red = c.getRed();
                int green = c.getGreen();
                int blue = c.getBlue();
               
                float[] hsb = new float[3];
                c.RGBtoHSB(red, green, blue, hsb);
                
                if(tint != -1){
                    hsb[0] = tint;            // change this to change the tint
                }
                
                if(grey != -1){
                    hsb[1] = grey;         // change this to change the greyscale
                }
                int rgb;
                
                rgb = c.HSBtoRGB(hsb[0], hsb[1], hsb[2]);
                
                img.setRGB(x, y, rgb);
                
            }
        }
        
        
        if(thumb){
            img = resize(img, Method.SPEED, 250, null, null);
            return pad(img, 1);
        }else{
            if(profPic){
                img = resize(img, 200, null);
            return pad(img, 1);
            }else{
                return pad(img, 4);
            }
        }
        
        
        
    }
    
    
    //public static BufferedImage createProcessed(BufferedImage img) {
        //int Width=img.getWidth()-1;
        //img = resize(img, Method.SPEED, Width, OP_ANTIALIAS, OP_GRAYSCALE);
        //return pad(img, 4);    
    //}
    
    
    
    
    public java.util.LinkedList<Pic> getPicsForUser(String User) {
        java.util.LinkedList<Pic> Pics = new java.util.LinkedList<>();
        Session session = cluster.connect("instagrAndrew");
        PreparedStatement ps = session.prepare("select picid, hashtag, pic_added from userpiclist where user =?");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        User));
        if (rs.isExhausted()) {
            System.out.println("No Images returned");
            return null;
        } else {
            for (Row row : rs) {
                Pic pic = new Pic();
                java.util.UUID UUID = row.getUUID("picid");
                
                Date d = row.getDate("pic_added");
                java.sql.Timestamp tmp = new java.sql.Timestamp(d.getTime());
                
                
                
                pic.setUUID(UUID);
                pic.setDate(tmp);
                
                String ht = row.getString("hashtag");
                if(ht != null){
                    pic.setHashtag(ht);
                }
                Pics.add(pic);

            }
        }
        return Pics;
    }
    
    
    public UUID getProfilePic(String User) {
        Session session = cluster.connect("instagrAndrew");
        PreparedStatement ps = session.prepare("select profilepic from userprofiles where login =?");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        User));
        if (rs.isExhausted()) {
            System.out.println("No Images returned");
            return null;
        } else {
            for (Row row : rs) {
                java.util.UUID UUID = row.getUUID("profilepic");
                return UUID;       
            }
        
            return null;
        
        }
    }
    

    public Pic getPic(int image_type, java.util.UUID picid) {
        Session session = cluster.connect("instagrAndrew");
        ByteBuffer bImage = null;
        String type = null;
        int length = 0;
        String date = "";
        try {
            Convertors convertor = new Convertors();
            ResultSet rs = null;
            PreparedStatement ps = null;
         
            if (image_type == Convertors.DISPLAY_IMAGE) {
                ps = session.prepare("select image,imagelength,type,interaction_time from pics where picid =?");
            } else if (image_type == Convertors.DISPLAY_THUMB) {
                ps = session.prepare("select thumb,imagelength,thumblength,type,interaction_time from pics where picid =?");
            } else if (image_type == Convertors.DISPLAY_PROCESSED) {
                ps = session.prepare("select processed,processedlength,type,interaction_time from pics where picid =?");
            }
            BoundStatement boundStatement = new BoundStatement(ps);
            rs = session.execute( // this is where the query is executed
                    boundStatement.bind( // here you are binding the 'boundStatement'
                            picid));

            if (rs.isExhausted()) {
                System.out.println("No Images returned");
                return null;
            } else {
                for (Row row : rs) {
                    if (image_type == Convertors.DISPLAY_IMAGE) {
                        bImage = row.getBytes("image");
                        length = row.getInt("imagelength");
                        //date = row.getString("interaction_time");
                        //hashtag = row.getString("hashtag");
                    } else if (image_type == Convertors.DISPLAY_THUMB) {
                        bImage = row.getBytes("thumb");
                        length = row.getInt("thumblength");
                        //date = row.getString("interaction_time");
                        //hashtag = row.getString("hashtag");
                    } else if (image_type == Convertors.DISPLAY_PROCESSED) {
                        bImage = row.getBytes("processed");
                        length = row.getInt("processedlength");
                        //date = row.getString("interaction_time");
                        //hashtag = row.getString("hashtag");
                    }
                    
                    type = row.getString("type");

                }
            }
        } catch (Exception et) {
            System.out.println("Can't get Pic - " + et);
            return null;
        }
        session.close();
        Pic p = new Pic();
        p.setPic(bImage, length, type, null);

        return p;

    }
    
    
    public java.util.LinkedList<Pic> getMatchingPics(String searched){
        java.util.LinkedList<Pic> picList = new java.util.LinkedList<Pic>();
                
        Session session = cluster.connect("instagrAndrew");
        PreparedStatement ps = session.prepare("select * from userpicList");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute(boundStatement);
        if (rs.isExhausted()) {
            System.out.println("No Images returned");
            return new java.util.LinkedList<Pic>();
        } else {
            for (Row row : rs) {
               
                String fullString = row.getString("hashtag");
                
                
                UUID uuid = row.getUUID("picId");
                String us = row.getString("user");
                Date d = row.getDate("pic_added");
                java.sql.Timestamp tmp = new java.sql.Timestamp(d.getTime());
                
                String[] tags;
                try{
                    tags = fullString.split(",");
                }catch(Exception ex){
                    tags = null;        
                }
                               
                
                
                if(tags!=null){
                    for(int i = 0; i < tags.length; i++){
                        
                        if (tags[i].toLowerCase().equals(searched.toLowerCase())){
                            Pic toAdd = new Pic();
                            toAdd.setUUID(uuid);
                            toAdd.setDate(tmp);
                            toAdd.setUser(us);
                            toAdd.setHashtag(fullString);
                            picList.add(toAdd);
                            break;
                        }
                    }
                }
            }
        }
        
        
        return picList;
    }

    
    
    public void deleteImage(Timestamp date, String username, UUID imageId){
        try {
            
            Session session = cluster.connect("instagrAndrew");

            Date DateAdded = new Date();
            
            PreparedStatement psInsertPic = session.prepare("DELETE FROM userpiclist WHERE user=? AND pic_added=?");
            BoundStatement bsInsertPic = new BoundStatement(psInsertPic);
            session.execute(bsInsertPic.bind(username, date));

            PreparedStatement psInsertPicToUser = session.prepare("DELETE FROM pics WHERE picid=?");
            BoundStatement bsInsertPicToUser = new BoundStatement(psInsertPicToUser);
            session.execute(bsInsertPicToUser.bind(imageId));
            
            session.close();

        } catch (Exception ex) {
            System.out.println("Error: " + ex);
        }
    }
    
}
