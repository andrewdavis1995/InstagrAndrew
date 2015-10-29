package uk.ac.dundee.computing.aec.instagrAndrew.lib;

import java.util.ArrayList;
import java.util.List;

import com.datastax.driver.core.*;

public final class Keyspaces {

    public Keyspaces() {

    }

    public static void SetUpKeySpaces(Cluster c) {
        try {
            //Add some keyspaces here
            String createkeyspace = "create keyspace if not exists instagrAndrew  WITH replication = {'class':'SimpleStrategy', 'replication_factor':1}";
            String CreatePicTable = "CREATE TABLE if not exists instagrAndrew.Pics ("
                    + " user varchar,"
                    + " picid uuid, "
                    + " interaction_time timestamp,"
                    + " title varchar,"
                    + " image blob,"
                    + " thumb blob,"
                    + " processed blob,"
                    + " imagelength int,"
                    + " thumblength int,"
                    + " processedlength int,"
                    + " type varchar,"
                    + " name varchar,"
                    + " hashtag varchar,"
                    + " PRIMARY KEY (picid)"
                    + ")";
            String Createuserpiclist = "CREATE TABLE if not exists instagrAndrew.userpiclist (\n"
                    + "picid uuid,\n"
                    + "user varchar,\n"
                    + "pic_added timestamp,\n"
                    + " hashtag varchar,\n"
                    + "PRIMARY KEY (user,pic_added)\n"
                    + ") WITH CLUSTERING ORDER BY (pic_added desc);";
            String CreateAddressType = "CREATE TYPE if not exists instagrAndrew.address (\n"
                    + "      street text,\n"
                    + "      city text,\n"
                    + "      zip int\n"
                    + "  );";
            String CreateUserProfile = "CREATE TABLE if not exists instagrAndrew.userprofiles (\n"
                    + "      login text PRIMARY KEY,\n"
                    + "      password text,\n"
                    + "      profilepic UUID,\n"
                    + "      first_name text,\n"
                    + "      last_name text,\n"
                    + "      email set<text>,\n"
                    + "      addresses  map<text, frozen <address>>\n"
                    + "  );";
            String CreateComments = "CREATE TABLE if not exists instagrAndrew.comments (\n"
                    + "      image_id UUID,\n"
                    + "      date timestamp,\n"
                    + "      content text,\n"
                    + "      username text,\n"
                    + "      PRIMARY KEY (image_id, date)\n"
                    + "  );";
            
            String CreateLike = "CREATE TABLE if not exists instagrAndrew.likes (\n"
                    + "      image_id UUID,\n"
                    + "      liker text,\n"
                    + "      PRIMARY KEY (image_id, liker)\n"
                    + "  );";
            
            String CreateFollows = "CREATE TABLE if not exists instagrAndrew.follows (\n"
                    + "      follower varchar,\n"
                    + "      followee varchar,\n"
                    + "      PRIMARY KEY (follower, followee)\n"
                    + "  );";
            
            Session session = c.connect();
            try {
                PreparedStatement statement = session
                        .prepare(createkeyspace);
                BoundStatement boundStatement = new BoundStatement(
                        statement);
                ResultSet rs = session
                        .execute(boundStatement);
                System.out.println("created instagrAndrew ");
            } catch (Exception et) {
                System.out.println("Can't create instagrAndrew " + et);
            }

            //now add some column families 
            System.out.println("" + CreatePicTable);

            try {
                SimpleStatement cqlQuery = new SimpleStatement(CreatePicTable);
                session.execute(cqlQuery);
            } catch (Exception et) {
                System.out.println("Can't create Pic table " + et);
            }
            System.out.println("" + Createuserpiclist);

            try {
                SimpleStatement cqlQuery = new SimpleStatement(Createuserpiclist);
                session.execute(cqlQuery);
            } catch (Exception et) {
                System.out.println("Can't create user pic list table " + et);
            }
            
            System.out.println("" + CreateAddressType);
            try {
                SimpleStatement cqlQuery = new SimpleStatement(CreateAddressType);
                session.execute(cqlQuery);
            } catch (Exception et) {
                System.out.println("Can't create Address type " + et);
            }
            
            System.out.println("" + CreateUserProfile);
            try {
                SimpleStatement cqlQuery = new SimpleStatement(CreateUserProfile);
                session.execute(cqlQuery);
            } catch (Exception et) {
                System.out.println("Can't create Address Profile " + et);
            }
            
            System.out.println("" + CreateComments);
            try {
                SimpleStatement cqlQuery = new SimpleStatement(CreateComments);
                session.execute(cqlQuery);
            } catch (Exception et) {
                System.out.println("Can't create Comments " + et);
            }
            
            System.out.println("" + CreateLike);
            try {
                SimpleStatement cqlQuery = new SimpleStatement(CreateLike);
                session.execute(cqlQuery);
            } catch (Exception et) {
                System.out.println("Can't create Likes " + et);
            }
            
            System.out.println("" + CreateFollows);
            try {
                SimpleStatement cqlQuery = new SimpleStatement(CreateFollows);
                session.execute(cqlQuery);
            } catch (Exception et) {
                System.out.println("Can't create Likes " + et);
            }
            
            session.close();

        } catch (Exception et) {
            System.out.println("Other keyspace or column definition error" + et);
        }

    }
}
