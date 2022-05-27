package dao;

import java.util.Date;

public class MemberDto {

	private int member_idx;
	private String member_id;
	private String member_pw;
	private String member_name;
	private String phone_no;
	private int member_auth;
	private Date join_date;
	private String fav_game;

	public int getMember_idx() {
		return member_idx;
	}

	public void setMember_idx(int member_idx) {
		this.member_idx = member_idx;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getMember_pw() {
		return member_pw;
	}

	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getPhone_no() {
		return phone_no;
	}

	public void setPhone_no(String phone_no) {
		this.phone_no = phone_no;
	}

	public int getMember_auth() {
		return member_auth;
	}

	public void setMember_auth(int member_auth) {
		this.member_auth = member_auth;
	}

	public Date getJoin_date() {
		return join_date;
	}

	public void setJoin_date(Date join_date) {
		this.join_date = join_date;
	}

	public String getFav_game() {
		return fav_game;
	}

	public void setFav_game(String fav_game) {
		this.fav_game = fav_game;
	}

	@Override
	public boolean equals(Object obj) {
		if (obj instanceof MemberDto) {
			MemberDto dto = (MemberDto) obj;
			return (this.member_idx == dto.getMember_idx());
		}
		return false;
	}

}
