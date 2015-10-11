/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uk.ac.dundee.computing.aec.instagrAndrew.stores;

import com.datastax.driver.core.utils.Bytes;
import java.nio.ByteBuffer;

/**
 *
 * @author Administrator
 */
public class Pic {

    private ByteBuffer bImage = null;
    private int length;
    private String type;
    private java.util.UUID UUID=null;
    //private String date;
    private String hashtag;
    
    public void Pic() {

    }
    public void setUUID(java.util.UUID UUID){
        this.UUID =UUID;
    }
    public String getSUUID(){
        return this.UUID.toString();
    }
    public void setPic(ByteBuffer bImage, int length, String type, String h) {
        this.bImage = bImage;
        this.length = length;
        this.type=type;
        //this.date = d;
        this.hashtag = h;
    }

    public ByteBuffer getBuffer() {
        return this.bImage;
    }
    
    public String getHashtag(){
        return this.hashtag;
    }
    public void setHashtag(String h){
        this.hashtag = h;
    }
    
    public int getLength() {
        return this.length;
    }
    
    public String getType(){
        return this.type;
    }

    public byte[] getBytes() {
        byte image[] = Bytes.getArray(bImage);
        return image;
    }

}
