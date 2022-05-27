package dao;

public class GameDto {
	private int game_id;
	private String game_platform;
	private String game_name;
	private String game_img_src;
	private String game_link;
	
	public int getGame_id() {
		return game_id;
	}
	public void setGame_id(int game_id) {
		this.game_id = game_id;
	}
	public String getGame_Platform() {
		return game_platform;
	}
	public void setGame_Platform(String game_platform) {
		this.game_platform = game_platform;
	}
	public String getGame_name() {
		return game_name;
	}
	public void setGame_name(String game_name) {
		this.game_name = game_name;
	}
	public String getGame_img_src() {
		return game_img_src;
	}
	public void setGame_img_src(String game_img_src) {
		this.game_img_src = game_img_src;
	}
	public String getGame_link() {
		return game_link;
	}
	public void setGame_link(String game_link) {
		this.game_link = game_link;
	}
	
	
}
