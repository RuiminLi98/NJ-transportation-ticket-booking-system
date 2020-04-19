package group14_train;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class Tools {
	public static ResultSet SQL_ASK(String query) throws SQLException {
		//get database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		//ask SQL
		ResultSet result = stmt.executeQuery(query);
		
		//close connection
		result.close();
		stmt.close();
		con.close();
		return result;
	}
	
	public static List<Location> ResultSetToList(ResultSet rs) throws SQLException{
		List<Location> locations = new ArrayList<>();
		while(rs.next()) {
			String state = rs.getString("state");
			String city = rs.getString("city");
			Location location = new Location(state, city);
			locations.add(location);
		}
		return locations;
	}
	
	public static String big_query = "select * from (select origin.train_ID, origin.transit_line_name, origin.arrival_time as origin_arrival_time, origin.departure_time as origin_departure_time, destination.arrival_time as destination_arrival_time, destination.departure_time as destination_departure_time,origin.station_ID as origin_ID, destination.station_ID as destination_ID from Stop origin, Stop destination where origin.train_ID = destination.train_ID and origin.transit_line_name = destination.transit_line_name and origin.departure_time < destination.arrival_time) inner join (select t1.transit_line_name, t1.one_way_fee as economy_fare, t2.one_way_fee as bussiness_fare, t3.one_way_fee as first_fare from Economy_fare t1, Business_fare t2, First_fare t3 where t1.transit_line_name = t2.transit_line_name and t2.transit_line_name = t3.transit_line_name) t2 on t1.transit_line_name = t2.transit_line_name  where origin_ID = ? and destination = ? and origin_departure_time >= ? and origin_departure_time <= ?;";
}
