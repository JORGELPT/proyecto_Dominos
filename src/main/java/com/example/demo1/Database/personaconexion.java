package com.example.demo1.Database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class personaconexion {

    Connection con = null;
    PreparedStatement ps;
    ResultSet rs;
    Statement st;

    // Query placeholder — kept for reference only; email must be quoted in real SQL
    String Query = "Insert into user values (1, 'Albert', 'polanco', 'los castillos', '9089089089', 'albertp@gmail.com')";
}
