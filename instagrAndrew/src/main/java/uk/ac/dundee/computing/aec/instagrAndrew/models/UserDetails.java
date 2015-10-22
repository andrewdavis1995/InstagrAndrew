/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uk.ac.dundee.computing.aec.instagrAndrew.models;

import com.datastax.driver.core.Cluster;
import java.util.Set;
import java.util.UUID;
import javax.ejb.Stateless;

/**
 *
 * @author Andrew
 */
@Stateless
public class UserDetails {

    public UserDetails(){}
    
    String name;
    Set<String> email;
    String username;
    UUID profilePic;
    String password;
    String firstName;
    String surname;
    
    
    public UserDetails(String us, String FN, String SN, UUID PP){
        this.name = FN + " " + SN;
        this.username = us;
        this.profilePic = PP;
    }
    
    public UserDetails(String us, String FN, String SN, UUID PP, Set<String> em){
        this.name = FN + " " + SN;
        this.username = us;
        this.profilePic = PP;
        this.email = em;
    }
    
    public UserDetails(String us, String FN, String SN, String pass, Set<String> em){
        this.firstName = FN;
        this.surname = SN;
        this.username = us;
        this.password = pass;
        this.email = em;
    }
   
    public UserDetails(String FN, String SN, Set<String> em){
        this.name = FN + " " + SN;
        this.email = em;
    }
    
    public String getName(){ return this.name; }
    public String getForename(){ return this.firstName; }
    public String getSurname(){ return this.surname; }
    public String getPassword(){ return this.password; }
    public Set<String> getEmail(){ return this.email; }
    public String getUsername(){ return this.username; }
    public UUID getProfilePic(){ return this.profilePic; }
    
}
