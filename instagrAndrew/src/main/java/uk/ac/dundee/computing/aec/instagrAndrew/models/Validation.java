/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uk.ac.dundee.computing.aec.instagrAndrew.models;

import com.datastax.driver.core.Cluster;
import javax.ejb.Stateless;

/**
 *
 * @author Andrew
 */
@Stateless
public class Validation {

    public Validation(){}
    
    Cluster cluster;
    boolean valid;
    String errorMessage;

    public void setCluster(Cluster cluster) {
        this.cluster = cluster;
    }
   
    public Validation(String err, boolean val){
        this.valid = val;
        this.errorMessage = err;
    }
    
    public boolean getValidity(){ return this.valid; }
    public String getErrorMessage(){ return this.errorMessage; }
    
}
