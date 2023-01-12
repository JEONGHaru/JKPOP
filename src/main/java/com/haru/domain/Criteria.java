package com.haru.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	
	//ペインティングための変数
	private int pageNum; //現在のページ
	private int amount; //一つのページに表示されるデータの数
	
	//検索のための変数
	private String field; //検索項目
	private String keyword; //検索単語
	
	public Criteria() {
		this.pageNum = 1;
		this.amount = 10;
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	//検索に必要なfileを分け文字別でGetterを作成
		//-- #{typeArr}
		public String[] getTypeArr() {
			//fieldがnullの場合空の配列をnullではない場合文字ずつ出して配列に
			return field == null ? new String[]{} : field.split("");
		}
}
