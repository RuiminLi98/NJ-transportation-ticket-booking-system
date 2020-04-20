package group14_train;

import java.sql.Timestamp;

public class QueryResultTuple {
	private int train_ID;
	private String trainsit_line_name;
	private Timestamp origin_arrival_time;
	private Timestamp origin_departure_time;
	private Timestamp destination_arrival_time;
	private Timestamp destination_departure_time;
	private int origin_ID;
	private int destination_ID;
	private double economy_fare;
	private double bussiness_fare;
	private double first_fare;
	private String origin_station_name;
	private String origin_city;
	private String origin_state;
	private String destination_station_name;
	private String destination_city;
	private String destination_state;
	private int train_max_seats;
	private int available;
	private String date;
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getTrain_ID() {
		return train_ID;
	}
	public int getAvailable() {
		return available;
	}
	public void setAvailable(int available) {
		this.available = available;
	}
	public void setTrain_ID(int train_ID) {
		this.train_ID = train_ID;
	}
	public String getTrainsit_line_name() {
		return trainsit_line_name;
	}
	public void setTrainsit_line_name(String trainsit_line_name) {
		this.trainsit_line_name = trainsit_line_name;
	}
	public Timestamp getOrigin_arrival_time() {
		return origin_arrival_time;
	}
	public void setOrigin_arrival_time(Timestamp origin_arrival_time) {
		this.origin_arrival_time = origin_arrival_time;
	}
	public Timestamp getOrigin_departure_time() {
		return origin_departure_time;
	}
	public void setOrigin_departure_time(Timestamp origin_departure_time) {
		this.origin_departure_time = origin_departure_time;
	}
	public Timestamp getDestination_arrival_time() {
		return destination_arrival_time;
	}
	public void setDestination_arrival_time(Timestamp destination_arrival_time) {
		this.destination_arrival_time = destination_arrival_time;
	}
	public Timestamp getDestination_departure_time() {
		return destination_departure_time;
	}
	public void setDestination_departure_time(Timestamp destination_departure_time) {
		this.destination_departure_time = destination_departure_time;
	}
	public int getOrigin_ID() {
		return origin_ID;
	}
	public void setOrigin_ID(int origin_ID) {
		this.origin_ID = origin_ID;
	}
	public int getDestination_ID() {
		return destination_ID;
	}
	public void setDestination_ID(int destination_ID) {
		this.destination_ID = destination_ID;
	}
	public double getEconomy_fare() {
		return economy_fare;
	}
	public void setEconomy_fare(double economy_fare) {
		this.economy_fare = economy_fare;
	}
	public double getBussiness_fare() {
		return bussiness_fare;
	}
	public void setBussiness_fare(double bussiness_fare) {
		this.bussiness_fare = bussiness_fare;
	}
	public double getFirst_fare() {
		return first_fare;
	}
	public void setFirst_fare(double first_fare) {
		this.first_fare = first_fare;
	}
	public String getOrigin_station_name() {
		return origin_station_name;
	}
	public void setOrigin_station_name(String origin_station_name) {
		this.origin_station_name = origin_station_name;
	}
	public String getOrigin_city() {
		return origin_city;
	}
	public void setOrigin_city(String origin_city) {
		this.origin_city = origin_city;
	}
	public String getOrigin_state() {
		return origin_state;
	}
	public void setOrigin_state(String origin_state) {
		this.origin_state = origin_state;
	}
	public String getDestination_station_name() {
		return destination_station_name;
	}
	public void setDestination_station_name(String destination_station_name) {
		this.destination_station_name = destination_station_name;
	}
	public String getDestination_city() {
		return destination_city;
	}
	public void setDestination_city(String destination_city) {
		this.destination_city = destination_city;
	}
	public String getDestination_state() {
		return destination_state;
	}
	public void setDestination_state(String destination_state) {
		this.destination_state = destination_state;
	}
	public int getTrain_max_seats() {
		return train_max_seats;
	}
	public void setTrain_max_seats(int train_max_seats) {
		this.train_max_seats = train_max_seats;
	}
	
	@Override
	public String toString() {
		return "QueryResultTuple [train_ID=" + train_ID + ", trainsit_line_name=" + trainsit_line_name
				+ ", origin_arrival_time=" + origin_arrival_time + ", origin_departure_time=" + origin_departure_time
				+ ", destination_arrival_time=" + destination_arrival_time + ", destination_departure_time="
				+ destination_departure_time + ", origin_ID=" + origin_ID + ", destination_ID=" + destination_ID
				+ ", economy_fare=" + economy_fare + ", bussiness_fare=" + bussiness_fare + ", first_fare=" + first_fare
				+ ", origin_station_name=" + origin_station_name + ", origin_city=" + origin_city + ", origin_state="
				+ origin_state + ", destination_station_name=" + destination_station_name + ", destination_city="
				+ destination_city + ", destination_state=" + destination_state + ", train_max_seats=" + train_max_seats
				+ ", available=" + available + ", date=" + date + "]";
	}
	public QueryResultTuple clone() {
		QueryResultTuple clone = new QueryResultTuple();
		clone.train_ID = this.getTrain_ID();
		clone.trainsit_line_name = this.getTrainsit_line_name();
		clone.origin_arrival_time = this.getOrigin_arrival_time();
		clone.origin_departure_time = this.getOrigin_departure_time();
		clone.destination_arrival_time = this.getDestination_arrival_time();
		clone.destination_departure_time = this.getDestination_departure_time();
		clone.origin_ID = this.getOrigin_ID();
		clone.destination_ID = this.getDestination_ID();
		clone.economy_fare = this.getEconomy_fare();
		clone.bussiness_fare = this.getBussiness_fare();
		clone.first_fare = this.getFirst_fare();
		clone.origin_station_name = this.getOrigin_station_name();
		clone.origin_city = this.getOrigin_city();
		clone.origin_state = this.getOrigin_state();
		clone.destination_station_name = this.getDestination_station_name();
		clone.destination_city = this.getDestination_city();
		clone.destination_state = this.getDestination_state();
		clone.train_max_seats = this.getTrain_max_seats();
		clone.available = this.getAvailable();
		clone.date = this.getDate();
		return clone;
	}
}
