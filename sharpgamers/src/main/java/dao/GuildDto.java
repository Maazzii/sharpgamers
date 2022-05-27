package dao;

import java.util.Date;

public class GuildDto {
	private int guildId;
	private String guildName;
	private String guildDesc;
	private int guildMasterIdx;
	private String guildMembersIdx;
	private String guildJoinWaitingIdx;
	private Date guildRegDate;
	private int game_id;
	
	public int getGuildId() {
		return guildId;
	}
	public void setGuildId(int guildId) {
		this.guildId = guildId;
	}
	public String getGuildName() {
		return guildName;
	}
	public void setGuildName(String guildName) {
		this.guildName = guildName;
	}
	public String getGuildDesc() {
		return guildDesc;
	}
	public void setGuildDesc(String guildDesc) {
		this.guildDesc = guildDesc;
	}
	public int getGuildMasterIdx() {
		return guildMasterIdx;
	}
	public void setGuildMasterIdx(int guildMasterIdx) {
		this.guildMasterIdx = guildMasterIdx;
	}
	public String getGuildMembersIdx() {
		return guildMembersIdx;
	}
	public void setGuildMembersIdx(String guildMembersIdx) {
		this.guildMembersIdx = guildMembersIdx;
	}
	public String getGuildJoinWaitingIdx() {
		return guildJoinWaitingIdx;
	}
	public void setGuildJoinWaitingIdx(String guildJoinWaitingIdx) {
		this.guildJoinWaitingIdx = guildJoinWaitingIdx;
	}
	public Date getGuildRegDate() {
		return guildRegDate;
	}
	public void setGuildRegDate(Date guildRegDate) {
		this.guildRegDate = guildRegDate;
	}
	public int getGame_id() {
		return game_id;
	}
	public void setGame_id(int game_id) {
		this.game_id = game_id;
	}
}
