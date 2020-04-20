package group14_train;

import java.sql.Timestamp;

public class SeatTuple {
	private int train_ID;
	private String Transit_line_name;
	private int occupied_seat_num;
	private Timestamp date;
	public int getTrain_ID() {
		return train_ID;
	}
	public void setTrain_ID(int train_ID) {
		this.train_ID = train_ID;
	}
	public String getTransit_line_name() {
		return Transit_line_name;
	}
	public void setTransit_line_name(String transit_line_name) {
		Transit_line_name = transit_line_name;
	}
	public Timestamp getDate() {
		return date;
	}
	public int getOccupied_seat_num() {
		return occupied_seat_num;
	}
	public void setOccupied_seat_num(int occupied_seat_num) {
		this.occupied_seat_num = occupied_seat_num;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
}
