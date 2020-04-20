package group14_train;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
	
	public static ArrayList<QueryResultTuple> resultSetToList(ResultSet rs) throws SQLException{
		ArrayList<QueryResultTuple> list = new ArrayList<>();
		while(rs.next()) {
			QueryResultTuple tuple = new QueryResultTuple();
			
			tuple.setTrain_ID(rs.getInt(1));
			tuple.setTrainsit_line_name(rs.getString(2));
			tuple.setOrigin_arrival_time(rs.getTimestamp(3));
			tuple.setOrigin_departure_time(rs.getTimestamp(4));
			tuple.setDestination_arrival_time(rs.getTimestamp(5));
			tuple.setDestination_departure_time(rs.getTimestamp(6));	
			tuple.setOrigin_ID(rs.getInt(7));
			tuple.setDestination_ID(rs.getInt(8));
			tuple.setTrainsit_line_name(rs.getString(9));
			tuple.setEconomy_fare(rs.getFloat(10));
			tuple.setBussiness_fare(rs.getFloat(11));
			tuple.setFirst_fare(rs.getFloat(12));
			tuple.setOrigin_station_name(rs.getString(14));
			tuple.setOrigin_city(rs.getString(15));
			tuple.setOrigin_state(rs.getString(16));
			tuple.setDestination_station_name(rs.getString(18));
			tuple.setDestination_city(rs.getString(19));
			tuple.setDestination_state(rs.getString(20));
			tuple.setTrain_max_seats(rs.getInt(22));
			list.add(tuple);
		}
		return list;
	}
	
	public static ArrayList<SeatTuple> resultSetToList2(ResultSet rs) throws SQLException{
		ArrayList<SeatTuple> list = new ArrayList<>();
		while(rs.next()) {
			SeatTuple tuple = new SeatTuple();
			tuple.setTrain_ID(rs.getInt(1));
			tuple.setTransit_line_name(rs.getString(2));
			tuple.setOccupied_seat_num(rs.getInt(3));
			tuple.setDate(rs.getTimestamp(4));
			list.add(tuple);
		}
		return list;
	}
	
	public static ArrayList<QueryResultTuple> limit_date(ArrayList<QueryResultTuple> list, boolean approximate, ResultSet reservation_count, String userTime) throws ParseException, SQLException{
		ArrayList<QueryResultTuple> processed = new ArrayList<QueryResultTuple>();
		ArrayList<SeatTuple> seats = resultSetToList2(reservation_count);
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		List<String> user_dates = new ArrayList<>();
		if(approximate){
		    for(int i = -3; i <= 3; i++) {
			    String dt = userTime;  // Start date
			    Calendar c = Calendar.getInstance();
			    c.setTime(dateFormat.parse(dt));
			    c.add(Calendar.DATE, i);  // number of days to add
			    dt = dateFormat.format(c.getTime());  // dt is now the new date
			    user_dates.add(dt);
		    }
		}else user_dates.add(userTime);
		for(String target_date : user_dates) {
			for(QueryResultTuple info_tuple : list){
				info_tuple.setAvailable(info_tuple.getTrain_max_seats());
				info_tuple.setDate(target_date);
				for(SeatTuple seat_tuple : seats) {
					//transfer the timestamp of seat to string
					Timestamp ts = seat_tuple.getDate();
					Date date = new Date();
					date.setTime(ts.getTime());
					String goDate = dateFormat.format(date);
					if(!goDate.equals(target_date))	continue;
					if(info_tuple.getTrain_ID() == seat_tuple.getTrain_ID() && info_tuple.getTrainsit_line_name().equals(seat_tuple.getTransit_line_name())) {
						info_tuple.setAvailable(info_tuple.getAvailable() - seat_tuple.getOccupied_seat_num());
						continue;
					}
				}
				processed.add(info_tuple.clone());
			}
		}
		return processed;
	}
	
	public static String toJsArray(List<QueryResultTuple> list) {
	    StringBuffer sb = new StringBuffer();
	    sb.append("[");
	    for(QueryResultTuple tuple : list){
	    	sb.append("{");
	    	sb.append("train_ID:" + tuple.getTrain_ID() + ",");
	    	sb.append("line_name:" + tuple.getTrainsit_line_name() + ",");
	    	sb.append("origin_arrival_time:" + tuple.getOrigin_arrival_time() + ",");
	    	sb.append("origin_departure_time:" + tuple.getOrigin_departure_time() + ",");
	    	sb.append("destination_arrival_time:" + tuple.getDestination_arrival_time() + ",");
	    	sb.append("destination_departure_time:" + tuple.getDestination_departure_time() + ",");
	    	sb.append("economy_fare:" + tuple.getEconomy_fare() + ",");
	    	sb.append("business_fare:" + tuple.getBussiness_fare() + ",");
	    	sb.append("first_fare:" + tuple.getOrigin_station_name() + ",");
	    	sb.append("origin_name:" + tuple.getDestination_station_name() + ",");
	    	sb.append("destination_name:" + tuple.getAvailable() + ",");
	    	sb.append("available:" + tuple.getDate() + ",");
		    if(sb.length() > 0 && sb.charAt(sb.length() - 1) == ',')	sb.deleteCharAt(sb.length() - 1);
	       	sb.append("}");
	       	sb.append(",");
	    }
	    if(sb.length() > 0 && sb.charAt(sb.length() - 1) == ',') sb.deleteCharAt(sb.length() - 1);
	    sb.append("];");
	    return sb.toString();
	}
	public static String toHtml(List<QueryResultTuple> list) {
		StringBuffer sb = new StringBuffer();
		for(QueryResultTuple tuple : list){
			sb.append("<tr>");
			sb.append("<td>" + tuple.getTrain_ID() + "</td>");
			sb.append("<td>" + tuple.getTrainsit_line_name() + "</td>");
			sb.append("<td>" + tuple.getOrigin_arrival_time() + "</td>");
			sb.append("<td>" + tuple.getOrigin_departure_time() + "</td>");
			sb.append("<td>" + tuple.getDestination_arrival_time() + "</td>");
			sb.append("<td>" + tuple.getDestination_departure_time() + "</td>");
			sb.append("<td>" + tuple.getEconomy_fare() + "</td>");
			sb.append("<td>" + tuple.getBussiness_fare() + "</td>");
			sb.append("<td>" + tuple.getFirst_fare() + "</td>");
			sb.append("<td>" + tuple.getOrigin_station_name() + "</td>");
			sb.append("<td>" + tuple.getDestination_station_name() + "</td>");
			sb.append("<td>" + tuple.getAvailable() + "</td>");
			sb.append("<td>" + tuple.getDate() + "</td>");
			sb.append("</tr>");
		}
		return sb.toString();
	}
	
	
	
	
	public static String big_query = "select * from (select origin.train_ID, origin.transit_line_name, origin.arrival_time as origin_arrival_time, origin.departure_time as origin_departure_time, destination.arrival_time as destination_arrival_time, destination.departure_time as destination_departure_time,origin.station_ID as origin_ID, destination.station_ID as destination_ID from Stop origin, Stop destination where origin.train_ID = destination.train_ID and origin.transit_line_name = destination.transit_line_name and origin.departure_time < destination.arrival_time) as TA inner join (select t1.transit_line_name, t1.one_way_fee as economy_fare, t2.one_way_fee as bussiness_fare, t3.one_way_fee as first_fare from Economy_fare t1, Business_fare t2, First_fare t3 where t1.transit_line_name = t2.transit_line_name and t2.transit_line_name = t3.transit_line_name) as TB on TA.transit_line_name = TB.transit_line_name inner join (select station_ID, station_name as origin_station_name, city as origin_city, state as origin_state from Station) as S1 on S1.station_ID = TA.origin_ID inner join (select station_ID, station_name as destination_station_name, city as destination_city, state as destination_state from Station) as S2 on S2.station_ID = TA.destination_ID inner join (select train_ID, total_number_of_seats from Train) as TrainTable on TA.train_ID = TrainTable.train_ID where S1.origin_city = ? and S2.destination_city = ?;";
}
