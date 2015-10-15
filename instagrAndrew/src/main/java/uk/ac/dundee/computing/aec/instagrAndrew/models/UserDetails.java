/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uk.ac.dundee.computing.aec.instagrAndrew.models;

import com.datastax.driver.core.Cluster;
import java.util.Set;
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
    
   
    public UserDetails(String FN, String SN, Set<String> em){
        this.name = FN + " " + SN;
        this.email = em;
    }
    
    public String getName(){ return this.name; }
    public Set<String> getEmail(){ return this.email; }
    
}
